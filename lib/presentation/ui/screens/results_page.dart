import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../domain/entity/game_mode.dart';
import '../../../l10n/app_localizations.dart';
import '../../../app_router.gr.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_state.dart';
import '../../bloc/leaderboard/leaderboard_bloc.dart';
import '../../bloc/leaderboard/leaderboard_event.dart';

@RoutePage()
class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

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
          final totalAssets = char.balance + char.savings;
          
          final moneyGoal = game.gameMode == GameMode.standard 
              ? 100000 // CheckStateUseCase.standardBalanceGoal
              : 1000000; // CheckStateUseCase.marathonBalanceGoal
          
          final isVictory = totalAssets >= moneyGoal && char.happiness >= 0 && char.balance >= -10000;
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
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(padding),
                        child: Column(
                          children: [
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
                            if (isVictory) ...[
                              SizedBox(height: UiSpacing.xl),
                              AppEditorField(
                                controller: _nameController,
                                label: t.enter_name,
                                icon: Icons.person_outline,
                              ),
                            ],
                            SizedBox(height: adaptive.size == AdaptiveSize.compact
                                ? UiSpacing.xl
                                : UiSpacing.xxl),
                            Text(
                              t.final_stats.toUpperCase(),
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                                fontSize: adaptive.titleTextSize,
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
                            SizedBox(height: UiSpacing.xxl),
                            if (isVictory) ...[
                              AppButton(
                                label: t.record_result,
                                onPressed: () {
                                  if (_nameController.text.isNotEmpty) {
                                    context.read<LeaderboardBloc>().add(
                                      AddLeaderboardRecord(_nameController.text),
                                    );
                                    context.router.replaceAll([const HomeRoute()]);
                                  }
                                },
                                isFullWidth: true,
                              ),
                              SizedBox(height: UiSpacing.md),
                            ],
                            AppButton(
                              label: t.back_to_menu,
                              onPressed: () {
                                context.router.replaceAll([const HomeRoute()]);
                              },
                              isFullWidth: true,
                              style: ButtonVariant.secondary,
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
