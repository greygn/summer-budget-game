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
      titleRu: titleRu,
      titleEn: titleEn,
      descriptionRu: descriptionRu,
      descriptionEn: descriptionEn,
      moneyDelta: moneyDelta,
      energyDelta: energyDelta,
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
      titleRu: titleRu,
      titleEn: titleEn,
      descriptionRu: descriptionRu,
      descriptionEn: descriptionEn,
      moneyDelta: drift.Value(moneyDelta),
      energyDelta: drift.Value(energyDelta),
      happinessDelta: drift.Value(happinessDelta),
      finIQDelta: drift.Value(finIQDelta),
      pointsDelta: drift.Value(pointsDelta),
    );
  }
}
