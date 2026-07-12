import 'package:equatable/equatable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/domain/entity/leaderboard_record_entity.dart';

class LeaderboardState extends Equatable {
  final List<LeaderboardRecordEntity> records;
  final bool isLoading;
  final Failure? failure;

  const LeaderboardState({
    this.records = const [],
    this.isLoading = false,
    this.failure,
  });

  LeaderboardState copyWith({
    List<LeaderboardRecordEntity>? records,
    bool? isLoading,
    Failure? failure,
  }) {
    return LeaderboardState(
      records: records ?? this.records,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [records, isLoading, failure];
}
