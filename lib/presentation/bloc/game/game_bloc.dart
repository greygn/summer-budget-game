import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_budget_game/domain/use_case/check_state_use_case.dart';
import 'package:summer_budget_game/domain/use_case/end_day_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_game_actions_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_jobs_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_save_info_use_case.dart';
import 'package:summer_budget_game/domain/use_case/recive_event_use_case.dart';
import 'package:summer_budget_game/domain/use_case/select_game_action_use_case.dart';
import 'package:summer_budget_game/domain/use_case/select_game_event_option.dart';
import 'package:summer_budget_game/domain/use_case/select_job_use_case.dart';
import 'package:summer_budget_game/presentation/bloc/game/game_event.dart';
import 'package:summer_budget_game/presentation/bloc/game/game_state.dart';

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
        emit(state.copyWith(
          saveRecord: saveRecord,
          isLoading: false,
        ));
      },
    );

    actionsResult.fold(
      (failure) => null,
      (actions) => emit(state.copyWith(actions: actions)),
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
        emit(state.copyWith(saveRecord: saveRecord, isLoading: false));
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

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (saveRecord) => emit(state.copyWith(saveRecord: saveRecord, isLoading: false)),
    );
  }

  Future<void> _onJobSelected(
    JobSelected event,
    Emitter<GameState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await selectJobUseCase(event.job);

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (saveRecord) => emit(state.copyWith(saveRecord: saveRecord, isLoading: false)),
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
        emit(state.copyWith(saveRecord: saveRecord));

        await reciveEventUseCase();

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
