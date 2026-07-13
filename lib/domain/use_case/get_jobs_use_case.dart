import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';

import '../repository/game_repository.dart';

//Получение списка работ
@lazySingleton
class GetJobsUseCase extends UseCaseNoPrarms<List<JobEntity>>{
  final GameRepository gameRepository;

  GetJobsUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, List<JobEntity>>> call() {
    return gameRepository.readJobs();
  }
}