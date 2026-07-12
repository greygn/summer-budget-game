import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/save_record_table.dart';

part 'save_record_dao.g.dart';

@DriftAccessor(tables: [SaveRecords])
class SaveRecordDao extends DatabaseAccessor<AppDatabase>
    with _$SaveRecordDaoMixin {
  SaveRecordDao(super.db);

  Future<SaveRecord?> getSave() {
    return select(saveRecords).getSingleOrNull();
  }

  Future<void> save(
      SaveRecordsCompanion record) async {
    await into(saveRecords).insert(
      record,
      mode: InsertMode.insertOrReplace,
    );
  }

  Future<void> clear() {
    return delete(saveRecords).go();
  }
}
