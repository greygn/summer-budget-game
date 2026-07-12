import 'package:equatable/equatable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

class GameState extends Equatable {
  final SaveRecordEntity? saveRecord;
  final List<GameActionEntity> actions;
  final List<JobEntity> jobs;
  final bool isLoading;
  final Failure? failure;

  const GameState({
    this.saveRecord,
    this.actions = const [],
    this.jobs = const [],
    this.isLoading = false,
    this.failure,
  });

  GameState copyWith({
    SaveRecordEntity? saveRecord,
    List<GameActionEntity>? actions,
    List<JobEntity>? jobs,
    bool? isLoading,
    Failure? failure,
  }) {
    return GameState(
      saveRecord: saveRecord ?? this.saveRecord,
      actions: actions ?? this.actions,
      jobs: jobs ?? this.jobs,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        saveRecord,
        actions,
        jobs,
        isLoading,
        failure,
      ];
}
