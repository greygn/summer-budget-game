import 'package:drift/drift.dart';

class GameActionCategories extends Table {
  IntColumn get id => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
