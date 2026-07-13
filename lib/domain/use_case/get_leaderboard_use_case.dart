import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/leaderboard_record_entity.dart';
import 'package:summer_budget_game/domain/repository/game_repository.dart';

class GetLeaderboardUseCase extends UseCaseNoPrarms<List<LeaderboardRecordEntity>> {
  final GameRepository gameRepository;

  GetLeaderboardUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, List<LeaderboardRecordEntity>>> call() async {
    final result = await gameRepository.readLeaderboard();
    return result.map((records) {
      return List.of(records)..sort((a, b) => b.score.compareTo(a.score));
    });
  }
}
