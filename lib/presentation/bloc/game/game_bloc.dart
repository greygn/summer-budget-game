import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/domain/use_case/check_state_use_case.dart';
import 'package:summer_budget_game/domain/use_case/end_day_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_game_actions_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_jobs_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_save_info_use_case.dart';
import 'package:summer_budget_game/domain/use_case/recive_event_use_case.dart';
import 'package:summer_budget_game/domain/use_case/select_game_action_use_case.dart';
import 'package:summer_budget_game/domain/use_case/select_game_event_option.dart';
import 'package:summer_budget_game/domain/use_case/select_job_use_case.dart';
import 'package:summer_budget_game/domain/entity/game_mode.dart';
import 'package:summer_budget_game/presentation/bloc/game/game_event.dart';
import 'package:summer_budget_game/presentation/bloc/game/game_state.dart';

import '../../../domain/entity/game_action_entity.dart';

@injectable
class GameBloc extends Bloc<GameEvent, GameState> {
  final GetSaveInfoUseCase getSaveInfoUseCase;
  final GetGameActionsUseCase getGameActionsUseCase;
  final GetJobsUseCase getJobsUseCase;
  final SelectGameActionUseCase selectGameActionUseCase;
  final SelectGameEventOption selectGameEventOptionUseCase;
  final SelectJobUseCase selectJobUseCase;
  final EndDayUseCase endDayUseCase;
  final CheckStateUseCase checkStateUseCase;
  final ReciveEventUseCase reciveEventUseCase;

  GameBloc({
    required this.getSaveInfoUseCase,
    required this.getGameActionsUseCase,
    required this.getJobsUseCase,
    required this.selectGameActionUseCase,
    required this.selectGameEventOptionUseCase,
    required this.selectJobUseCase,
    required this.endDayUseCase,
    required this.checkStateUseCase,
    required this.reciveEventUseCase,
  }) : super(const GameState()) {
    on<GameStarted>(_onGameStarted);
    on<GameActionSelected>(_onActionSelected);
    on<GameEventOptionSelected>(_onEventOptionSelected);
    on<JobSelected>(_onJobSelected);
    on<EndDayPressed>(_onEndDayPressed);
    on<CheckGameStateRequested>(_onCheckState);
  }

  Future<void> _onGameStarted(
    GameStarted event,
    Emitter<GameState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final saveResult = await getSaveInfoUseCase();
    final actionsResult = await getGameActionsUseCase();
    final jobsResult = await getJobsUseCase();

    saveResult.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (saveRecord) {
        final game = saveRecord.gameRecord;
        final char = saveRecord.characterRecord;

        final double goal;
        final double progress;

        if (game.gameMode == GameMode.standard) {
          goal = CheckStateUseCase.standardBalanceGoal.toDouble();
          progress = goal > 0 ? (game.currentDay / game.allowedDays).clamp(0.0, 1.0) : 0;
        } else {
          goal = CheckStateUseCase.marathonBalanceGoal.toDouble();
          progress = goal > 0 ? ((char.balance + char.savings) / goal).clamp(0.0, 1.0) : 0;
        }

        final event = game.currentEvent;
        final bool isEventBad = event.moneyDelta < 0 ||
            event.happinessDelta < 0 ||
            event.finIQDelta < 0 ||
            event.pointsDelta < 0;

        emit(state.copyWith(
          saveRecord: saveRecord,
          goal: goal,
          progress: progress,
          isEventBad: isEventBad,
          isLoading: false,
        ));
      },
    );

    actionsResult.fold(
      (failure) => null,
      (actions) {
        final groupedActions = <int, List<GameActionEntity>>{};
        for (final action in actions) {
          final categoryId = action.category.ID;
          groupedActions.putIfAbsent(categoryId, () => []).add(action);
        }
        emit(state.copyWith(actions: actions, groupedActions: groupedActions));
      },
    );

    jobsResult.fold(
      (failure) => null,
      (jobs) => emit(state.copyWith(jobs: jobs)),
    );
  }

  Future<void> _onActionSelected(
    GameActionSelected event,
    Emitter<GameState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await selectGameActionUseCase(event.action);

    await result.fold(
      (failure) async => emit(state.copyWith(isLoading: false, failure: failure)),
      (saveRecord) async {
        await checkStateUseCase();
        add(GameStarted());
      },
    );
  }

  Future<void> _onEventOptionSelected(
    GameEventOptionSelected event,
    Emitter<GameState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await selectGameEventOptionUseCase(event.option);

    await result.fold(
      (failure) async => emit(state.copyWith(isLoading: false, failure: failure)),
      (saveRecord) async {
        await checkStateUseCase();
        add(GameStarted());
      },
    );
  }

  Future<void> _onJobSelected(
    JobSelected event,
    Emitter<GameState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await selectJobUseCase(event.job);

    await result.fold(
      (failure) async => emit(state.copyWith(isLoading: false, failure: failure)),
      (saveRecord) async {
        await checkStateUseCase();
        add(GameStarted());
      },
    );
  }

  Future<void> _onEndDayPressed(
    EndDayPressed event,
    Emitter<GameState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await endDayUseCase();

    await result.fold(
      (failure) async => emit(state.copyWith(isLoading: false, failure: failure)),
      (saveRecord) async {
        await reciveEventUseCase();
        await checkStateUseCase();
        add(GameStarted());
      },
    );
  }

  Future<void> _onCheckState(
    CheckGameStateRequested event,
    Emitter<GameState> emit,
  ) async {
    await checkStateUseCase();
    final saveResult = await getSaveInfoUseCase();
    saveResult.fold(
      (failure) => null,
      (saveRecord) => emit(state.copyWith(saveRecord: saveRecord)),
    );
  }
}
