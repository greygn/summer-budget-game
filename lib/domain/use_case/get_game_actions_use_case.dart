import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';
import 'package:summer_budget_game/domain/failure/unfolding_failure.dart';
import 'package:summer_budget_game/domain/use_case/get_save_info_use_case.dart';

import '../repository/game_repository.dart';

//Получение списка действий
class GetGameActionsUseCase extends UseCaseNoPrarms<List<GameActionEntity>> {
  final GameRepository gameRepository;
  final GetSaveInfoUseCase getSaveInfoUseCase;

  GetGameActionsUseCase({
    required this.gameRepository,
    required this.getSaveInfoUseCase,
  });

  @override
  Future<Either<Failure, List<GameActionEntity>>> call() async {
    final saveInfoResult = await getSaveInfoUseCase();

    return await saveInfoResult.fold(
      (failure) async => Left(UnfoldingFailure()),
      (saveRecord) async {
        final inflation = saveRecord.gameRecord.inflationLevel;
        final actionsResult = await gameRepository.readGameActions();

        return actionsResult.fold(
          (failure) => Left(UnfoldingFailure()),
          (actions) => Right(
            actions.map((action) {
              if (action.moneyDelta < 0) {
                return action.copyWith(
                  moneyDelta: (action.moneyDelta * inflation).round(),
                );
              }
              return action;
            }).toList(),
          ),
        );
      },
    );
  }
}
