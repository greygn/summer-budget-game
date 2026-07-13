import 'package:injectable/injectable.dart';
import 'package:summer_budget_game/domain/entity/game_action_category_entity.dart';
import 'package:summer_budget_game/domain/entity/game_action_entity.dart';
import 'package:summer_budget_game/domain/entity/game_event_entity.dart';
import 'package:summer_budget_game/domain/entity/game_event_option_entity.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';
import 'package:summer_budget_game/domain/entity/leaderboard_record_entity.dart';
import 'package:summer_budget_game/domain/entity/save_record_entity.dart';

import '../../../core/database/dao/game_action_categories_dao.dart';
import '../../../core/database/dao/game_actions_dao.dart';
import '../../../core/database/dao/game_event_options_dao.dart';
import '../../../core/database/dao/game_events_dao.dart';
import '../../../core/database/dao/jobs_dao.dart';
import '../../../core/database/dao/leaderboard_dao.dart';
import '../../../core/database/dao/save_record_dao.dart';

import '../../mapper/game_action_category_mapper.dart';
import '../../mapper/game_action_mapper.dart';
import '../../mapper/game_event_mapper.dart';
import '../../mapper/game_event_option_mapper.dart';
import '../../mapper/job_mapper.dart';
import '../../mapper/leaderboard_mapper.dart';
import '../../mapper/save_record_mapper.dart';
import 'local_data_source.dart';

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {

  final JobsDao jobsDao;

  final GameActionCategoriesDao categoriesDao;

  final GameActionsDao actionsDao;

  final GameEventsDao eventsDao;

  final GameEventOptionsDao optionsDao;

  final SaveRecordDao saveDao;

  final LeaderboardDao leaderboardDao;

  LocalDataSourceImpl({
    required this.jobsDao,
    required this.categoriesDao,
    required this.actionsDao,
    required this.eventsDao,
    required this.optionsDao,
    required this.saveDao,
    required this.leaderboardDao,
  });

  @override
  Future<List<GameActionCategoryEntity>> readGameActionCategories() async {
    final rows = await categoriesDao.getAll();

    return rows
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<List<GameActionEntity>> readGameActions() async {
    final categories = await categoriesDao.getAll();

    final actions = await actionsDao.getAll();

    return actions.map((action) {

      final category = categories.firstWhere(
            (e) => e.id == action.categoryId,
      );

      return action.toEntity(
        category: category.toEntity(),
      );

    }).toList();
  }

  @override
  Future<List<GameEventOptionEntity>>
  readGameEventOptions(GameEventEntity event) async {
    final rows =
    await optionsDao.getByEventId(event.ID);

    return rows
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<List<GameEventEntity>> readGameEvents() async {
    final events = await eventsDao.getAll();

    final options = await optionsDao.getAll();

    return events.map((event) {

      final eventOptions =
      options
          .where(
            (e) => e.eventId == event.id,
      )
          .map(
            (e) => e.toEntity(),
      )
          .toList();

      return event.toEntity(
        options: eventOptions,
      );

    }).toList();
  }

  @override
  Future<List<JobEntity>> readJobs() async {
    final rows = await jobsDao.getAll();

    return rows
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<List<LeaderboardRecordEntity>> readLeaderboard() async {
    final rows =
        await leaderboardDao.getAll();

    return rows
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<SaveRecordEntity?> readSaveRecord() async {
    final save = await saveDao.getSave();

    if (save == null) {
      return null;
    }

    final job =
        await jobsDao.getById(save.jobId);

    final event =
        await eventsDao.getById(save.currentEventId);

    if (job == null || event == null) {
      return null;
    }

    final options =
        await optionsDao.getByEventId(event.id);

    return save.toEntity(
      job: job.toEntity(),
      currentEvent: event.toEntity(
        options: options
            .map((e) => e.toEntity())
            .toList(),
      ),
    );
  }

  @override
  Future<void> writeLeaderboard(LeaderboardRecordEntity record) async {
    await leaderboardDao.insert(
      record.toCompanion(),
    );
  }

  @override
  Future<void> writeSaveRecord(SaveRecordEntity save) async {
    await saveDao.save(
      save.toCompanion(),
    );
  }
}
