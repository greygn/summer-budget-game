import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_event_entity.dart';

class ReciveEventUseCase extends UseCaseNoPrarms<GameEventEntity>{
  @override
  Future<Either<Failure, GameEventEntity>> call() {
    // TODO: implement call
    throw UnimplementedError();
  }
}

//случайным образом выпадает GameEvent, применяется эффект, если нет options