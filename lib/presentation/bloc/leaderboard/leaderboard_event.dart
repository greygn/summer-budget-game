import '../../../domain/entity/leaderboard_record_entity.dart';

sealed class LeaderboardEvent {}

final class LeaderboardOpened extends LeaderboardEvent {}

final class AddLeaderboardRecord extends LeaderboardEvent {
  final String name;
  AddLeaderboardRecord(this.name);
}
