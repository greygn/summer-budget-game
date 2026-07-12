import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/theme/app_theme.dart';
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
      ),
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.actions.isEmpty) {
             return Center(child: Text(t.no_actions_available));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.actions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final action = state.actions[index];
              final isPositive = action.moneyDelta >= 0;

              return ActionCard(
                title: action.name,
                subtitle: isPositive 
                  ? t.salary(action.moneyDelta.toString()) 
                  : t.cost((-action.moneyDelta).toString()),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (isPositive ? Colors.green : Colors.orange).withValues(alpha: AppTheme.surfaceAlpha),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getActionIcon(action),
                    color: isPositive ? Colors.green : Colors.orange,
                  ),
                ),
                tags: [
                  if (action.happinessDelta != 0)
                    _buildTag(
                      context, 
                      t.happiness_gain(action.happinessDelta.toString()), 
                      Icons.sentiment_satisfied_alt, 
                      color: Colors.orange
                    ),
                  _buildTag(context, t.time_cost(action.timeCost.toString()), Icons.access_time),
                  _buildTag(context, _getCategoryName(context, action.category.name), Icons.category_outlined),
                ],
                onTap: () {
                  context.read<GameBloc>().add(GameActionSelected(action));
                  context.router.maybePop();
                },
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

  Widget _buildTag(BuildContext context, String label, IconData icon, {Color? color}) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: AppTheme.surfaceAlpha),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: effectiveColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: effectiveColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
