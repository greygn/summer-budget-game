import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../app_database.dart';
import '../tables/game_action_categories_table.dart';
import '../tables/game_actions_table.dart';

part 'game_actions_dao.g.dart';

@lazySingleton
@DriftAccessor(
  tables: [
    GameActions,
    GameActionCategories,
  ],
)
class GameActionsDao extends DatabaseAccessor<AppDatabase>
    with _$GameActionsDaoMixin {
  GameActionsDao(super.db);

  Future<List<GameAction>> getAll() {
    return select(gameActions).get();
  }

  Future<List<GameAction>> getByCategory(int categoryId) {
    return (select(gameActions)
      ..where((t) => t.categoryId.equals(categoryId)))
        .get();
  }

  Future<GameAction?> getById(int id) {
    return (select(gameActions)
      ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertAll(
      List<GameActionsCompanion> actions) async {
    await batch((batch) {
      batch.insertAll(
        gameActions,
        actions,
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}
