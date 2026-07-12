import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/theme/app_theme.dart';
import '../../../domain/entity/job_entity.dart';
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
      body: BlocBuilder<GameBloc, GameState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.jobs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final job = state.jobs[index];
              return ActionCard(
                title: job.name,
                subtitle: t.salary(job.salary.toString()),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: AppTheme.surfaceAlpha),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.work_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                tags: [
                  _buildTag(context, t.time_cost(job.timeCost.toString()), Icons.access_time),
                  _buildTag(context, t.energy_cost(job.energyCost.toString()), Icons.bolt, color: Colors.blue),
                  if (job.minFinIQ > 0)
                    _buildTag(context, 'IQ: ${job.minFinIQ}', Icons.psychology, color: Colors.purple),
                ],
                onTap: () {
                  context.read<GameBloc>().add(JobSelected(job));
                  context.router.maybePop();
                },
              );
            },
          );
        },
      ),
    );
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
