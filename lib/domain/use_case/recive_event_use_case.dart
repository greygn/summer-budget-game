import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_event_entity.dart';
import 'dart:math';

import '../repository/game_repository.dart';

//Случайным образом выпадает GameEvent, применяется эффект, если нет options
class ReciveEventUseCase extends UseCaseNoPrarms<GameEventEntity> {
  final GameRepository gameRepository;

  ReciveEventUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, GameEventEntity>> call() async {
    final eventsResult = await gameRepository.readGameEvents();

    return await eventsResult.fold(
      (failure) async => Left(failure),
      (events) async {
        final random = Random();
        final roll = random.nextDouble();

        final positiveEvents = <GameEventEntity>[];
        final negativeEvents = <GameEventEntity>[];

        for (final event in events) {
          if (event.ID == 0) continue;

          bool hasNegative = _isAnyDeltaNegative(
            event.moneyDelta,
            event.happinessDelta,
            event.finIQDelta,
            event.pointsDelta,
          );

          if (hasNegative) {
            negativeEvents.add(event);
          } else {
            positiveEvents.add(event);
          }
        }

        GameEventEntity selectedEvent;
        if (roll <= 0.7) {
          selectedEvent = const GameEventEntity(ID: 0);
        } else if (roll <= 0.85) {
          selectedEvent = positiveEvents.isEmpty
              ? const GameEventEntity(ID: 0)
              : positiveEvents[random.nextInt(positiveEvents.length)];
        } else {
          selectedEvent = negativeEvents.isEmpty
              ? const GameEventEntity(ID: 0)
              : negativeEvents[random.nextInt(negativeEvents.length)];
        }

        final saveRecordResult = await gameRepository.readSaveRecord();
        return await saveRecordResult.fold(
          (failure) async => Left(failure),
          (record) async {
            var updatedRecord = record.copyWith(
              gameRecord: record.gameRecord.copyWith(currentEvent: selectedEvent),
            );

            if (selectedEvent.ID != 0 && selectedEvent.options.isEmpty) {
              updatedRecord = updatedRecord.copyWith(
                characterRecord: updatedRecord.characterRecord.copyWith(
                  balance: updatedRecord.characterRecord.balance + selectedEvent.moneyDelta,
                  happiness: updatedRecord.characterRecord.happiness + selectedEvent.happinessDelta,
                  finIQ: updatedRecord.characterRecord.finIQ + selectedEvent.finIQDelta,
                  score: updatedRecord.characterRecord.score + selectedEvent.pointsDelta,
                ),
              );
            }

            final writeResult = await gameRepository.writeSaveRecord(updatedRecord);
            return writeResult.fold(
              (f) => Left(f),
              (_) => Right(selectedEvent),
            );
          },
        );
      },
    );
  }

  bool _isAnyDeltaNegative(int m, int h, int f, int p) {
    return m < 0 || h < 0 || f < 0 || p < 0;
  }
}
