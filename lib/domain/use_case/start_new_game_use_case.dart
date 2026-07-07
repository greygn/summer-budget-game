import 'package:dartz/dartz.dart';
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
class StartNewGameUseCase extends UseCase<SaveRecordEntity, StartNewGameParams> {
  final GameRepository gameRepository;

  StartNewGameUseCase({required this.gameRepository});

  @override
  Future<Either<Failure, SaveRecordEntity>> call(StartNewGameParams params) {
    CharacterRecordEntity basicCharacter = CharacterRecordEntity(
      balance: 15000,
      energy: 60,
      finIQ: 0,
      happiness: 50,
      savings: 0,
      score: 0,
      job: JobEntity(ID: 0),
    );
    GameRecordEntity basicGame = GameRecordEntity(
      currentDay: 0,
      allowedDays: params.mode == GameMode.standard ? 30 : 0,
      gameMode: params.mode,
      inflationLevel: 1.0,
      timeLeft: 12,
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
