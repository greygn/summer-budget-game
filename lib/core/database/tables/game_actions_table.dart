import 'package:drift/drift.dart';

import 'game_action_categories_table.dart';

class GameActions extends Table {
  IntColumn get id => integer()();

  TextColumn get nameRu => text()();
  TextColumn get nameEn => text()();

  IntColumn get categoryId =>
      integer().references(GameActionCategories, #id)();

  IntColumn get moneyDelta =>
      integer().withDefault(const Constant(0))();

  IntColumn get happinessDelta =>
      integer().withDefault(const Constant(0))();

  IntColumn get energyDelta =>
      integer().withDefault(const Constant(0))();

  IntColumn get finIQDelta =>
      integer().withDefault(const Constant(0))();

  IntColumn get savingsDelta =>
      integer().withDefault(const Constant(0))();

  IntColumn get pointsForAction =>
      integer().withDefault(const Constant(0))();

  IntColumn get timeCost =>
      integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
