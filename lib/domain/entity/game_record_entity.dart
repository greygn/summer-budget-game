import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:summer_budget_game/domain/entity/game_mode.dart';
import 'game_event_entity.dart';

part 'game_record_entity.freezed.dart';

@freezed
abstract class GameRecordEntity with _$GameRecordEntity {
  const GameRecordEntity._();

  const factory GameRecordEntity({
    @Default(0) int currentDay,
    @Default(0) int allowedDays,
    @Default(0) int timeLeft,
    @Default(GameMode.standard) GameMode gameMode,
    @Default(0) double inflationLevel,
    @Default(false) bool isOver,
    required GameEventEntity currentEvent
  }) = _GameRecordEntity;
}
