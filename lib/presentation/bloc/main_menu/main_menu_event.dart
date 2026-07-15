import '../../../domain/entity/game_mode.dart';

sealed class MainMenuEvent {}

final class MainMenuOpened extends MainMenuEvent{}

final class StartNewGamePressed extends MainMenuEvent {
   final GameMode gameMode;
   final String? name;
   StartNewGamePressed({required this.gameMode, this.name});
}

final class ContinueGamePressed extends MainMenuEvent {}

