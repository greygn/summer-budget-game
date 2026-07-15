import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/domain/use_case/get_leaderboard_use_case.dart';
import 'package:summer_budget_game/domain/use_case/win_game_use_case.dart';
import 'package:summer_budget_game/presentation/bloc/leaderboard/leaderboard_event.dart';
import 'package:summer_budget_game/presentation/bloc/leaderboard/leaderboard_state.dart';

@injectable
class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboardUseCase getLeaderboardUseCase;
  final WinGameUseCase winGameUseCase;

  LeaderboardBloc({
    required this.getLeaderboardUseCase,
    required this.winGameUseCase,
  }) : super(const LeaderboardState()) {
    on<LeaderboardOpened>(_onOpened);
    on<AddLeaderboardRecord>(_onAddRecord);
  }

  Future<void> _onOpened(
      LeaderboardOpened event,
      Emitter<LeaderboardState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await getLeaderboardUseCase();

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, failure: failure)),
      (records) => emit(state.copyWith(
        isLoading: false,
        records: records,
      )),
    );
  }

  Future<void> _onAddRecord(
      AddLeaderboardRecord event,
      Emitter<LeaderboardState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    final result = await winGameUseCase(event.name);

    await result.fold(
          (failure) async => emit(state.copyWith(isLoading: false, failure: failure)),
          (_) async {
        add(LeaderboardOpened());
      },
    );
  }
}