import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';
import 'package:summer_budget_game/domain/failure/unfolding_failure.dart';
import 'package:summer_budget_game/domain/use_case/check_state_use_case.dart';

import 'package:summer_budget_game/domain/entity/game_mode.dart';

import '../repository/game_repository.dart';

//Завершение дня, увеличение счётчика дней, увеличение энергии, проверка состояния
@lazySingleton
class EndDayUseCase extends UseCaseNoPrarms<SaveRecordEntity> {
  final GameRepository gameRepository;
  final CheckStateUseCase checkStateUseCase;

  static const defaultTimeLeft = 12;
  static const emergyIncrement = 10;
  static const inflationIncrement = 1.1;
  static const minSavingsRate = 0.01;
  static const maxSavingsRate = 0.03;

  EndDayUseCase({
    required this.gameRepository,
    required this.checkStateUseCase,
  });

  @override
  Future<Either<Failure, SaveRecordEntity>> call() async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    return await saveRecordResult.fold((failure) async => Left(UnfoldingFailure()), (
      record,
    ) async {
      var effectiveInflationLevel = record.gameRecord.inflationLevel;
      if (record.gameRecord.gameMode == GameMode.marathon && record.gameRecord.currentDay % 7 == 0){
        effectiveInflationLevel *= inflationIncrement;
      }

      final random = Random();
      final rate = minSavingsRate + random.nextDouble() * (maxSavingsRate - minSavingsRate);
      final savingsIncrement = (record.characterRecord.savings * rate).round();

      final nextDayRecord = record.copyWith(
        gameRecord: record.gameRecord.copyWith(
          currentDay: record.gameRecord.currentDay + 1,
          timeLeft: defaultTimeLeft,
          inflationLevel: effectiveInflationLevel
        ),
        characterRecord: record.characterRecord.copyWith(
          energy: (record.characterRecord.energy + emergyIncrement).clamp(-1, 100),
          savings: record.characterRecord.savings + savingsIncrement,
        ),
      );

      await gameRepository.writeSaveRecord(nextDayRecord);

      await checkStateUseCase();

      return await gameRepository.readSaveRecord();
    });
  }
}
