import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';
import 'package:summer_budget_game/domain/use_case/check_state_use_case.dart';

import '../repository/game_repository.dart';

class EndDayUseCase extends UseCaseNoPrarms<SaveRecordEntity> {
  final GameRepository gameRepository;

  EndDayUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call() async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    return await saveRecordResult.fold((failure) async => Left(failure), (
      record,
    ) async {
      final nextDayRecord = record.copyWith(
        gameRecord: record.gameRecord.copyWith(
          currentDay: record.gameRecord.currentDay + 1,
          timeLeft: 12,
        ),
        characterRecord: record.characterRecord.copyWith(
          energy: record.characterRecord.energy + 10,
        ),
      );

      checkStateUseCase();

      return await gameRepository.writeSaveRecord(nextDayRecord);
    });
  }
}
