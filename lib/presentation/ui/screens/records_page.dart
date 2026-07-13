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
          return LayoutBuilder(
            builder: (context, constraints) {
              final adaptive = AdaptiveLayout.of(constraints);
              final padding = adaptive.padding;

              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.failure != null) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Text(
                      'Error: ${state.failure}',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                        fontSize: adaptive.bodyTextSize,
                      ),
                    ),
                  ),
                );
              }

              if (state.records.isEmpty) {
                return Center(
                  child: Text(
                    'No records yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: adaptive.titleTextSize,
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(padding),
                itemCount: state.records.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: padding * 0.75),
                itemBuilder: (context, index) {
                  final record = state.records[index];

                  final Color rankColor;
                  final IconData rankIcon;

                  if (index == 0) {
                    rankColor = const Color(0xFFFFD700);
                    rankIcon = Icons.emoji_events;
                  } else if (index == 1) {
                    rankColor = const Color(0xFFC0C0C0);
                    rankIcon = Icons.emoji_events;
                  } else if (index == 2) {
                    rankColor = const Color(0xFFCD7F32);
                    rankIcon = Icons.emoji_events;
                  } else {
                    rankColor = theme.colorScheme.outline;
                    rankIcon = Icons.military_tech;
                  }

                  return ExpressiveInfoTile(
                    title: record.name.isEmpty ? 'Player' : record.name,
                    value: record.score,
                    subtitle: '${t.finIQ}: ${record.finIQ} | ${record.time}',
                    icon: rankIcon,
                    color: rankColor,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
