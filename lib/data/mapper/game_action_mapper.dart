import 'package:drift/drift.dart' as drift;

import '../../core/database/app_database.dart';
import '../../domain/entity/game_action_category_entity.dart';
import '../../domain/entity/game_action_entity.dart';

extension GameActionMapper on GameAction {
  GameActionEntity toEntity({
    required GameActionCategoryEntity category,
  }) {
    return GameActionEntity(
      ID: id,
      category: category,
      moneyDelta: moneyDelta,
      happinessDelta: happinessDelta,
      energyDelta: energyDelta,
      finIQDelta: finIQDelta,
      savingsDelta: savingsDelta,
      pointsForAction: pointsForAction,
      timeCost: timeCost,
    );
  }
}

extension GameActionEntityMapper on GameActionEntity {
  GameActionsCompanion toCompanion() {
    return GameActionsCompanion.insert(
      id: drift.Value(ID),
      categoryId: category.ID,
      moneyDelta: drift.Value(moneyDelta),
      happinessDelta: drift.Value(happinessDelta),
      energyDelta: drift.Value(energyDelta),
      finIQDelta: drift.Value(finIQDelta),
      savingsDelta: drift.Value(savingsDelta),
      pointsForAction: drift.Value(pointsForAction),
      timeCost: drift.Value(timeCost),
    );
  }
}
