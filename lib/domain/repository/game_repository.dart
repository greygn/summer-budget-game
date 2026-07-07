import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';
import 'package:summer_budget_game/domain/entity/game_event_entity.dart';
import 'package:summer_budget_game/domain/entity/game_event_option_entity.dart';
import 'package:summer_budget_game/domain/entity/game_failure.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

abstract class GameRepository {
  Future<Either<GameFailure, SaveRecordEntity>> readSaveRecord();

  Future<Either<GameFailure, SaveRecordEntity>> writeSaveRecord(
    SaveRecordEntity saveRecord,
  );

  Future<Either<GameFailure, List<GameActionEntity>>> readGameActions();

  Future<Either<GameFailure, List<JobEntity>>> readJobs();

  Future<Either<GameFailure, List<GameEventEntity>>> readGameEvents();

  Future<Either<GameFailure, List<GameEventOptionEntity>>> readGameEventOptions(GameEventEntity event);


}
