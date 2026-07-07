import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

class WinGameUseCase extends UseCase<SaveRecordEntity, void>{
  @override
  Future<Either<Failure, SaveRecordEntity>> call(void params) {
    // TODO: implement call
    throw UnimplementedError();
  }

}

//в случае победы пишем результат в список рекордов