import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

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
@lazySingleton
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator migrator) async {
      await migrator.createAll();
    },

    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 6) {
        await m.createAll();
      }
    },

    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');

      await batch((batch) {
        batch.insert(
          jobs,
          const JobsCompanion(
            id: Value(0),
            salary: Value(0),
            energyCost: Value(0),
            happinessCost: Value(0),
            timeCost: Value(0),
            minFinIQ: Value(0),
            minPoints: Value(0),
          ),
          mode: InsertMode.insertOrIgnore,
        );
        batch.insert(
          gameEvents,
          const GameEventsCompanion(
            id: Value(0),
            moneyDelta: Value(0),
            energyDelta: Value(0),
            happinessDelta: Value(0),
            finIQDelta: Value(0),
            pointsDelta: Value(0),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      });

      if (details.wasCreated || details.hadUpgrade) {
        await batch((batch) {
          // 1. КАТЕГОРИИ
          batch.insertAll(gameActionCategories, [
            const GameActionCategoriesCompanion(id: Value(1)),
            const GameActionCategoriesCompanion(id: Value(2)),
            const GameActionCategoriesCompanion(id: Value(3)),
            const GameActionCategoriesCompanion(id: Value(4)),
            const GameActionCategoriesCompanion(id: Value(5)),
            const GameActionCategoriesCompanion(id: Value(6)),
            const GameActionCategoriesCompanion(id: Value(7)),
          ]);

          // 2. ПРОФЕССИИ
          batch.insertAll(jobs, [
            const JobsCompanion(id: Value(1), salary: Value(1500), energyCost: Value(-25), happinessCost: Value(-15), timeCost: Value(8), minFinIQ: Value(0), minPoints: Value(0)),
            const JobsCompanion(id: Value(2), salary: Value(2200), energyCost: Value(-20), happinessCost: Value(-10), timeCost: Value(8), minFinIQ: Value(5), minPoints: Value(5)),
            const JobsCompanion(id: Value(3), salary: Value(2800), energyCost: Value(-18), happinessCost: Value(-12), timeCost: Value(8), minFinIQ: Value(10), minPoints: Value(15)),
            const JobsCompanion(id: Value(4), salary: Value(3200), energyCost: Value(-12), happinessCost: Value(5), timeCost: Value(8), minFinIQ: Value(15), minPoints: Value(30)),
            const JobsCompanion(id: Value(5), salary: Value(4000), energyCost: Value(-15), happinessCost: Value(0), timeCost: Value(8), minFinIQ: Value(25), minPoints: Value(50)),
            const JobsCompanion(id: Value(6), salary: Value(5000), energyCost: Value(-15), happinessCost: Value(-5), timeCost: Value(8), minFinIQ: Value(35), minPoints: Value(80)),
            const JobsCompanion(id: Value(7), salary: Value(6500), energyCost: Value(-10), happinessCost: Value(-5), timeCost: Value(8), minFinIQ: Value(50), minPoints: Value(120)),
            const JobsCompanion(id: Value(8), salary: Value(8500), energyCost: Value(-10), happinessCost: Value(0), timeCost: Value(8), minFinIQ: Value(65), minPoints: Value(200)),
            const JobsCompanion(id: Value(9), salary: Value(12000), energyCost: Value(-12), happinessCost: Value(5), timeCost: Value(8), minFinIQ: Value(80), minPoints: Value(300)),
            const JobsCompanion(id: Value(10), salary: Value(18000), energyCost: Value(-15), happinessCost: Value(10), timeCost: Value(8), minFinIQ: Value(100), minPoints: Value(500)),
            const JobsCompanion(id: Value(11), salary: Value(28000), energyCost: Value(-18), happinessCost: Value(15), timeCost: Value(8), minFinIQ: Value(130), minPoints: Value(800)),
            const JobsCompanion(id: Value(12), salary: Value(40000), energyCost: Value(-22), happinessCost: Value(-10), timeCost: Value(8), minFinIQ: Value(160), minPoints: Value(1200)),
          ]);

          // 3. ДЕЙСТВИЯ
          batch.insertAll(gameActions, [
            // Системные
            const GameActionsCompanion(id: Value(100), categoryId: Value(5), timeCost: Value(4)),
            const GameActionsCompanion(id: Value(101), categoryId: Value(5), timeCost: Value(8)),
            const GameActionsCompanion(id: Value(102), categoryId: Value(5), timeCost: Value(12)),
            
            // Еда
            const GameActionsCompanion(id: Value(1), categoryId: Value(1), timeCost: Value(1), moneyDelta: Value(-150), energyDelta: Value(5), happinessDelta: Value(-5)),
            const GameActionsCompanion(id: Value(2), categoryId: Value(1), timeCost: Value(1), moneyDelta: Value(-450), energyDelta: Value(15), happinessDelta: Value(5)),
            const GameActionsCompanion(id: Value(3), categoryId: Value(1), timeCost: Value(1), moneyDelta: Value(-1500), energyDelta: Value(25), happinessDelta: Value(15), pointsForAction: Value(5)),
            const GameActionsCompanion(id: Value(4), categoryId: Value(1), timeCost: Value(2), moneyDelta: Value(-4000), energyDelta: Value(35), happinessDelta: Value(30), pointsForAction: Value(15)),
            
            // Здоровье
            const GameActionsCompanion(id: Value(5), categoryId: Value(2), timeCost: Value(1), moneyDelta: Value(-300), energyDelta: Value(10), happinessDelta: Value(2)),
            const GameActionsCompanion(id: Value(6), categoryId: Value(2), timeCost: Value(1), moneyDelta: Value(0), energyDelta: Value(5), happinessDelta: Value(5), pointsForAction: Value(2)),
            const GameActionsCompanion(id: Value(7), categoryId: Value(2), timeCost: Value(2), moneyDelta: Value(-2500), energyDelta: Value(30), happinessDelta: Value(20), pointsForAction: Value(10)),
            const GameActionsCompanion(id: Value(8), categoryId: Value(2), timeCost: Value(3), moneyDelta: Value(-8000), energyDelta: Value(40), happinessDelta: Value(10), finIQDelta: Value(5), pointsForAction: Value(25)),
            
            // Отдых
            const GameActionsCompanion(id: Value(9), categoryId: Value(3), timeCost: Value(2), moneyDelta: Value(0), energyDelta: Value(10), happinessDelta: Value(5), finIQDelta: Value(-2)),
            const GameActionsCompanion(id: Value(10), categoryId: Value(3), timeCost: Value(2), moneyDelta: Value(0), energyDelta: Value(35), happinessDelta: Value(10)),
            const GameActionsCompanion(id: Value(11), categoryId: Value(3), timeCost: Value(3), moneyDelta: Value(-1000), energyDelta: Value(20), happinessDelta: Value(15), pointsForAction: Value(5)),
            const GameActionsCompanion(id: Value(12), categoryId: Value(3), timeCost: Value(5), moneyDelta: Value(-5000), energyDelta: Value(-10), happinessDelta: Value(35), finIQDelta: Value(-5), pointsForAction: Value(20)),
            const GameActionsCompanion(id: Value(13), categoryId: Value(3), timeCost: Value(8), moneyDelta: Value(-15000), energyDelta: Value(70), happinessDelta: Value(50), pointsForAction: Value(50)),
            
            // Образование
            const GameActionsCompanion(id: Value(14), categoryId: Value(4), timeCost: Value(1), moneyDelta: Value(0), energyDelta: Value(-5), happinessDelta: Value(-2), finIQDelta: Value(2), pointsForAction: Value(2)),
            const GameActionsCompanion(id: Value(15), categoryId: Value(4), timeCost: Value(2), moneyDelta: Value(-1200), energyDelta: Value(-10), happinessDelta: Value(0), finIQDelta: Value(8), pointsForAction: Value(10)),
            const GameActionsCompanion(id: Value(16), categoryId: Value(4), timeCost: Value(3), moneyDelta: Value(-3000), energyDelta: Value(-15), happinessDelta: Value(2), finIQDelta: Value(15), pointsForAction: Value(20)),
            const GameActionsCompanion(id: Value(17), categoryId: Value(4), timeCost: Value(6), moneyDelta: Value(-18000), energyDelta: Value(-30), happinessDelta: Value(-10), finIQDelta: Value(45), pointsForAction: Value(70)),
            
            // Стиль
            const GameActionsCompanion(id: Value(18), categoryId: Value(6), timeCost: Value(1), moneyDelta: Value(-400), energyDelta: Value(-2), happinessDelta: Value(2), pointsForAction: Value(5)),
            const GameActionsCompanion(id: Value(19), categoryId: Value(6), timeCost: Value(2), moneyDelta: Value(-3500), energyDelta: Value(-5), happinessDelta: Value(15), pointsForAction: Value(20)),
            const GameActionsCompanion(id: Value(20), categoryId: Value(6), timeCost: Value(2), moneyDelta: Value(-2500), energyDelta: Value(5), happinessDelta: Value(20), pointsForAction: Value(30)),
            const GameActionsCompanion(id: Value(21), categoryId: Value(6), timeCost: Value(2), moneyDelta: Value(-15000), energyDelta: Value(5), happinessDelta: Value(30), pointsForAction: Value(100)),
            const GameActionsCompanion(id: Value(22), categoryId: Value(6), timeCost: Value(4), moneyDelta: Value(-35000), energyDelta: Value(-10), happinessDelta: Value(25), finIQDelta: Value(10), pointsForAction: Value(250)),

            // Финансы
            const GameActionsCompanion(id: Value(23), categoryId: Value(7), timeCost: Value(0), moneyDelta: Value(-1000), savingsDelta: Value(1000)),
            const GameActionsCompanion(id: Value(24), categoryId: Value(7), timeCost: Value(0), moneyDelta: Value(-5000), savingsDelta: Value(5000)),
            const GameActionsCompanion(id: Value(25), categoryId: Value(7), timeCost: Value(0), moneyDelta: Value(-20000), savingsDelta: Value(20000)),
            const GameActionsCompanion(id: Value(26), categoryId: Value(7), timeCost: Value(0), moneyDelta: Value(5000), savingsDelta: Value(-5000)),
          ]);

          // 4. СОБЫТИЯ
          batch.insertAll(gameEvents, [
            const GameEventsCompanion(id: Value(1)),
            const GameEventsCompanion(id: Value(2)),
            const GameEventsCompanion(id: Value(3)),
            const GameEventsCompanion(id: Value(4)),
            const GameEventsCompanion(id: Value(5)),
            const GameEventsCompanion(id: Value(6)),
            const GameEventsCompanion(id: Value(7)),
            const GameEventsCompanion(id: Value(8)),
            const GameEventsCompanion(id: Value(9)),
            const GameEventsCompanion(id: Value(10)),
            const GameEventsCompanion(id: Value(11)),
            const GameEventsCompanion(id: Value(12)),
            const GameEventsCompanion(id: Value(13)),
            const GameEventsCompanion(id: Value(14)),
            const GameEventsCompanion(id: Value(15)),
            const GameEventsCompanion(id: Value(16)),
            const GameEventsCompanion(id: Value(17)),
            const GameEventsCompanion(id: Value(18)),
            const GameEventsCompanion(id: Value(19)),
            const GameEventsCompanion(id: Value(20)),
            const GameEventsCompanion(id: Value(21)),
            const GameEventsCompanion(id: Value(22)),
            const GameEventsCompanion(id: Value(23)),
            const GameEventsCompanion(id: Value(24)),
            const GameEventsCompanion(id: Value(25)),
            const GameEventsCompanion(id: Value(26)),
          ]);

          // 5. ОПЦИИ СОБЫТИЙ
          batch.insertAll(gameEventOptions, [
            const GameEventOptionsCompanion(id: Value(1), eventId: Value(1), moneyDelta: Value(1000), happinessDelta: Value(5)),
            const GameEventOptionsCompanion(id: Value(2), eventId: Value(2), moneyDelta: Value(-8000), energyDelta: Value(-5), happinessDelta: Value(-10)),
            const GameEventOptionsCompanion(id: Value(3), eventId: Value(3), moneyDelta: Value(-3000), happinessDelta: Value(-5), finIQDelta: Value(2)),
            const GameEventOptionsCompanion(id: Value(4), eventId: Value(4), moneyDelta: Value(-600), energyDelta: Value(-15), happinessDelta: Value(-5)),
            const GameEventOptionsCompanion(id: Value(5), eventId: Value(5), moneyDelta: Value(5000), happinessDelta: Value(15)),
            const GameEventOptionsCompanion(id: Value(6), eventId: Value(6), energyDelta: Value(-10), happinessDelta: Value(-10), finIQDelta: Value(1)),
            const GameEventOptionsCompanion(id: Value(7), eventId: Value(7), energyDelta: Value(-15), happinessDelta: Value(-15)),
            const GameEventOptionsCompanion(id: Value(8), eventId: Value(8), energyDelta: Value(-5), finIQDelta: Value(5)),
            const GameEventOptionsCompanion(id: Value(9), eventId: Value(9), moneyDelta: Value(-2000), happinessDelta: Value(20)),
            const GameEventOptionsCompanion(id: Value(10), eventId: Value(10), happinessDelta: Value(15), pointsDelta: Value(15)),
            const GameEventOptionsCompanion(id: Value(11), eventId: Value(11), moneyDelta: Value(-250), energyDelta: Value(-2), happinessDelta: Value(-2), finIQDelta: Value(1)),
            const GameEventOptionsCompanion(id: Value(12), eventId: Value(12), energyDelta: Value(5), happinessDelta: Value(15), pointsDelta: Value(20)),
            const GameEventOptionsCompanion(id: Value(13), eventId: Value(13), energyDelta: Value(-15), happinessDelta: Value(-20)),
            
            // Интерактивные
            const GameEventOptionsCompanion(id: Value(14), eventId: Value(14), moneyDelta: Value(-3000), energyDelta: Value(-10), happinessDelta: Value(25), pointsDelta: Value(10)),
            const GameEventOptionsCompanion(id: Value(15), eventId: Value(14), energyDelta: Value(10), happinessDelta: Value(-10), finIQDelta: Value(2)),
            
            const GameEventOptionsCompanion(id: Value(16), eventId: Value(15), moneyDelta: Value(-1500), energyDelta: Value(-5), happinessDelta: Value(15), pointsDelta: Value(5)),
            const GameEventOptionsCompanion(id: Value(17), eventId: Value(15), happinessDelta: Value(-5), finIQDelta: Value(5)),
            
            const GameEventOptionsCompanion(id: Value(18), eventId: Value(16), moneyDelta: Value(-3000), energyDelta: Value(-10), happinessDelta: Value(-5), finIQDelta: Value(2)),
            const GameEventOptionsCompanion(id: Value(19), eventId: Value(16), moneyDelta: Value(-12000), energyDelta: Value(5), happinessDelta: Value(10), pointsDelta: Value(30)),
            
            const GameEventOptionsCompanion(id: Value(20), eventId: Value(17), moneyDelta: Value(-5000), energyDelta: Value(-5), happinessDelta: Value(5), finIQDelta: Value(-10), pointsDelta: Value(10)),
            const GameEventOptionsCompanion(id: Value(21), eventId: Value(17), happinessDelta: Value(5), finIQDelta: Value(8)),
            
            const GameEventOptionsCompanion(id: Value(22), eventId: Value(18), moneyDelta: Value(-4000), finIQDelta: Value(5), pointsDelta: Value(5)),
            const GameEventOptionsCompanion(id: Value(23), eventId: Value(18), moneyDelta: Value(-18000), happinessDelta: Value(25), finIQDelta: Value(-5), pointsDelta: Value(120)),
            
            const GameEventOptionsCompanion(id: Value(24), eventId: Value(19), moneyDelta: Value(2000), energyDelta: Value(5), happinessDelta: Value(15)),
            const GameEventOptionsCompanion(id: Value(25), eventId: Value(19), energyDelta: Value(5), happinessDelta: Value(25), pointsDelta: Value(50)),
            
            const GameEventOptionsCompanion(id: Value(26), eventId: Value(20), moneyDelta: Value(-500), happinessDelta: Value(2), finIQDelta: Value(-2)),
            const GameEventOptionsCompanion(id: Value(27), eventId: Value(20), finIQDelta: Value(5)),
            
            const GameEventOptionsCompanion(id: Value(28), eventId: Value(21), moneyDelta: Value(-6000), energyDelta: Value(-10), happinessDelta: Value(10), finIQDelta: Value(-15), pointsDelta: Value(40)),
            const GameEventOptionsCompanion(id: Value(29), eventId: Value(21), finIQDelta: Value(10)),
            
            const GameEventOptionsCompanion(id: Value(30), eventId: Value(22), moneyDelta: Value(-1200), energyDelta: Value(15), happinessDelta: Value(15)),
            const GameEventOptionsCompanion(id: Value(31), eventId: Value(22), moneyDelta: Value(-50), energyDelta: Value(5), happinessDelta: Value(-10), finIQDelta: Value(4)),
            
            const GameEventOptionsCompanion(id: Value(32), eventId: Value(23), moneyDelta: Value(-15000), energyDelta: Value(-5), happinessDelta: Value(-5), finIQDelta: Value(-10), pointsDelta: Value(30)),
            const GameEventOptionsCompanion(id: Value(33), eventId: Value(23), finIQDelta: Value(12)),
            
            const GameEventOptionsCompanion(id: Value(34), eventId: Value(24), energyDelta: Value(-15), happinessDelta: Value(-15), finIQDelta: Value(12), pointsDelta: Value(25)),
            const GameEventOptionsCompanion(id: Value(35), eventId: Value(24), energyDelta: Value(15), happinessDelta: Value(10)),
            
            const GameEventOptionsCompanion(id: Value(36), eventId: Value(25), moneyDelta: Value(-3500), happinessDelta: Value(15), pointsDelta: Value(60)),
            const GameEventOptionsCompanion(id: Value(37), eventId: Value(25), finIQDelta: Value(6)),
            
            const GameEventOptionsCompanion(id: Value(38), eventId: Value(26), moneyDelta: Value(-300), energyDelta: Value(-5), happinessDelta: Value(20), finIQDelta: Value(2), pointsDelta: Value(15)),
            const GameEventOptionsCompanion(id: Value(39), eventId: Value(26), energyDelta: Value(10), happinessDelta: Value(-5)),
          ]);
        });
      }
    },
  );
}
