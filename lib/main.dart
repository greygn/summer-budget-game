import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:summer_budget_game/app_router.dart';
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

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<MainMenuBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<LeaderboardBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GameBloc>(),
        ),
      ],
      child: MyApp(router: getIt<AppRouter>()),
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
          navigatorObservers: () => [TalkerRouteObserver(getIt<Talker>())]
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
