import 'package:equatable/equatable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

class GameState extends Equatable {
  final SaveRecordEntity? saveRecord;
  final List<GameActionEntity> actions;
  final Map<int, List<GameActionEntity>> groupedActions;
  final List<JobEntity> jobs;
  final bool isLoading;
  final Failure? failure;
  final double goal;
  final double progress;
  final bool isEventBad;

  const GameState({
    this.saveRecord,
    this.actions = const [],
    this.groupedActions = const {},
    this.jobs = const [],
    this.isLoading = false,
    this.failure,
    this.goal = 0,
    this.progress = 0,
    this.isEventBad = false,
  });

  GameState copyWith({
    SaveRecordEntity? saveRecord,
    List<GameActionEntity>? actions,
    Map<int, List<GameActionEntity>>? groupedActions,
    List<JobEntity>? jobs,
    bool? isLoading,
    Failure? failure,
    double? goal,
    double? progress,
    bool? isEventBad,
  }) {
    return GameState(
      saveRecord: saveRecord ?? this.saveRecord,
      actions: actions ?? this.actions,
      groupedActions: groupedActions ?? this.groupedActions,
      jobs: jobs ?? this.jobs,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      goal: goal ?? this.goal,
      progress: progress ?? this.progress,
      isEventBad: isEventBad ?? this.isEventBad,
    );
  }

  @override
  List<Object?> get props => [
        saveRecord,
        actions,
        groupedActions,
        jobs,
        isLoading,
        failure,
        goal,
        progress,
        isEventBad,
      ];
}
