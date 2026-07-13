import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
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
  static SaveRecordEntity? _currentSave;
  static final List<LeaderboardRecordEntity> _leaderboard = [];

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
        nameRu: 'Buy Coffee', 
        nameEn: 'Buy Coffee',
        category: GameActionCategoryEntity(ID: 1, nameRu: 'Food', nameEn: 'Food'),
        moneyDelta: -250,
        happinessDelta: 5,
        timeCost: 0,
      ),
      const GameActionEntity(
        ID: 2,
        nameRu: 'Go to Gym',
        nameEn: 'Go to Gym',
        category: GameActionCategoryEntity(ID: 2, nameRu: 'Health', nameEn: 'Health'),
        moneyDelta: -500,
        happinessDelta: 10,
        timeCost: 2,
      ),
      const GameActionEntity(
        ID: 3,
        nameRu: 'Watch Movie',
        nameEn: 'Watch Movie',
        category: GameActionCategoryEntity(ID: 3, nameRu: 'Leisure', nameEn: 'Leisure'),
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
        nameRu: 'Courier',
        nameEn: 'Courier',
        salary: 1500,
        energyCost: 20,
        timeCost: 6,
      ),
      const JobEntity(
        ID: 2,
        nameRu: 'Waiter',
        nameEn: 'Waiter',
        salary: 2000,
        energyCost: 25,
        timeCost: 8,
      ),
      const JobEntity(
        ID: 3,
        nameRu: 'Intern Programmer',
        nameEn: 'Intern Programmer',
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
        moneyDelta: 1000,
        happinessDelta: 10,
      ),
      GameEventEntity(
        ID: 2,
        titleRu: 'Неожиданная поломка',
        titleEn: 'Unexpected Breakdown',
        descriptionRu: 'Ваш телефон упал и экран разбился. Ремонт обойдется в 3000 рублей.',
        descriptionEn: 'Your phone broke. Repair will cost 3000 rubles.',
        moneyDelta: -3000,
        happinessDelta: -15,
      ),
      GameEventEntity(
        ID: 3,
        titleRu: 'Премия!',
        titleEn: 'Bonus!',
        descriptionRu: 'Ваш начальник доволен вашей работой и выписал вам небольшую премию.',
        descriptionEn: 'Your boss is happy with your work and gave you a bonus.',
        moneyDelta: 5000,
        happinessDelta: 20,
        options: [
          GameEventOptionEntity(
            descriptionRu: 'Положить в копилку',
            descriptionEn: 'Save it',
            moneyDelta: 0,
            happinessDelta: 5,
          ),
          GameEventOptionEntity(
            descriptionRu: 'Отпраздновать в ресторане',
            descriptionEn: 'Celebrate at restaurant',
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
