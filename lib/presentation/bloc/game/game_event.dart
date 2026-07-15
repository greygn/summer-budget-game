import '../../../domain/entity/game_action_entity.dart';
import '../../../domain/entity/game_event_option_entity.dart';
import '../../../domain/entity/job_entity.dart';

sealed class GameEvent {}

final class GameStarted extends GameEvent {}

final class GameActionSelected extends GameEvent {
  final GameActionEntity action;
  GameActionSelected(this.action);
}

final class GameEventOptionSelected extends GameEvent {
  final GameEventOptionEntity option;
  GameEventOptionSelected(this.option);
}

final class JobSelected extends GameEvent {
  final JobEntity job;
  JobSelected(this.job);
}

final class EndDayPressed extends GameEvent {}

final class CheckGameStateRequested extends GameEvent {}
