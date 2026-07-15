import 'package:equatable/equatable.dart';

import '../../../domain/failure/unfolding_failure.dart';

class MainMenuState extends Equatable {
  final bool isLoading;
  final bool hasSave;
  final bool gameStarted;
  final UnfoldingFailure? unfoldingFailure;


  MainMenuState({
    this.isLoading = false,
    this.hasSave = false,
    this.gameStarted = false,
    this.unfoldingFailure,
  });

  MainMenuState copyWith({
    bool? isLoading,
    bool? hasSave,
    bool? gameStarted,
    UnfoldingFailure? unfoldingFailure,
  }) {
    return MainMenuState(
      isLoading: isLoading ?? this.isLoading,
      hasSave: hasSave ?? this.hasSave,
      gameStarted: gameStarted ?? this.gameStarted,
      unfoldingFailure: unfoldingFailure,
    );
  }

  @override
  List<Object?> get props => [isLoading, hasSave, gameStarted, unfoldingFailure];
}
