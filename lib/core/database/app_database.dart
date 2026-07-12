import 'package:drift/drift.dart';

import 'connection.dart';

import 'dao/game_action_categories_dao.dart';
import 'dao/game_actions_dao.dart';
import 'dao/game_event_options_dao.dart';
import 'dao/game_events_dao.dart';
import 'dao/jobs_dao.dart';
import 'dao/leaderboard_dao.dart';
import 'dao/save_record_dao.dart';
import 'tables/jobs_table.dart';
import 'tables/game_actions_table.dart';
import 'tables/game_action_categories_table.dart';
import 'tables/game_events_table.dart';
import 'tables/game_event_options_table.dart';
import 'tables/save_record_table.dart';
import 'tables/leaderboard_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Jobs,
    GameActionCategories,
    GameActions,
    GameEvents,
    GameEventOptions,
    SaveRecords,
    LeaderboardRecords,
  ],
  daos: [
    JobsDao,
    GameActionCategoriesDao,
    GameActionsDao,
    GameEventsDao,
    GameEventOptionsDao,
    SaveRecordDao,
    LeaderboardDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator migrator) async {
      await migrator.createAll();
    },

    onUpgrade: (
        Migrator migrator,
        int from,
        int to,
        ) async {
      // Здесь можно написать миграции
    },

    beforeOpen: (details) async {
      if (details.wasCreated) {
        // Здесь можно заполнить БД начальными данными
      }

      if (details.hadUpgrade) {
        // Логирование после миграции
      }
    },
  );
}
