import 'package:drift/drift.dart';

class LeaderboardRecords extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get score =>
      integer().withDefault(const Constant(0))();

  IntColumn get days =>
      integer().withDefault(const Constant(0))();

  IntColumn get finIQ =>
      integer().withDefault(const Constant(0))();

  IntColumn get balance =>
      integer().withDefault(const Constant(0))();

  TextColumn get time => text()();
}
