import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_event.dart';
import '../../bloc/game/game_state.dart';

@RoutePage()
class JobChooserPage extends StatelessWidget {
  const JobChooserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.choose_job),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final adaptive = AdaptiveLayout.of(constraints);

          return BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: UiWidths.medium),
                  child: ListView.separated(
                    padding: EdgeInsets.all(adaptive.padding),
                    itemCount: state.jobs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: UiSpacing.md),
                    itemBuilder: (context, index) {
                      final job = state.jobs[index];
                      return ActionCard(
                        title: job.name,
                        leading: Container(
                          padding: const EdgeInsets.all(UiSpacing.sm),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary.withValues(alpha: AppTheme.surfaceAlpha),
                            borderRadius: BorderRadius.circular(UiRadius.medium),
                          ),
                          child: Icon(
                            Icons.work_rounded,
                            color: Theme.of(context).colorScheme.primary,
                            size: adaptive.iconSize,
                          ),
                        ),
                        tags: [
                          _buildTag(
                            context,
                            adaptive,
                            '${job.salary}',
                            Icons.currency_ruble,
                            color: Colors.green,
                          ),
                          _buildTag(
                            context,
                            adaptive,
                            t.time_cost(job.timeCost.toString()),
                            Icons.access_time,
                          ),
                          _buildTag(
                            context,
                            adaptive,
                            t.energy_cost(job.energyCost.toString()),
                            Icons.bolt,
                            color: Colors.blue,
                          ),
                          if (job.minFinIQ > 0)
                            _buildTag(
                              context,
                              adaptive,
                              'IQ: ${job.minFinIQ}',
                              Icons.psychology,
                              color: Colors.purple,
                            ),
                        ],
                        onTap: () {
                          context.read<GameBloc>().add(JobSelected(job));
                          context.router.maybePop();
                        },
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
