import '../../../domain/entity/game_action_category_entity.dart';
import '../../../domain/entity/game_action_entity.dart';
import '../../../domain/entity/game_event_entity.dart';
import '../../../domain/entity/game_event_option_entity.dart';
import '../../../domain/entity/job_entity.dart';
import '../../../domain/entity/leaderboard_record_entity.dart';
import '../../../domain/entity/save_record_entity.dart';

abstract class LocalDataSource {
  Future<List<JobEntity>> readJobs();

  Future<List<GameActionCategoryEntity>> readGameActionCategories();

  Future<List<GameActionEntity>> readGameActions();

  Future<List<GameEventEntity>> readGameEvents();

  Future<List<GameEventOptionEntity>> readGameEventOptions(
      GameEventEntity event,
      );

  Future<SaveRecordEntity?> readSaveRecord();

  Future<void> writeSaveRecord(
      SaveRecordEntity save,
      );

  Future<List<LeaderboardRecordEntity>> readLeaderboard();

  Future<void> writeLeaderboard(
      LeaderboardRecordEntity record,
      );
}
