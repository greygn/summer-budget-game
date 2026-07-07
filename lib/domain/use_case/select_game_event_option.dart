import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_event_option_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

class SelectGameEventOption extends UseCase<SaveRecordEntity, GameEventOptionEntity>{
  @override
  Future<Either<Failure, SaveRecordEntity>> call(GameEventOptionEntity params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

//применение эффекта от выбора в событии (если они там есть)