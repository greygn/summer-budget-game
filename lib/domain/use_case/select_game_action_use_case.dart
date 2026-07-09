import 'package:dartz/dartz.dart';
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
        final actualTimeLeft = record.gameRecord.timeLeft;
        if (actualTimeLeft < gameAction.timeCost) {
          return Left(InsufficientTimeFailure());
        }

        final inflation = record.gameRecord.inflationLevel;
        final effectiveMoneyDelta = gameAction.moneyDelta < 0 
            ? (gameAction.moneyDelta * inflation).round() 
            : gameAction.moneyDelta;

        final updatedRecord = record.copyWith(
          characterRecord: record.characterRecord.copyWith(
            balance: record.characterRecord.balance + effectiveMoneyDelta,
            savings: record.characterRecord.savings + gameAction.savingsDelta,
            happiness: record.characterRecord.happiness + gameAction.happinessDelta,
            finIQ: record.characterRecord.finIQ + gameAction.finIQDelta,
            score: record.characterRecord.score + gameAction.pointsForAction,
          ),
          gameRecord: record.gameRecord.copyWith(
            timeLeft: record.gameRecord.timeLeft - gameAction.timeCost,
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