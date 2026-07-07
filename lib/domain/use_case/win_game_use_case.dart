import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/leaderboard_record_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';
import 'package:summer_budget_game/domain/repository/game_repository.dart';

//Запись информации об игроке в таблицу рекордов
class WinGameUseCase extends UseCase<SaveRecordEntity, void> {
  final GameRepository gameRepository;

  WinGameUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(void params) async {
    final saveRecordResult = await gameRepository.readSaveRecord();

    return await saveRecordResult.fold(
      (failure) async => Left(failure),
      (record) async {
        final leaderboardRecord = LeaderboardRecordEntity(
          name: record.name,
          score: record.characterRecord.score,
          days: record.gameRecord.currentDay,
          finIQ: record.characterRecord.finIQ,
          time: DateTime.now().toIso8601String(),
        );

        final result = await gameRepository.writeLeaderboard(leaderboardRecord);

        return result.fold(
          (failure) => Left(failure),
          (_) => Right(record),
        );
      },
    );
  }
}