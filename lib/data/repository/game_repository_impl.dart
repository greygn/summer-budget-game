import 'package:dartz/dartz.dart';

import '../../domain/entity/game_action_entity.dart';
import '../../domain/entity/game_event_entity.dart';
import '../../domain/entity/game_event_option_entity.dart';
import '../../domain/entity/game_failure.dart';
import '../../domain/entity/job_entity.dart';
import '../../domain/entity/leaderboard_record_entity.dart';
import '../../domain/entity/save_record_entity.dart';
import '../../domain/repository/game_repository.dart';
import '../datasource/local/local_data_source.dart';

class GameRepositoryImpl implements GameRepository {
  final LocalDataSource _local;
  GameRepositoryImpl(this._local);

  @override
  Future<Either<GameFailure, SaveRecordEntity>> readSaveRecord() async {
    try {
      final save = await _local.readSaveRecord();

      if (save == null) {
        return Left(
          GameFailure(
              code: GameFailure.saveNotFound,
              message: 'Save not found'
          ),
        );
      }

      return Right(save);
    } catch (e) {
      return Left(
        GameFailure(
            code: GameFailure.readError,
            message: e.toString()
        ),
      );
    }
  }

  @override
  Future<Either<GameFailure, SaveRecordEntity>> writeSaveRecord(
      SaveRecordEntity saveRecord,
      ) async {
    try {
      await _local.writeSaveRecord(saveRecord);

      return Right(saveRecord);
    } catch (e) {
      return Left(
        GameFailure(
            code: GameFailure.writeError,
            message: e.toString()
        ),
      );
    }
  }

  @override
  Future<Either<GameFailure, List<GameActionEntity>>> readGameActions() async {
    try {
      return Right(await _local.readGameActions());
    } catch (e) {
      return Left(
        GameFailure(
            code: GameFailure.readError,
            message: e.toString()
        ),
      );
    }
  }

  @override
  Future<Either<GameFailure, List<JobEntity>>> readJobs() async {
    try {
      return Right(await _local.readJobs());
    } catch (e) {
      return Left(
        GameFailure(
            code: GameFailure.readError,
            message: e.toString()
        ),
      );
    }
  }

  @override
  Future<Either<GameFailure, List<GameEventEntity>>> readGameEvents() async {
    try {
      return Right(await _local.readGameEvents());
    } catch (e) {
      return Left(
        GameFailure(
            code: GameFailure.readError,
            message: e.toString()
        ),
      );
    }
  }

  @override
  Future<Either<GameFailure, List<GameEventOptionEntity>>>
  readGameEventOptions(
      GameEventEntity event,
      ) async {
    try {
      return Right(
        await _local.readGameEventOptions(event),
      );
    } catch (e) {
      return Left(
        GameFailure(
            code: GameFailure.readError,
            message: e.toString()
        ),
      );
    }
  }

  @override
  Future<Either<GameFailure, List<LeaderboardRecordEntity>>>
  readLeaderboard() async {
    try {
      return Right(
        await _local.readLeaderboard(),
      );
    } catch (e) {
      return Left(
        GameFailure(
            code: GameFailure.readError,
            message: e.toString()
        ),
      );
    }
  }

  @override
  Future<Either<GameFailure, void>> writeLeaderboard(
      LeaderboardRecordEntity record,
      ) async {
    try {
      await _local.writeLeaderboard(record);

      return const Right(null);
    } catch (e) {
      return Left(
        GameFailure(
            code: GameFailure.writeError,
            message: e.toString()
        ),
      );
    }
  }
}
