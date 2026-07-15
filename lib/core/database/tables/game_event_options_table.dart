import 'package:drift/drift.dart';

import 'game_events_table.dart';

class GameEventOptions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get eventId =>
      integer().references(GameEvents, #id)();

  IntColumn get moneyDelta =>
      integer().withDefault(const Constant(0))();

  IntColumn get energyDelta =>
      integer().withDefault(const Constant(0))();

  IntColumn get happinessDelta =>
      integer().withDefault(const Constant(0))();

  IntColumn get finIQDelta =>
      integer().withDefault(const Constant(0))();

  IntColumn get pointsDelta =>
      integer().withDefault(const Constant(0))();
}
