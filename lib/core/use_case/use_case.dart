import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseNoPrarms<Type> {
  Future<Either<Failure, Type>> call();
}
