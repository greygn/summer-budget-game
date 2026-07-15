import 'package:drift/drift.dart' as drift;

import '../../core/database/app_database.dart';
import '../../domain/entity/leaderboard_record_entity.dart';

extension LeaderboardMapper on LeaderboardRecord {
  LeaderboardRecordEntity toEntity() {
    return LeaderboardRecordEntity(
      name: name,
      score: score,
      days: days,
      finIQ: finIQ,
      balance: balance,
      time: time,
    );
  }
}

extension LeaderboardEntityMapper on LeaderboardRecordEntity {
  LeaderboardRecordsCompanion toCompanion() {
    return LeaderboardRecordsCompanion.insert(
      name: name,
      score: drift.Value(score),
      days: drift.Value(days),
      finIQ: drift.Value(finIQ),
      balance: drift.Value(balance),
      time: time,
    );
  }
}
