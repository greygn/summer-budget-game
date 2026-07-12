import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/adaptive/ui_icon_sizes.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../domain/entity/game_mode.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_event.dart';
import '../../bloc/game/game_state.dart';

@RoutePage()
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<GameBloc>().add(GameStarted());
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return BlocListener<GameBloc, GameState>(
      listenWhen: (previous, current) {
        final isGameOverChanged = previous.saveRecord?.gameRecord.isOver !=
            current.saveRecord?.gameRecord.isOver;
        final isEventChanged = previous.saveRecord?.gameRecord.currentEvent.ID !=
            current.saveRecord?.gameRecord.currentEvent.ID;
        return isGameOverChanged || isEventChanged;
      },
      listener: (context, state) {
        if (state.saveRecord?.gameRecord.isOver ?? false) {
          context.router.pushPath('/results');
        } else if ((state.saveRecord?.gameRecord.currentEvent.ID ?? 0) != 0) {
          context.router.pushPath('/event');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.appTitle),
        ),
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final save = state.saveRecord;
            if (save == null) {
              return const Center(child: Text('No game data found'));
            }

            final char = save.characterRecord;
            final game = save.gameRecord;

            final double goal =
                game.gameMode == GameMode.standard ? 100000 : 1000000;
            final double progress = char.savings / goal;
            final totalAssets = char.balance + char.savings;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GameProgressCard(
                    modeTitle: game.gameMode == GameMode.standard
                        ? t.sprint_mode
                        : t.marathon_mode,
                    dayText: t.day_count(game.currentDay),
                    time: game.timeLeft,
                    progress: progress,
                    goalText: t.savings_goal(goal.toInt()),
                  ),
                  const SizedBox(height: 16),
                  ExpressiveInfoTile(
                    title: t.wallet,
                    value: char.balance,
                    subtitle: t.total_assets(totalAssets.toString()),
                    icon: Icons.account_balance_wallet_rounded,
                    color: Colors.teal,
                    suffix: ' ${t.currency}',
                  ),
                  const SizedBox(height: 16),
                  ExpressiveInfoTile(
                    title: t.savings,
                    value: char.savings,
                    subtitle: t.savings_goal(goal.toInt().toString()),
                    icon: Icons.savings_rounded,
                    color: Colors.blue,
                    suffix: ' ${t.currency}',
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.3,
                    children: [
                      ExpressiveStatCard(
                        label: t.happiness,
                        value: char.happiness.toString(),
                        icon: Icons.sentiment_satisfied_alt,
                        color: Colors.orange,
                        iconSize: UiIconSizes.large,
                      ),
                      ExpressiveStatCard(
                        label: t.energy,
                        value: char.energy.toString(),
                        icon: Icons.bolt,
                        color: Colors.blue,
                        iconSize: UiIconSizes.large,
                      ),
                      ExpressiveStatCard(
                        label: t.finIQ,
                        value: char.finIQ.toString(),
                        icon: Icons.psychology_outlined,
                        color: Colors.purple,
                        iconSize: UiIconSizes.large,
                      ),
                      ExpressiveStatCard(
                        label: t.score,
                        value: char.score.toString(),
                        icon: Icons.star_outline,
                        color: Colors.amber,
                        iconSize: UiIconSizes.large,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: t.choose_job,
                          icon: Icons.work_outline,
                          style: ButtonVariant.secondary,
                          onPressed: () => context.router.pushPath('/job-chooser'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AppButton(
                          label: t.choose_action,
                          icon: Icons.local_activity_outlined,
                          style: ButtonVariant.secondary,
                          onPressed: () =>
                              context.router.pushPath('/action-chooser'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: t.next_day,
                    icon: Icons.skip_next_outlined,
                    onPressed: () =>
                        context.read<GameBloc>().add(EndDayPressed()),
                    size: ButtonSize.large,
                    isFullWidth: true,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
