import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';
import 'package:summer_budget_game/domain/repository/game_repository.dart';

class GetSaveInfoUseCase extends UseCaseNoPrarms<SaveRecordEntity> {
  final GameRepository gameRepository;

  GetSaveInfoUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call() {
    return gameRepository.readSaveRecord();
  }
}