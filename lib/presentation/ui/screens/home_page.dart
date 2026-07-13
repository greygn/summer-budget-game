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
    context.read<MainMenuBloc>().add(MainMenuOpened());
  }

  void _showModeSelection(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(UiRadius.extraLarge)),
      ),
      builder: (context) => SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final adaptive = AdaptiveLayout.of(constraints);
            
            return Padding(
              padding: EdgeInsets.all(adaptive.padding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.start_new_game,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: adaptive.headlineTextSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: UiSpacing.xl),
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
                  const SizedBox(height: UiSpacing.lg),
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
            );
          },
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
          context.router.pushPath('/dashboard');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.inversePrimary,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final adaptive = AdaptiveLayout.of(constraints);
            
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: UiWidths.compact),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: adaptive.padding),
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
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: adaptive.headlineTextSize,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: UiSpacing.xxl),
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
                            const SizedBox(height: UiSpacing.lg),
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
                          const SizedBox(height: UiSpacing.lg),
                          MenuButton(
                            label: t.leaderboard,
                            icon: Icons.leaderboard,
                            onPressed: () => context.router.pushPath('/records'),
                            backgroundColor: theme.colorScheme.secondaryContainer,
                            foregroundColor: theme.colorScheme.onSecondaryContainer,
                          ),
                          const SizedBox(height: UiSpacing.xxl),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => MyApp.of(context)?.setLocale(const Locale('en')),
                                child: Text(
                                  "English",
                                  style: TextStyle(fontSize: adaptive.bodyTextSize),
                                ),
                              ),
                              Text(
                                "|",
                                style: TextStyle(fontSize: adaptive.bodyTextSize),
                              ),
                              TextButton(
                                onPressed: () => MyApp.of(context)?.setLocale(const Locale('ru')),
                                child: Text(
                                  "Русский",
                                  style: TextStyle(fontSize: adaptive.bodyTextSize),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
