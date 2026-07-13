import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../domain/entity/game_action_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_event.dart';
import '../../bloc/game/game_state.dart';

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

              if (state.actions.isEmpty) {
                return Center(child: Text(t.no_actions_available));
              }

              final groupedActions = <String, List<GameActionEntity>>{};
              for (final action in state.actions) {
                final category = action.category.name;
                groupedActions.putIfAbsent(category, () => []).add(action);
              }

              final categories = groupedActions.keys.toList();

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: UiWidths.medium),
                  child: ListView.builder(
                    padding: EdgeInsets.all(adaptive.padding),
                    itemCount: categories.length,
                    itemBuilder: (context, catIndex) {
                      final categoryKey = categories[catIndex];
                      final actions = groupedActions[categoryKey]!;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: UiSpacing.md),
                            child: Text(
                              _getCategoryName(context, categoryKey),
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                          ...actions.map((action) {
                            final timeLeft = state.saveRecord?.gameRecord.timeLeft ?? 0;
                            final canAfford = timeLeft >= action.timeCost;
                            final isPositive = action.moneyDelta >= 0;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: UiSpacing.md),
                              child: Opacity(
                                opacity: canAfford ? 1.0 : 0.5,
                                child: ActionCard(
                                  title: action.name,
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
                                    _buildTag(
                                      context,
                                      adaptive,
                                      '${action.moneyDelta > 0 ? '+' : ''}${action.moneyDelta}',
                                      Icons.payments_outlined,
                                      color: Colors.red,
                                    ),
                                    if (action.happinessDelta != 0)
                                      _buildTag(
                                        context,
                                        adaptive,
                                        '${action.happinessDelta > 0 ? '+' : ''}${action.happinessDelta}',
                                        Icons.sentiment_satisfied_alt,
                                        color: Colors.orange,
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
                                      t.time_cost(action.timeCost.toString()),
                                      Icons.access_time,
                                      color: canAfford ? null : Colors.red,
                                    ),
                                    _buildTag(
                                      context,
                                      adaptive,
                                      _getCategoryName(context, action.category.name),
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

  String _getCategoryName(BuildContext context, String categoryKey) {
    final t = AppLocalizations.of(context)!;
    return switch (categoryKey.toLowerCase()) {
      'leisure' => t.action_category_leisure,
      'food' => t.action_category_food,
      'health' => t.action_category_health,
      _ => categoryKey,
    };
  }

  IconData _getActionIcon(GameActionEntity action) {
    final category = action.category.name.toLowerCase();
    if (category == 'food') return Icons.restaurant_rounded;
    if (category == 'health') return Icons.fitness_center_rounded;
    
    // Fallback to simple keyword check if category is not enough
    final name = action.name.toLowerCase();
    if (name.contains('кофе') || name.contains('coffee')) return Icons.coffee_rounded;
    if (name.contains('кино') || name.contains('movie')) return Icons.movie_creation_outlined;
    
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
