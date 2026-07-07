import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_event_option_entity.dart';

part 'game_event_entity.freezed.dart';

@freezed
abstract class GameEventEntity with _$GameEventEntity{
  const GameEventEntity._();

  const factory GameEventEntity({
    required int ID,
    @Default('') String title,
    @Default('') String description,
    @Default(0) int moneyDelta,
    @Default(0) int happinessDelta,
    @Default(0) int finIQDelta,
    @Default(0) int pointsDelta,
    @Default([]) List<GameEventOptionEntity> options
  }) = _GameEventEntity;
}