import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../app_database.dart';
import '../tables/game_action_categories_table.dart';

part 'game_action_categories_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [GameActionCategories])
class GameActionCategoriesDao
    extends DatabaseAccessor<AppDatabase>
    with _$GameActionCategoriesDaoMixin {
  GameActionCategoriesDao(super.db);

  Future<List<GameActionCategory>> getAll() {
    return select(gameActionCategories).get();
  }

  Future<GameActionCategory?> getById(int id) {
    return (select(gameActionCategories)
      ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertAll(
      List<GameActionCategoriesCompanion> categories) async {
    await batch((batch) {
      batch.insertAll(
        gameActionCategories,
        categories,
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}
