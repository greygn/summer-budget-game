import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../l10n/app_localizations.dart';
import '../../bloc/leaderboard/leaderboard_bloc.dart';
import '../../bloc/leaderboard/leaderboard_event.dart';
import '../../bloc/leaderboard/leaderboard_state.dart';

@RoutePage()
class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  void initState() {
    super.initState();
    context.read<LeaderboardBloc>().add(LeaderboardOpened());
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.leaderboard),
      ),
      body: BlocBuilder<LeaderboardBloc, LeaderboardState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.failure != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Error: ${state.failure}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ),
            );
          }

          if (state.records.isEmpty) {
            return Center(
              child: Text(
                'No records yet',
                style: theme.textTheme.titleMedium,
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.records.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final record = state.records[index];
              return ExpressiveInfoTile(
                title: record.name.isEmpty ? 'Player' : record.name,
                value: record.score,
                subtitle: '${t.finIQ}: ${record.finIQ} | ${record.time}',
                icon: Icons.emoji_events,
                color: _getRankColor(index, theme),
              );
            },
          );
        },
      ),
    );
  }

  Color _getRankColor(int index, ThemeData theme) {
    switch (index) {
      case 0:
        return const Color(0xFFFFD700);
      case 1:
        return const Color(0xFFC0C0C0);
      case 2:
        return const Color(0xFFCD7F32);
      default:
        return theme.colorScheme.outline;
    }
  }
}
