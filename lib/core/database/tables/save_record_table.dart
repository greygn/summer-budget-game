import 'package:drift/drift.dart';

import 'game_events_table.dart';
import 'jobs_table.dart';

class SaveRecords extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();

  TextColumn get playerName => text()();

  // CharacterRecord
  IntColumn get balance =>
      integer().withDefault(const Constant(0))();

  IntColumn get savings =>
      integer().withDefault(const Constant(0))();

  IntColumn get happiness =>
      integer().withDefault(const Constant(0))();

  IntColumn get energy =>
      integer().withDefault(const Constant(0))();

  IntColumn get finIQ =>
      integer().withDefault(const Constant(0))();

  IntColumn get score =>
      integer().withDefault(const Constant(0))();

  IntColumn get jobId =>
      integer().references(Jobs, #id)();

  // GameRecord
  IntColumn get currentDay =>
      integer().withDefault(const Constant(0))();

  IntColumn get allowedDays =>
      integer().withDefault(const Constant(0))();

  IntColumn get timeLeft =>
      integer().withDefault(const Constant(0))();

  IntColumn get gameMode =>
      integer().withDefault(const Constant(0))();

  RealColumn get inflationLevel =>
      real().withDefault(const Constant(0))();

  BoolColumn get isOver =>
      boolean().withDefault(const Constant(false))();

  IntColumn get currentEventId =>
      integer().references(GameEvents, #id)();

  @override
  Set<Column> get primaryKey => {id};
}
