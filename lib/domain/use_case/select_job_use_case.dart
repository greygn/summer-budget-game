import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';
import 'package:summer_budget_game/domain/failure/insufficient_job_skills_failure.dart';
import 'package:summer_budget_game/domain/failure/unfolding_failure.dart';

import '../failure/writing_failure.dart';
import '../repository/game_repository.dart';

//Выбор работы игрока, сохранение работы
@lazySingleton
class SelectJobUseCase extends UseCase<SaveRecordEntity, JobEntity>{
  final GameRepository gameRepository;

  SelectJobUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(JobEntity job) async {
    final saveRecordResult = await gameRepository.readSaveRecord();
    
    return await saveRecordResult.fold(
      (failure) async => Left(UnfoldingFailure()),
      (record) async {
        final bool isFinIQInsufficient = record.characterRecord.finIQ < job.minFinIQ;
        final bool isScoreInsufficient = record.characterRecord.score < job.minPoints;

        if (isFinIQInsufficient || isScoreInsufficient) {
          return Left(InsufficientJobSkillsFailure(
            missingFinIQ: isFinIQInsufficient,
            missingScore: isScoreInsufficient,
          ));
        }

        final updatedRecord = record.copyWith(
          characterRecord: record.characterRecord.copyWith(
            job: job,
          ),
        );

        final writeResult = await gameRepository.writeSaveRecord(updatedRecord);
        return writeResult.fold(
          (f) => Left(WritingFailure()),
          (_) => Right(updatedRecord),
        );
      },
    );
  }
}