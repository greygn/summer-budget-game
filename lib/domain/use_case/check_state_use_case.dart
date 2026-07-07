import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';

import '../repository/game_repository.dart';


//Проверка на то, выполнены ли условия для окончания игры (победы или поражения)
class CheckStateUseCase extends UseCaseNoPrarms<void> {
  final GameRepository gameRepository;

  CheckStateUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, void>> call() async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    return await saveRecordResult.fold((failure) async => Left(failure), (
      record,
    ) async {
      if (record.characterRecord.balance < -10000) {
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
      record.characterRecord.balance + record.characterRecord.savings >= 100000){
        await gameRepository.writeSaveRecord(
          record.copyWith(gameRecord: record.gameRecord.copyWith(isOver: true)),
        );
        return Right(null);
      }
      if (record.gameRecord.gameMode == .marathon &&
          record.characterRecord.balance + record.characterRecord.savings >= 1000000){
        await gameRepository.writeSaveRecord(
          record.copyWith(gameRecord: record.gameRecord.copyWith(isOver: true)),
        );
        return Right(null);
      }
      return Right(null);
    });
  }
}

