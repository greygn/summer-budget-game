import 'package:drift/drift.dart' as drift;

import '../../core/database/app_database.dart';
import '../../domain/entity/game_event_entity.dart';
import '../../domain/entity/game_event_option_entity.dart';

extension GameEventMapper on GameEvent {
  GameEventEntity toEntity({
    required List<GameEventOptionEntity> options,
  }) {
    return GameEventEntity(
      ID: id,
      title: title,
      description: description,
      moneyDelta: moneyDelta,
      happinessDelta: happinessDelta,
      finIQDelta: finIQDelta,
      pointsDelta: pointsDelta,
      options: options,
    );
  }
}

extension GameEventEntityMapper on GameEventEntity {
  GameEventsCompanion toCompanion() {
    return GameEventsCompanion.insert(
      id: drift.Value(ID),
      title: title,
      description: description,
      moneyDelta: drift.Value(moneyDelta),
      happinessDelta: drift.Value(happinessDelta),
      finIQDelta: drift.Value(finIQDelta),
      pointsDelta: drift.Value(pointsDelta),
    );
  }
}
