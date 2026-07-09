import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/failure/unfolding_failure.dart';

import '../repository/game_repository.dart';


//Проверка на то, выполнены ли условия для окончания игры (победы или поражения)
class CheckStateUseCase extends UseCaseNoPrarms<void> {
  final GameRepository gameRepository;

  static const minBalanceCap = -10000;
  static const standardBalanceGoal = 100000;
  static const marathonBalanceGoal = 1000000;

  CheckStateUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, void>> call() async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    return await saveRecordResult.fold((failure) async => Left(UnfoldingFailure()), (
      record,
    ) async {
      if (record.characterRecord.balance < minBalanceCap) {
        await gameRepository.writeSaveRecord(
          record.copyWith(gameRecord: record.gameRecord.copyWith(isOver: true)),
        );
        return Right(null);
      }
      if (record.characterRecord.happiness < 0) {
        await gameRepository.writeSaveRecord(
          record.copyWith(gameRecord: record.gameRecord.copyWith(isOver: true)),
        );
        return Right(null);
      }
      if (record.gameRecord.gameMode == .standard &&
          record.gameRecord.currentDay > record.gameRecord.allowedDays) {
        await gameRepository.writeSaveRecord(
          record.copyWith(gameRecord: record.gameRecord.copyWith(isOver: true)),
        );
        return Right(null);
      }
      if (record.gameRecord.gameMode == .standard &&
      record.characterRecord.balance + record.characterRecord.savings >= standardBalanceGoal){
        await gameRepository.writeSaveRecord(
          record.copyWith(gameRecord: record.gameRecord.copyWith(isOver: true)),
        );
        return Right(null);
      }
      if (record.gameRecord.gameMode == .marathon &&
          record.characterRecord.balance + record.characterRecord.savings >= marathonBalanceGoal){
        await gameRepository.writeSaveRecord(
          record.copyWith(gameRecord: record.gameRecord.copyWith(isOver: true)),
        );
        return Right(null);
      }
      return Right(null);
    });
  }
}

