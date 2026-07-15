import 'package:drift/drift.dart';

class Jobs extends Table {
  IntColumn get id => integer()();

  IntColumn get salary => integer().withDefault(const Constant(0))();

  IntColumn get energyCost => integer().withDefault(const Constant(0))();

  IntColumn get happinessCost => integer().withDefault(const Constant(0))();

  IntColumn get timeCost => integer().withDefault(const Constant(0))();

  IntColumn get minFinIQ => integer().withDefault(const Constant(0))();

  IntColumn get minPoints => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
