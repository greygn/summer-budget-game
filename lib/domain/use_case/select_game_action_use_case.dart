import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

import '../repository/game_repository.dart';

//Выбор действия, применение эффектов
class SelectGameActionUseCase extends UseCase<SaveRecordEntity, GameActionEntity>{
  final GameRepository gameRepository;

  SelectGameActionUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(GameActionEntity gameAction) async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    
    return await saveRecordResult.fold(
      (failure) async => Left(failure),
      (record) async {
        final updatedRecord = record.copyWith(
          characterRecord: record.characterRecord.copyWith(
            balance: record.characterRecord.balance + gameAction.moneyDelta,
            savings: record.characterRecord.savings + gameAction.savingsDelta,
            happiness: record.characterRecord.happiness + gameAction.happinessDelta,
            finIQ: record.characterRecord.finIQ + gameAction.finIQDelta,
            score: record.characterRecord.score + gameAction.pointsForAction,
          ),
          gameRecord: record.gameRecord.copyWith(
            timeLeft: record.gameRecord.timeLeft - gameAction.timeCost,
          ),
        );

        final writeResult = await gameRepository.writeSaveRecord(updatedRecord);
        return writeResult.fold(
          (f) => Left(f),
          (_) => Right(updatedRecord),
        );
      },
    );
  }
}