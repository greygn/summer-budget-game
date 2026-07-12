import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:summer_budget_game/presentation/bloc/main_menu/main_menu_event.dart';
import 'package:summer_budget_game/presentation/bloc/main_menu/main_menu_state.dart';

import '../../../domain/failure/unfolding_failure.dart';
import '../../../domain/use_case/get_save_info_use_case.dart';
import '../../../domain/use_case/start_new_game_use_case.dart';

class MainMenuBloc extends Bloc<MainMenuEvent, MainMenuState> {
  final GetSaveInfoUseCase getSaveInfoUseCase;
  final StartNewGameUseCase startNewGameUseCase;

  MainMenuBloc({
    required this.getSaveInfoUseCase,
    required this.startNewGameUseCase,
  }) : super(MainMenuState()) {

    on<MainMenuOpened>(_onOpened);
    on<StartNewGamePressed>(_onStartNewGame);
    on<ContinueGamePressed>(_onContinueGame);
  }


  Future<void> _onOpened(
      MainMenuOpened event,
      Emitter<MainMenuState> emit,
      ) async {

    emit(
      state.copyWith(
        isLoading: true,
        unfoldingFailure: null,
        gameStarted: false,
      ),
    );

    final result = await getSaveInfoUseCase();

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          hasSave: false,
        ),
      ),
      (save) => emit(
        state.copyWith(
          isLoading: false,
          hasSave: true,
        ),
      ),
    );
  }

  Future<void> _onStartNewGame(
    StartNewGamePressed event,
    Emitter<MainMenuState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        unfoldingFailure: null,
        gameStarted: false,
      ),
    );

    final result = await startNewGameUseCase(
      StartNewGameParams(
        name: event.name ?? 'Player',
        mode: event.gameMode,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          unfoldingFailure: failure is UnfoldingFailure
              ? failure
              : UnfoldingFailure(message: failure.message),
        ),
      ),
      (save) => emit(
        state.copyWith(
          isLoading: false,
          gameStarted: true,
        ),
      ),
    );
  }

  Future<void> _onContinueGame(
    ContinueGamePressed event,
    Emitter<MainMenuState> emit,
  ) async {
    if (state.hasSave) {
      emit(
        state.copyWith(
          gameStarted: true,
        ),
      );
    }
  }
}
