import 'package:get_it/get_it.dart';

import '../../core/database/app_database.dart';

import '../../core/database/dao/game_action_categories_dao.dart';
import '../../core/database/dao/game_actions_dao.dart';
import '../../core/database/dao/game_event_options_dao.dart';
import '../../core/database/dao/game_events_dao.dart';
import '../../core/database/dao/jobs_dao.dart';
import '../../core/database/dao/leaderboard_dao.dart';
import '../../core/database/dao/save_record_dao.dart';

import '../../data/datasource/local/local_data_source.dart';
import '../../data/datasource/local/local_data_source_impl.dart';

import '../../data/repository/game_repository_impl.dart';
import '../../domain/repository/game_repository.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Database
  sl.registerLazySingleton<AppDatabase>(
        () => AppDatabase(),
  );

  // DAO
  sl.registerLazySingleton(
        () => JobsDao(sl()),
  );

  sl.registerLazySingleton(
        () => GameActionCategoriesDao(sl()),
  );

  sl.registerLazySingleton(
        () => GameActionsDao(sl()),
  );

  sl.registerLazySingleton(
        () => GameEventsDao(sl()),
  );

  sl.registerLazySingleton(
        () => GameEventOptionsDao(sl()),
  );

  sl.registerLazySingleton(
        () => SaveRecordDao(sl()),
  );

  sl.registerLazySingleton(
        () => LeaderboardDao(sl()),
  );

  // LocalDataSource
  sl.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(
      jobsDao: sl(),
      categoriesDao: sl(),
      actionsDao: sl(),
      eventsDao: sl(),
      optionsDao: sl(),
      saveDao: sl(),
      leaderboardDao: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<GameRepository>(
        () => GameRepositoryImpl(sl()),
  );
}
