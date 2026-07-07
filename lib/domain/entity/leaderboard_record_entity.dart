import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_record_entity.freezed.dart';

@freezed
abstract class LeaderboardRecordEntity with _$LeaderboardRecordEntity{
  const LeaderboardRecordEntity._();

  const factory LeaderboardRecordEntity({
    @Default('') String name,
    @Default(0) int score,
    @Default(0) int days,
    @Default(0) int finIQ,
    required String time
  }) = _LeaderboardRecordEntity;
}