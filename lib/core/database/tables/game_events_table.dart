import 'package:drift/drift.dart';

class GameEvents extends Table {
  IntColumn get id => integer()();

  TextColumn get titleRu => text()();
  TextColumn get titleEn => text()();

  TextColumn get descriptionRu => text()();
  TextColumn get descriptionEn => text()();

  IntColumn get moneyDelta => integer().withDefault(const Constant(0))();

  IntColumn get energyDelta => integer().withDefault(const Constant(0))();

  IntColumn get happinessDelta => integer().withDefault(const Constant(0))();

  IntColumn get finIQDelta => integer().withDefault(const Constant(0))();

  IntColumn get pointsDelta => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
