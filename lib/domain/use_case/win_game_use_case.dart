import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/leaderboard_record_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';
import 'package:summer_budget_game/domain/repository/game_repository.dart';

import '../failure/unfolding_failure.dart';

//Запись информации об игроке в таблицу рекордов
@lazySingleton
class WinGameUseCase extends UseCase<SaveRecordEntity, String> {
  final GameRepository gameRepository;

  WinGameUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(String name) async {
    final saveRecordResult = await gameRepository.readSaveRecord();

    return await saveRecordResult.fold(
      (failure) async => Left(UnfoldingFailure()),
      (record) async {
        final leaderboardRecord = LeaderboardRecordEntity(
          name: name,
          score: record.characterRecord.score,
          days: record.gameRecord.currentDay,
          finIQ: record.characterRecord.finIQ,
          balance: record.characterRecord.balance + record.characterRecord.savings,
          time: DateTime.now().toIso8601String(),
        );

        final result = await gameRepository.writeLeaderboard(leaderboardRecord);

        return result.fold(
          (failure) => Left(UnfoldingFailure()),
          (_) => Right(record),
        );
      },
    );
  }
}