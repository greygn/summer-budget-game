import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

class SelectJobUseCase extends UseCase<SaveRecordEntity, JobEntity>{
  @override
  Future<Either<Failure, SaveRecordEntity>> call(JobEntity params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

//выбор работы (без работы только лохи)