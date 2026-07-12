import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../domain/entity/game_mode.dart';
import '../../../l10n/app_localizations.dart';
import '../../../app_router.gr.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_state.dart';

@RoutePage()
class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          final save = state.saveRecord;
          if (save == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final char = save.characterRecord;
          final game = save.gameRecord;
          final isVictory = _checkVictory(char.balance + char.savings, game.gameMode);
          final color = isVictory ? Colors.green : Colors.red;

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  color.withValues(alpha: 0.15),
                  theme.colorScheme.surface,
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Spacer(),
                    AppHeroIcon(
                      icon: isVictory ? Icons.emoji_events_rounded : Icons.sentiment_very_dissatisfied_rounded,
                      color: color,
                      onColor: Colors.white,
                      heroTag: 'result_icon',
                    ),
                    const SizedBox(height: 32),
                    Text(
                      isVictory ? t.victory_title : t.defeat_title,
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    AppInfoCard(
                      text: isVictory ? t.victory_desc : t.defeat_desc,
                    ),
                    const SizedBox(height: 48),
                    Text(
                      t.final_stats.toUpperCase(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ExpressiveResultStat(
                            label: t.finIQ,
                            value: char.finIQ.toString(),
                            icon: Icons.psychology_outlined,
                            color: isVictory ? Colors.purple : theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ExpressiveResultStat(
                            label: t.score,
                            value: char.score.toString(),
                            icon: Icons.star_outline,
                            color: isVictory ? Colors.amber : theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    AppButton(
                      label: t.back_to_menu,
                      onPressed: () {
                         context.router.replaceAll([const HomeRoute()]);
                      },
                      isFullWidth: true,
                      size: ButtonSize.large,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  bool _checkVictory(int totalAssets, GameMode mode) {
    if (mode == GameMode.standard) {
      return totalAssets >= 100000;
    }
    return totalAssets >= 1000000;
  }
}
