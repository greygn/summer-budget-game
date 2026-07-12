import 'package:drift/drift.dart';

class GameEvents extends Table {
  IntColumn get id => integer()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  IntColumn get moneyDelta => integer().withDefault(const Constant(0))();

  IntColumn get happinessDelta => integer().withDefault(const Constant(0))();

  IntColumn get finIQDelta => integer().withDefault(const Constant(0))();

  IntColumn get pointsDelta => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
