import 'package:drift/drift.dart';

class GameActionCategories extends Table {
  IntColumn get id => integer()();

  TextColumn get nameRu => text()();
  TextColumn get nameEn => text()();

  @override
  Set<Column> get primaryKey => {id};
}
