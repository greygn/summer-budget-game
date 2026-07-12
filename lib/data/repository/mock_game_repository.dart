import 'package:dartz/dartz.dart';
import 'package:summer_budget_game/domain/entity/game_action_category_entity.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';
import 'package:summer_budget_game/domain/entity/game_event_entity.dart';
import 'package:summer_budget_game/domain/entity/game_event_option_entity.dart';
import 'package:summer_budget_game/domain/entity/game_failure.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';
import 'package:summer_budget_game/domain/entity/leaderboard_record_entity.dart';
import 'package:summer_budget_game/domain/repository/game_repository.dart';

class MockGameRepository implements GameRepository {
  SaveRecordEntity? _currentSave;
  final List<LeaderboardRecordEntity> _leaderboard = [];

  @override
  Future<Either<GameFailure, SaveRecordEntity>> readSaveRecord() async {
    if (_currentSave == null) {
      return Left(GameFailure(message: 'No save found', code: 1));
    }
    return Right(_currentSave!);
  }

  @override
  Future<Either<GameFailure, SaveRecordEntity>> writeSaveRecord(SaveRecordEntity saveRecord) async {
    _currentSave = saveRecord;
    return Right(_currentSave!);
  }

  @override
  Future<Either<GameFailure, List<GameActionEntity>>> readGameActions() async {
    return Right([
      const GameActionEntity(
        ID: 1,
        name: 'Buy Coffee', 
        category: GameActionCategoryEntity(ID: 1, name: 'Food'),
        moneyDelta: -250,
        happinessDelta: 5,
        timeCost: 0,
      ),
      const GameActionEntity(
        ID: 2,
        name: 'Go to Gym',
        category: GameActionCategoryEntity(ID: 2, name: 'Health'),
        moneyDelta: -500,
        happinessDelta: 10,
        timeCost: 2,
      ),
      const GameActionEntity(
        ID: 3,
        name: 'Watch Movie',
        category: GameActionCategoryEntity(ID: 3, name: 'Leisure'),
        moneyDelta: -400,
        happinessDelta: 15,
        timeCost: 3,
      ),
    ]);
  }

  @override
  Future<Either<GameFailure, List<JobEntity>>> readJobs() async {
    return Right([
      const JobEntity(
        ID: 1,
        name: 'Courier',
        salary: 1500,
        energyCost: 20,
        timeCost: 6,
      ),
      const JobEntity(
        ID: 2,
        name: 'Waiter',
        salary: 2000,
        energyCost: 25,
        timeCost: 8,
      ),
      const JobEntity(
        ID: 3,
        name: 'Intern Programmer',
        salary: 3000,
        energyCost: 15,
        timeCost: 8,
        minFinIQ: 10,
      ),
    ]);
  }

  @override
  Future<Either<GameFailure, List<GameEventEntity>>> readGameEvents() async {
    return const Right([
      GameEventEntity(
        ID: 1,
        title: 'Находка на улице',
        description: 'Вы гуляли по парку и нашли купюру в 1000 рублей! Сегодня явно ваш день.',
        moneyDelta: 1000,
        happinessDelta: 10,
      ),
      GameEventEntity(
        ID: 2,
        title: 'Неожиданная поломка',
        description: 'Ваш телефон упал и экран разбился. Ремонт обойдется в 3000 рублей.',
        moneyDelta: -3000,
        happinessDelta: -15,
      ),
      GameEventEntity(
        ID: 3,
        title: 'Премия!',
        description: 'Ваш начальник доволен вашей работой и выписал вам небольшую премию.',
        moneyDelta: 5000,
        happinessDelta: 20,
        options: [
          GameEventOptionEntity(
            description: 'Положить в копилку',
            moneyDelta: 0,
            happinessDelta: 5,
          ),
          GameEventOptionEntity(
            description: 'Отпраздновать в ресторане',
            moneyDelta: -2000,
            happinessDelta: 25,
          ),
        ],
      ),
    ]);
  }

  @override
  Future<Either<GameFailure, List<GameEventOptionEntity>>> readGameEventOptions(GameEventEntity event) async {
    return Right(event.options);
  }

  @override
  Future<Either<GameFailure, List<LeaderboardRecordEntity>>> readLeaderboard() async {
    return Right(List.from(_leaderboard));
  }

  @override
  Future<Either<GameFailure, void>> writeLeaderboard(LeaderboardRecordEntity record) async {
    _leaderboard.add(record);
    return const Right(null);
  }
}
