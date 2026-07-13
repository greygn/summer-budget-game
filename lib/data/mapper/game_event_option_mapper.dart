import 'package:drift/drift.dart' as drift;

import '../../core/database/app_database.dart';
import '../../domain/entity/game_event_option_entity.dart';

extension GameEventOptionMapper on GameEventOption {
  GameEventOptionEntity toEntity() {
    return GameEventOptionEntity(
      description: description,
      moneyDelta: moneyDelta,
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
      eventId: eventId,
      description: description,
      moneyDelta: drift.Value(moneyDelta),
      happinessDelta: drift.Value(happinessDelta),
      finIQDelta: drift.Value(finIQDelta),
      pointsDelta: drift.Value(pointsDelta),
    );
  }
}
