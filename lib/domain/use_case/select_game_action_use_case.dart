import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

class SelectGameActionUseCase extends UseCase<SaveRecordEntity, GameActionEntity>{
  @override
  Future<Either<Failure, SaveRecordEntity>> call(GameActionEntity params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

//при выборе действия применяется эффект