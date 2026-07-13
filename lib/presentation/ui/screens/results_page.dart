import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
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
          final totalAssets = char.balance + char.savings;
          final isVictory = totalAssets >= state.goal;
          final color = isVictory ? Colors.green : Colors.red;

          return LayoutBuilder(
            builder: (context, constraints) {
              final adaptive = AdaptiveLayout.of(constraints);
              final padding = adaptive.padding;

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
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: UiWidths.expanded),
                      child: Padding(
                        padding: EdgeInsets.all(padding),
                        child: Column(
                          children: [
                            const Spacer(),
                            AppHeroIcon(
                              icon: isVictory
                                  ? Icons.emoji_events_rounded
                                  : Icons.sentiment_very_dissatisfied_rounded,
                              color: color,
                              onColor: Colors.white,
                              heroTag: 'result_icon',
                            ),
                            SizedBox(height: UiSpacing.xl),
                            Text(
                              isVictory ? t.victory_title : t.defeat_title,
                              style: theme.textTheme.displaySmall?.copyWith(
                                color: color,
                                fontWeight: FontWeight.bold,
                                fontSize: adaptive.headlineTextSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: UiSpacing.md),
                            AppInfoCard(
                              text: isVictory ? t.victory_desc : t.defeat_desc,
                            ),
                            SizedBox(height: adaptive.size == AdaptiveSize.compact
                                ? UiSpacing.xl
                                : UiSpacing.xxl),
                            Text(
                              t.final_stats.toUpperCase(),
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                                fontSize: adaptive.labelTextSize,
                              ),
                            ),
                            SizedBox(height: UiSpacing.md),
                            Row(
                              children: [
                                Expanded(
                                  child: ExpressiveResultStat(
                                    label: t.finIQ,
                                    value: char.finIQ.toString(),
                                    icon: Icons.psychology_outlined,
                                    color: isVictory
                                        ? Colors.purple
                                        : theme.colorScheme.onSurface,
                                  ),
                                ),
                                SizedBox(width: UiSpacing.md),
                                Expanded(
                                  child: ExpressiveResultStat(
                                    label: t.score,
                                    value: char.score.toString(),
                                    icon: Icons.star_outline,
                                    color: isVictory
                                        ? Colors.amber
                                        : theme.colorScheme.onSurface,
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
                              size: switch (adaptive.size) {
                                AdaptiveSize.compact ||
                                AdaptiveSize.medium =>
                                  ButtonSize.medium,
                                _ => ButtonSize.large,
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
