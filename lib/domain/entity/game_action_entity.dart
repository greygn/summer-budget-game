import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_action_category_entity.dart';

part 'game_action_entity.freezed.dart';

@freezed
abstract class GameActionEntity with _$GameActionEntity{
  const GameActionEntity._();

  const factory GameActionEntity({
    required int ID,
    @Default('') String name,
    required GameActionCategoryEntity category,
    @Default(0) int moneyDelta,
    @Default(0) int happinessDelta,
    @Default(0) int finIQDelta,
    @Default(0) int savingsDelta,
    @Default(0) int pointsForAction,
    @Default(0) int timeCost,
  }) = _GameActionEntity;
}