import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_event_entity.dart';
import 'package:summer_budget_game/domain/entity/game_event_option_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

import '../repository/game_repository.dart';

//Выбор варианта события, применение эффектов
class SelectGameEventOption extends UseCase<SaveRecordEntity, GameEventOptionEntity>{
  final GameRepository gameRepository;

  SelectGameEventOption({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(GameEventOptionEntity params) async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    
    return await saveRecordResult.fold(
      (failure) async => Left(failure),
      (record) async {
        final updatedRecord = record.copyWith(
          characterRecord: record.characterRecord.copyWith(
            balance: record.characterRecord.balance + params.moneyDelta,
            happiness: record.characterRecord.happiness + params.happinessDelta,
            finIQ: record.characterRecord.finIQ + params.finIQDelta,
            score: record.characterRecord.score + params.pointsDelta,
          ),
          gameRecord: record.gameRecord.copyWith(
            currentEvent: const GameEventEntity(ID: 0),
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

//применение эффекта от выбора в событии (если они там есть)