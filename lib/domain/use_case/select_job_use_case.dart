import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

import '../repository/game_repository.dart';

//Выбор работы игрока, сохранение работы
class SelectJobUseCase extends UseCase<SaveRecordEntity, JobEntity>{
  final GameRepository gameRepository;

  SelectJobUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(JobEntity job) async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    
    return await saveRecordResult.fold(
      (failure) async => Left(failure),
      (record) async {
        final updatedRecord = record.copyWith(
          characterRecord: record.characterRecord.copyWith(
            job: job,
          ),
        );

        final writeResult = await gameRepository.writeSaveRecord(updatedRecord);
        return writeResult.fold(
          (f) => Left(f),
          (_) => Right(updatedRecord),
        );
      },
    );
  }
}