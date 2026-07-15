import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../domain/entity/game_action_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_event.dart';
import '../../bloc/game/game_state.dart';
import '../utils/entity_localization.dart';

@RoutePage()
class ActionChooserPage extends StatelessWidget {
  const ActionChooserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.choose_action),
        actions: [
          BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              final timeLeft = state.saveRecord?.gameRecord.timeLeft ?? 0;
              return Padding(
                padding: const EdgeInsets.only(right: UiSpacing.md),
                child: UITimeBadge(time: timeLeft, isLarge: false,),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final adaptive = AdaptiveLayout.of(constraints);

          return BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.groupedActions.isEmpty) {
                return Center(child: Text(t.no_actions_available));
              }

              final categories = state.groupedActions.keys.toList()..sort((a, b) {
                if (a == 5) return -1;
                if (b == 5) return 1;
                return a.compareTo(b);
              });

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: UiWidths.medium),
                  child: ListView.builder(
                    padding: EdgeInsets.all(adaptive.padding),
                    itemCount: categories.length,
                    itemBuilder: (context, catIndex) {
                      final categoryId = categories[catIndex];
                      final actions = state.groupedActions[categoryId]!;
                      final firstAction = actions.first;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: UiSpacing.md),
                            child: Text(
                              firstAction.category.getName(context),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                          ...actions.map((action) {
                            final timeLeft = state.saveRecord?.gameRecord.timeLeft ?? 0;
                            final char = state.saveRecord?.characterRecord;
                            final job = char?.job;

                            final stats = action.getDisplayStats(job);
                            String actionName = action.getName(context);
                            if (action.isJobAction && job != null) {
                              actionName = "$actionName (${job.getName(context)})";
                            }

                            final hasEnoughMoney = (char?.balance ?? 0) + stats.money >= 0;
                            final hasEnoughSavings = (char?.savings ?? 0) + action.savingsDelta >= 0;
                            final canAfford = timeLeft >= stats.time && hasEnoughMoney && hasEnoughSavings;
                            final isPositive = stats.money >= 0;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: UiSpacing.md),
                              child: Opacity(
                                opacity: canAfford ? 1.0 : 0.5,
                                child: ActionCard(
                                  title: actionName,
                                  leading: Container(
                                    padding: const EdgeInsets.all(UiSpacing.sm),
                                    decoration: BoxDecoration(
                                      color: (isPositive ? Colors.green : Colors.orange)
                                          .withValues(alpha: AppTheme.surfaceAlpha),
                                      borderRadius: BorderRadius.circular(UiRadius.medium),
                                    ),
                                    child: Icon(
                                      _getActionIcon(action),
                                      color: isPositive ? Colors.green : Colors.orange,
                                      size: adaptive.iconSize,
                                    ),
                                  ),
                                  tags: [
                                    if (stats.money != 0)
                                      _buildTag(
                                        context,
                                        adaptive,
                                        '${stats.money > 0 ? '+' : ''}${stats.money}',
                                        Icons.payments_outlined,
                                        color: isPositive ? Colors.green : (hasEnoughMoney ? Colors.red : Colors.grey),
                                      ),
                                    if (action.savingsDelta != 0)
                                      _buildTag(
                                        context,
                                        adaptive,
                                        '${action.savingsDelta > 0 ? '+' : ''}${action.savingsDelta}',
                                        Icons.savings_outlined,
                                        color: action.savingsDelta > 0 ? Colors.teal : (hasEnoughSavings ? Colors.red : Colors.grey),
                                      ),
                                    if (stats.happiness != 0)
                                      _buildTag(
                                        context,
                                        adaptive,
                                        '${stats.happiness > 0 ? '+' : ''}${stats.happiness}',
                                        Icons.sentiment_satisfied_alt,
                                        color: Colors.orange,
                                      ),
                                    if (stats.energy != 0)
                                      _buildTag(
                                        context,
                                        adaptive,
                                        '${stats.energy > 0 ? '+' : ''}${stats.energy}',
                                        Icons.bolt,
                                        color: Colors.blue,
                                      ),
                                    if (action.finIQDelta != 0)
                                      _buildTag(
                                        context,
                                        adaptive,
                                        '+${action.finIQDelta}',
                                        Icons.psychology,
                                        color: Colors.purple,
                                      ),
                                    _buildTag(
                                      context,
                                      adaptive,
                                      t.time_cost(stats.time.toString()),
                                      Icons.access_time,
                                      color: canAfford ? null : Colors.red,
                                    ),
                                    _buildTag(
                                      context,
                                      adaptive,
                                      action.category.getName(context),
                                      Icons.category_outlined,
                                    ),
                                  ],
                                  onTap: canAfford
                                      ? () {
                                          context.read<GameBloc>().add(GameActionSelected(action));
                                          context.router.maybePop();
                                        }
                                      : null,
                                ),
                              ),
                            );
                          }),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  IconData _getActionIcon(GameActionEntity action) {
    final categoryId = action.category.ID;
    if (categoryId == 1) return Icons.restaurant_rounded;
    if (categoryId == 2) return Icons.fitness_center_rounded;
    if (categoryId == 5 || action.isJobAction) return Icons.work_history_rounded;
    if (categoryId == 7) return Icons.account_balance_rounded;
    if (categoryId == 3) return Icons.movie_creation_outlined;
    if (categoryId == 4) return Icons.school_rounded;
    if (categoryId == 6) return Icons.style_rounded;
    
    return Icons.star_border_rounded;
  }

  Widget _buildTag(BuildContext context, AdaptiveLayout adaptive, String label, IconData icon, {Color? color}) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: UiSpacing.sm, vertical: UiSpacing.xs),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: AppTheme.surfaceAlpha),
        borderRadius: BorderRadius.circular(UiRadius.small),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: effectiveColor),
          const SizedBox(width: UiSpacing.xs),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: effectiveColor,
              fontWeight: FontWeight.bold,
              fontSize: adaptive.labelTextSize,
            ),
          ),
        ],
      ),
    );
  }
}
