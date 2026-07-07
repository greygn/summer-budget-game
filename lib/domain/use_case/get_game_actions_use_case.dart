import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';

import '../repository/game_repository.dart';

//Получение списка действий
class GetGameActionsUseCase extends UseCaseNoPrarms<List<GameActionEntity>> {
  final GameRepository gameRepository;

  GetGameActionsUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, List<GameActionEntity>>> call() {
    return gameRepository.readGameActions();
  }
}
