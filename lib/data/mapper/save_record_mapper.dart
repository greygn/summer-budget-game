import 'package:drift/drift.dart' as drift;

import '../../core/database/app_database.dart';
import '../../domain/entity/character_record_entity.dart';
import '../../domain/entity/game_event_entity.dart';
import '../../domain/entity/game_mode.dart';
import '../../domain/entity/game_record_entity.dart';
import '../../domain/entity/job_entity.dart';
import '../../domain/entity/save_record_entity.dart';

extension SaveRecordMapper on SaveRecord {
  SaveRecordEntity toEntity({
    required JobEntity job,
    required GameEventEntity currentEvent,
  }) {
    return SaveRecordEntity(
      name: playerName,
      characterRecord: CharacterRecordEntity(
        balance: balance,
        savings: savings,
        happiness: happiness,
        energy: energy,
        finIQ: finIQ,
        score: score,
        job: job,
      ),
      gameRecord: GameRecordEntity(
        currentDay: currentDay,
        allowedDays: allowedDays,
        timeLeft: timeLeft,
        gameMode: GameMode.values[gameMode],
        inflationLevel: inflationLevel,
        isOver: isOver,
        currentEvent: currentEvent,
      ),
    );
  }
}

extension SaveRecordEntityMapper on SaveRecordEntity {
  SaveRecordsCompanion toCompanion() {
    return SaveRecordsCompanion.insert(
      id: const drift.Value(1),
      playerName: name,
      balance: drift.Value(characterRecord.balance),
      savings: drift.Value(characterRecord.savings),
      happiness: drift.Value(characterRecord.happiness),
      energy: drift.Value(characterRecord.energy),
      finIQ: drift.Value(characterRecord.finIQ),
      score: drift.Value(characterRecord.score),
      jobId: characterRecord.job.ID,
      currentDay: drift.Value(gameRecord.currentDay),
      allowedDays: drift.Value(gameRecord.allowedDays),
      timeLeft: drift.Value(gameRecord.timeLeft),
      gameMode: drift.Value(gameRecord.gameMode.index),
      inflationLevel: drift.Value(gameRecord.inflationLevel),
      isOver: drift.Value(gameRecord.isOver),
      currentEventId: gameRecord.currentEvent.ID,
    );
  }
}
