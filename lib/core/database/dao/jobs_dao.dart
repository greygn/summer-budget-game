import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/jobs_table.dart';

part 'jobs_dao.g.dart';

@DriftAccessor(tables: [Jobs])
class JobsDao extends DatabaseAccessor<AppDatabase>
    with _$JobsDaoMixin {
  JobsDao(super.db);

  Future<List<Job>> getAll() {
    return select(jobs).get();
  }

  Future<Job?> getById(int id) {
    return (select(jobs)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> insertAll(List<JobsCompanion> data) async {
    await batch((batch) {
      batch.insertAll(
        jobs,
        data,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> clear() {
    return delete(jobs).go();
  }
}
