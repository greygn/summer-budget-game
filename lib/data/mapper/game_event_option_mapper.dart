import 'package:drift/drift.dart' as drift;

import '../../core/database/app_database.dart';
import '../../domain/entity/game_event_option_entity.dart';

extension GameEventOptionMapper on GameEventOption {
  GameEventOptionEntity toEntity() {
    return GameEventOptionEntity(
      ID: id,
      moneyDelta: moneyDelta,
      energyDelta: energyDelta,
      happinessDelta: happinessDelta,
      finIQDelta: finIQDelta,
      pointsDelta: pointsDelta,
    );
  }
}

extension GameEventOptionEntityMapper on GameEventOptionEntity {
  GameEventOptionsCompanion toCompanion({
    required int eventId,
  }) {
    return GameEventOptionsCompanion.insert(
      id: drift.Value(ID),
      eventId: eventId,
      moneyDelta: drift.Value(moneyDelta),
      energyDelta: drift.Value(energyDelta),
      happinessDelta: drift.Value(happinessDelta),
      finIQDelta: drift.Value(finIQDelta),
      pointsDelta: drift.Value(pointsDelta),
    );
  }
}
