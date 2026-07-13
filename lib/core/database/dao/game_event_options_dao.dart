import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../app_database.dart';
import '../tables/game_event_options_table.dart';

part 'game_event_options_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [GameEventOptions])
class GameEventOptionsDao extends DatabaseAccessor<AppDatabase>
    with _$GameEventOptionsDaoMixin {
  GameEventOptionsDao(super.db);

  Future<List<GameEventOption>> getAll() {
    return select(gameEventOptions).get();
  }

  Future<List<GameEventOption>> getByEventId(
      int eventId,
      ) {
    return (select(gameEventOptions)
      ..where((tbl) => tbl.eventId.equals(eventId)))
        .get();
  }

  Future<void> insertAll(
      List<GameEventOptionsCompanion> options,
      ) async {
    await batch((batch) {
      batch.insertAll(
        gameEventOptions,
        options,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> clear() {
    return delete(gameEventOptions).go();
  }
}
