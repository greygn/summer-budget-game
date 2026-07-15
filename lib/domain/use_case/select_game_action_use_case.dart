import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';
import 'package:summer_budget_game/domain/failure/insufficient_time_failure.dart';
import 'package:summer_budget_game/domain/failure/unfolding_failure.dart';
import 'package:summer_budget_game/domain/failure/writing_failure.dart';

import '../repository/game_repository.dart';
import 'check_state_use_case.dart';

//Выбор действия, применение эффектов
@lazySingleton
class SelectGameActionUseCase extends UseCase<SaveRecordEntity, GameActionEntity>{
  final GameRepository gameRepository;
  final CheckStateUseCase checkStateUseCase;

  SelectGameActionUseCase({required this.gameRepository, required this.checkStateUseCase});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(GameActionEntity gameAction) async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    
    return await saveRecordResult.fold(
      (failure) async => Left(UnfoldingFailure()),
      (record) async {
        final job = record.characterRecord.job;
        
        int effectiveTimeCost = gameAction.timeCost;
        int effectiveMoneyDelta = gameAction.moneyDelta;
        int effectiveEnergyDelta = gameAction.energyDelta;
        int effectiveHappinessDelta = gameAction.happinessDelta;

        if (gameAction.isJobAction) {
          double timeMult = 1.0;
          double moneyMult = 1.0;
          double effortMult = 1.0;

          if (gameAction.ID == GameActionEntity.gigId) {
            timeMult = 0.5;
            moneyMult = 0.4;
            effortMult = 0.4;
          } else if (gameAction.ID == GameActionEntity.overtimeId) {
            timeMult = 1.5;
            moneyMult = 2.0;
            effortMult = 1.5;
          }

          effectiveTimeCost = (job.timeCost * timeMult).round();
          effectiveMoneyDelta = (job.salary * moneyMult).round();
          effectiveEnergyDelta = (job.energyCost * effortMult).round();
          effectiveHappinessDelta = (job.happinessCost * effortMult).round();
        }

        final actualTimeLeft = record.gameRecord.timeLeft;
        if (actualTimeLeft < effectiveTimeCost) {
          return Left(InsufficientTimeFailure());
        }

        final inflation = record.gameRecord.inflationLevel;
        final finalMoneyDelta = effectiveMoneyDelta < 0 
            ? (effectiveMoneyDelta * inflation).round() 
            : effectiveMoneyDelta;

        final updatedRecord = record.copyWith(
          characterRecord: record.characterRecord.copyWith(
            balance: record.characterRecord.balance + finalMoneyDelta,
            savings: record.characterRecord.savings + gameAction.savingsDelta,
            happiness: (record.characterRecord.happiness + effectiveHappinessDelta).clamp(-1, 100),
            finIQ: record.characterRecord.finIQ + gameAction.finIQDelta,
            score: record.characterRecord.score + gameAction.pointsForAction,
            energy: (record.characterRecord.energy + effectiveEnergyDelta).clamp(-1, 100)
          ),
          gameRecord: record.gameRecord.copyWith(
            timeLeft: record.gameRecord.timeLeft - effectiveTimeCost,
          ),
        );

        await checkStateUseCase();

        final writeResult = await gameRepository.writeSaveRecord(updatedRecord);
        return writeResult.fold(
          (f) => Left(WritingFailure()),
          (_) => Right(updatedRecord),
        );
      },
    );
  }
}