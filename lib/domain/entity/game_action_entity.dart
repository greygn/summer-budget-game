import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_action_category_entity.dart';
import 'job_entity.dart';

part 'game_action_entity.freezed.dart';

class ActionDisplayStats {
  final int money;
  final int time;
  final int happiness;
  final int energy;

  ActionDisplayStats({
    required this.money,
    required this.time,
    required this.happiness,
    required this.energy,
  });
}

@freezed
abstract class GameActionEntity with _$GameActionEntity{
  const GameActionEntity._();

  static const int gigId = 100;
  static const int shiftId = 101;
  static const int overtimeId = 102;

  bool get isJobAction => ID >= gigId && ID <= overtimeId;

  ActionDisplayStats getDisplayStats(JobEntity? job) {
    if (isJobAction && job != null) {
      double timeMult = 1.0;
      double moneyMult = 1.0;
      double effortMult = 1.0;

      if (ID == gigId) {
        timeMult = 0.5;
        moneyMult = 0.4;
        effortMult = 0.4;
      } else if (ID == overtimeId) {
        timeMult = 1.5;
        moneyMult = 2.0;
        effortMult = 1.5;
      }

      return ActionDisplayStats(
        money: (job.salary * moneyMult).round(),
        time: (job.timeCost * timeMult).round(),
        happiness: (job.happinessCost * effortMult).round(),
        energy: (job.energyCost * effortMult).round(),
      );
    }

    return ActionDisplayStats(
      money: moneyDelta,
      time: timeCost,
      happiness: happinessDelta,
      energy: energyDelta,
    );
  }

  const factory GameActionEntity({
    required int ID,
    required GameActionCategoryEntity category,
    @Default(0) int moneyDelta,
    @Default(0) int happinessDelta,
    @Default(0) int finIQDelta,
    @Default(0) int savingsDelta,
    @Default(0) int energyDelta,
    @Default(0) int pointsForAction,
    @Default(0) int timeCost,
  }) = _GameActionEntity;
}