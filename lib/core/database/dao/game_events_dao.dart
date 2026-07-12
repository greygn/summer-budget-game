import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/game_events_table.dart';

part 'game_events_dao.g.dart';

@DriftAccessor(tables: [GameEvents])
class GameEventsDao extends DatabaseAccessor<AppDatabase>
    with _$GameEventsDaoMixin {
  GameEventsDao(super.db);

  Future<List<GameEvent>> getAll() {
    return select(gameEvents).get();
  }

  Future<GameEvent?> getById(int id) {
    return (select(gameEvents)
      ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertAll(
      List<GameEventsCompanion> events,
      ) async {
    await batch((batch) {
      batch.insertAll(
        gameEvents,
        events,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> clear() {
    return delete(gameEvents).go();
  }
}
