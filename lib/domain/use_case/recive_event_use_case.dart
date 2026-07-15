import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/game_event_entity.dart';
import 'package:summer_budget_game/domain/failure/unfolding_failure.dart';
import 'dart:math';

import '../failure/writing_failure.dart';
import '../repository/game_repository.dart';
import 'check_state_use_case.dart';

//Случайным образом выпадает GameEvent, применяется эффект, если нет options
@lazySingleton
class ReciveEventUseCase extends UseCaseNoPrarms<GameEventEntity> {
  final GameRepository gameRepository;
  final CheckStateUseCase checkStateUseCase;

  static const positiveEventRollCap = 0.15;
  static const negativeEventRollCap = 0.3;

  ReciveEventUseCase({required this.gameRepository, required this.checkStateUseCase});

  @override
  Future<Either<Failure, GameEventEntity>> call() async {
    final eventsResult = await gameRepository.readGameEvents();

    return await eventsResult.fold(
      (failure) async => Left(UnfoldingFailure()),
      (events) async {
        final random = Random();
        final roll = random.nextDouble();

        final positiveEvents = <GameEventEntity>[];
        final negativeEvents = <GameEventEntity>[];

        for (final event in events) {
          if (event.ID == 0) continue;

          bool hasNegative = _isAnyDeltaNegative(
            event.moneyDelta,
            event.energyDelta,
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
        if (roll <= positiveEventRollCap) {
          selectedEvent = positiveEvents.isEmpty
              ? const GameEventEntity(ID: 0)
              : positiveEvents[random.nextInt(positiveEvents.length)];
        } else if (roll <= negativeEventRollCap) {
          selectedEvent = negativeEvents.isEmpty
              ? const GameEventEntity(ID: 0)
              : negativeEvents[random.nextInt(negativeEvents.length)];
        } else {
          selectedEvent = const GameEventEntity(ID: 0);
        }

        final saveRecordResult = await gameRepository.readSaveRecord();
        return await saveRecordResult.fold(
          (failure) async => Left(UnfoldingFailure()),
          (record) async {
            final inflation = record.gameRecord.inflationLevel;
            var updatedRecord = record.copyWith(
              gameRecord: record.gameRecord.copyWith(currentEvent: selectedEvent),
            );

            if (selectedEvent.ID != 0 && selectedEvent.options.isEmpty) {
              final effectiveMoneyDelta = selectedEvent.moneyDelta < 0 
                  ? (selectedEvent.moneyDelta * inflation).round() 
                  : selectedEvent.moneyDelta;

              updatedRecord = updatedRecord.copyWith(
                characterRecord: updatedRecord.characterRecord.copyWith(
                  balance: updatedRecord.characterRecord.balance + effectiveMoneyDelta,
                  energy: (updatedRecord.characterRecord.energy + selectedEvent.energyDelta).clamp(-1, 100),
                  happiness: (updatedRecord.characterRecord.happiness + selectedEvent.happinessDelta).clamp(-1, 100),
                  finIQ: updatedRecord.characterRecord.finIQ + selectedEvent.finIQDelta,
                  score: updatedRecord.characterRecord.score + selectedEvent.pointsDelta,
                ),
              );
            }

            await checkStateUseCase();

            final writeResult = await gameRepository.writeSaveRecord(updatedRecord);
            return writeResult.fold(
              (f) => Left(WritingFailure()),
              (_) => Right(selectedEvent),
            );
          },
        );
      },
    );
  }

  bool _isAnyDeltaNegative(int moneyDelta, int energyDelta, int happinessDelta, int finIQDelta, int pointsDelta) {
    return moneyDelta < 0 || energyDelta < 0 || happinessDelta < 0 || finIQDelta < 0 || pointsDelta < 0;
  }
}
