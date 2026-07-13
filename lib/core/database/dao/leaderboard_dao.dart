import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../app_database.dart';
import '../tables/leaderboard_table.dart';

part 'leaderboard_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [LeaderboardRecords])
class LeaderboardDao extends DatabaseAccessor<AppDatabase>
    with _$LeaderboardDaoMixin {
  LeaderboardDao(super.db);

  Future<List<LeaderboardRecord>> getAll() {
    return (select(leaderboardRecords)
      ..orderBy([
            (t) => OrderingTerm.desc(t.score),
      ]))
        .get();
  }

  Future<void> insert(
      LeaderboardRecordsCompanion record) {
    return into(leaderboardRecords).insert(record);
  }

  Future<void> clear() {
    return delete(leaderboardRecords).go();
  }
}
