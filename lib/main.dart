import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:summer_budget_game/app_router.dart';
import 'package:summer_budget_game/data/repository/mock_game_repository.dart';
import 'package:summer_budget_game/domain/use_case/check_state_use_case.dart';
import 'package:summer_budget_game/domain/use_case/end_day_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_game_actions_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_jobs_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_leaderboard_use_case.dart';
import 'package:summer_budget_game/domain/use_case/get_save_info_use_case.dart';
import 'package:summer_budget_game/domain/use_case/recive_event_use_case.dart';
import 'package:summer_budget_game/domain/use_case/select_game_action_use_case.dart';
import 'package:summer_budget_game/domain/use_case/select_game_event_option.dart';
import 'package:summer_budget_game/domain/use_case/select_job_use_case.dart';
import 'package:summer_budget_game/domain/use_case/start_new_game_use_case.dart';
import 'package:summer_budget_game/domain/use_case/win_game_use_case.dart';
import 'package:summer_budget_game/presentation/bloc/game/game_bloc.dart';
import 'package:summer_budget_game/presentation/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:summer_budget_game/presentation/bloc/main_menu/main_menu_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'core/di/injection.dart';
import 'l10n/app_localizations.dart';
import 'package:ui_kit/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  
  final gameRepository = MockGameRepository();

  // Use cases initialization
  final getSaveInfoUseCase = GetSaveInfoUseCase(gameRepository: gameRepository);
  final startNewGameUseCase = StartNewGameUseCase(gameRepository: gameRepository);
  final getLeaderboardUseCase = GetLeaderboardUseCase(gameRepository: gameRepository);
  final winGameUseCase = WinGameUseCase(gameRepository: gameRepository);
  final checkStateUseCase = CheckStateUseCase(gameRepository: gameRepository);
  final endDayUseCase = EndDayUseCase(
    gameRepository: gameRepository,
    checkStateUseCase: checkStateUseCase,
  );
  final getGameActionsUseCase = GetGameActionsUseCase(
    gameRepository: gameRepository,
    getSaveInfoUseCase: getSaveInfoUseCase,
  );
  final getJobsUseCase = GetJobsUseCase(gameRepository: gameRepository);
  final reciveEventUseCase = ReciveEventUseCase(
    gameRepository: gameRepository,
    checkStateUseCase: checkStateUseCase,
  );
  final selectGameActionUseCase = SelectGameActionUseCase(
    gameRepository: gameRepository,
    checkStateUseCase: checkStateUseCase,
  );
  final selectGameEventOptionUseCase = SelectGameEventOption(
    gameRepository: gameRepository,
    checkStateUseCase: checkStateUseCase,
  );
  final selectJobUseCase = SelectJobUseCase(gameRepository: gameRepository);

  final appRouter = AppRouter();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainMenuBloc(
            getSaveInfoUseCase: getSaveInfoUseCase,
            startNewGameUseCase: startNewGameUseCase,
          ),
        ),
        BlocProvider(
          create: (context) => LeaderboardBloc(
            getLeaderboardUseCase: getLeaderboardUseCase,
            winGameUseCase: winGameUseCase,
          ),
        ),
        BlocProvider(
          create: (context) => GameBloc(
            getSaveInfoUseCase: getSaveInfoUseCase,
            getGameActionsUseCase: getGameActionsUseCase,
            getJobsUseCase: getJobsUseCase,
            selectGameActionUseCase: selectGameActionUseCase,
            selectGameEventOptionUseCase: selectGameEventOptionUseCase,
            selectJobUseCase: selectJobUseCase,
            endDayUseCase: endDayUseCase,
            checkStateUseCase: checkStateUseCase,
            reciveEventUseCase: reciveEventUseCase,
          ),
        ),
      ],
      child: MyApp(router: appRouter),
    ),
  );
}

class MyApp extends StatefulWidget {
  final AppRouter router;
  const MyApp({super.key, required this.router});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  Locale? _locale;
  final talker = Talker();

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: widget.router.config(
          navigatorObservers: () => [TalkerRouteObserver(talker)]
      ),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Summer Budget Game',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}
