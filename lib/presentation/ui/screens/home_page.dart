import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../domain/entity/game_mode.dart';
import '../../../l10n/app_localizations.dart';
import '../../../main.dart';
import '../../bloc/main_menu/main_menu_bloc.dart';
import '../../bloc/main_menu/main_menu_event.dart';
import '../../bloc/main_menu/main_menu_state.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Инициализируем проверку наличия сохранения при открытии экрана
    context.read<MainMenuBloc>().add(MainMenuOpened());
  }

  void _showModeSelection(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t.start_new_game,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ModeItem(
                title: t.sprint_mode,
                subtitle: t.sprint_mode_desc,
                icon: Icons.timer_outlined,
                color: theme.colorScheme.primary,
                onTap: () {
                  Navigator.pop(context);
                  context.read<MainMenuBloc>().add(
                        StartNewGamePressed(gameMode: GameMode.standard),
                      );
                },
              ),
              const SizedBox(height: 16),
              ModeItem(
                title: t.marathon_mode,
                subtitle: t.marathon_mode_desc,
                icon: Icons.all_inclusive_rounded,
                color: theme.colorScheme.secondary,
                onTap: () {
                  Navigator.pop(context);
                  context.read<MainMenuBloc>().add(
                        StartNewGamePressed(gameMode: GameMode.marathon),
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocListener<MainMenuBloc, MainMenuState>(
      listener: (context, state) {
        if (state.gameStarted) {
          // Если игра началась или загружена, переходим к дашборду
          context.router.pushPath('/dashboard');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.inversePrimary,
          title: Text(t.appTitle),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: BlocBuilder<MainMenuBloc, MainMenuState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const CircularProgressIndicator();
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        t.welcome_text,
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 48),
                      if (state.hasSave) ...[
                        MenuButton(
                          label: t.continue_game,
                          icon: Icons.play_arrow,
                          onPressed: () {
                            context.read<MainMenuBloc>().add(ContinueGamePressed());
                          },
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                        ),
                        const SizedBox(height: 16),
                      ],
                      MenuButton(
                        label: t.start_new_game,
                        icon: Icons.add,
                        onPressed: () => _showModeSelection(context),
                        backgroundColor: state.hasSave
                            ? theme.colorScheme.secondaryContainer
                            : theme.colorScheme.primary,
                        foregroundColor: state.hasSave
                            ? theme.colorScheme.onSecondaryContainer
                            : theme.colorScheme.onPrimary,
                      ),
                      const SizedBox(height: 16),
                      MenuButton(
                        label: t.leaderboard,
                        icon: Icons.leaderboard,
                        onPressed: () => context.router.pushPath('/records'),
                        backgroundColor: theme.colorScheme.secondaryContainer,
                        foregroundColor: theme.colorScheme.onSecondaryContainer,
                      ),
                      const SizedBox(height: 48),
                      // Кнопки переключения языка
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => MyApp.of(context)?.setLocale(const Locale('en')),
                            child: const Text("English"),
                          ),
                          const Text("|"),
                          TextButton(
                            onPressed: () => MyApp.of(context)?.setLocale(const Locale('ru')),
                            child: const Text("Русский"),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
