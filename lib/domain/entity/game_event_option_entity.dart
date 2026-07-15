import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_event_option_entity.freezed.dart';

@freezed
abstract class GameEventOptionEntity with _$GameEventOptionEntity{
  const GameEventOptionEntity._();

  const factory GameEventOptionEntity({
    required int ID,
    @Default(0) int moneyDelta,
    @Default(0) int energyDelta,
    @Default(0) int happinessDelta,
    @Default(0) int finIQDelta,
    @Default(0) int pointsDelta
}) = _GameEventOptionEntity;
}