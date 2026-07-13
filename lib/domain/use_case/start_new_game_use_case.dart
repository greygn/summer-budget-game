import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/core/failure/failure.dart';
import 'package:summer_budget_game/core/use_case/use_case.dart';
import 'package:summer_budget_game/domain/entity/character_record_entity.dart';
import 'package:summer_budget_game/domain/entity/game_event_entity.dart';
import 'package:summer_budget_game/domain/entity/game_mode.dart';
import 'package:summer_budget_game/domain/entity/game_record_entity.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

import '../repository/game_repository.dart';

class StartNewGameParams {
  final String name;
  final GameMode mode;

  StartNewGameParams({required this.name, required this.mode});
}

//Начало игры, создание сохранения
@lazySingleton
class StartNewGameUseCase extends UseCase<SaveRecordEntity, StartNewGameParams> {
  final GameRepository gameRepository;

  static const defaultBalance = 15000;
  static const defaultEnergy = 60;
  static const defaultFinIQ = 0;
  static const defaultHappiness = 50;
  static const defaultSavings = 0;
  static const defaultScore = 0;
  static const defaultCurrentDay = 0;
  static const defaultInflationLevel = 1.0;
  static const defaultTimeLeft = 12;

  static const standardAllowedDays = 30;
  static const marathonAllowedDays = 0;

  StartNewGameUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(StartNewGameParams params) {
    CharacterRecordEntity basicCharacter = CharacterRecordEntity(
      balance: defaultBalance,
      energy: defaultEnergy,
      finIQ: defaultFinIQ,
      happiness: defaultHappiness,
      savings: defaultSavings,
      score: defaultScore,
      job: JobEntity(ID: 0),
    );
    GameRecordEntity basicGame = GameRecordEntity(
      currentDay: defaultCurrentDay,
      allowedDays: params.mode == GameMode.standard ? standardAllowedDays : marathonAllowedDays,
      gameMode: params.mode,
      inflationLevel: defaultInflationLevel,
      timeLeft: defaultTimeLeft,
      currentEvent: GameEventEntity(ID: 0),
    );
    return gameRepository.writeSaveRecord(
      SaveRecordEntity(
        name: params.name,
        characterRecord: basicCharacter,
        gameRecord: basicGame,
      ),
    );
  }
}
