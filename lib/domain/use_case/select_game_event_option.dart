import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_event_entity.dart';
import 'package:summer_budget_game/domain/entity/game_event_option_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';
import 'package:summer_budget_game/domain/failure/writing_failure.dart';

import '../repository/game_repository.dart';
import 'check_state_use_case.dart';

//Выбор варианта события, применение эффектов
@lazySingleton
class SelectGameEventOption extends UseCase<SaveRecordEntity, GameEventOptionEntity>{
  final GameRepository gameRepository;
  final CheckStateUseCase checkStateUseCase;

  SelectGameEventOption({required this.gameRepository, required this.checkStateUseCase});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(GameEventOptionEntity params) async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    
    return await saveRecordResult.fold(
      (failure) async => Left(failure),
      (record) async {
        final inflation = record.gameRecord.inflationLevel;
        final effectiveMoneyDelta = params.moneyDelta < 0 
            ? (params.moneyDelta * inflation).round() 
            : params.moneyDelta;

        final updatedRecord = record.copyWith(
          characterRecord: record.characterRecord.copyWith(
            balance: record.characterRecord.balance + effectiveMoneyDelta,
            energy: (record.characterRecord.energy + params.energyDelta).clamp(-1, 100),
            happiness: (record.characterRecord.happiness + params.happinessDelta).clamp(-1, 100),
            finIQ: record.characterRecord.finIQ + params.finIQDelta,
            score: record.characterRecord.score + params.pointsDelta,
          ),
          gameRecord: record.gameRecord.copyWith(
            currentEvent: const GameEventEntity(ID: 0),
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