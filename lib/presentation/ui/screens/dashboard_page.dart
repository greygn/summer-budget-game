import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../domain/entity/game_mode.dart';
import '../../../domain/use_case/check_state_use_case.dart';
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
        appBar: AppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final adaptive = AdaptiveLayout.of(constraints);
            final padding = adaptive.padding;

            return BlocBuilder<GameBloc, GameState>(
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

                final double goal = state.goal;
                final double progress = state.progress;
                final totalAssets = char.balance + char.savings;

                final crossAxisCount = adaptive.statGridColumns;
                final gridWidth = (constraints.maxWidth > UiWidths.expanded 
                    ? UiWidths.expanded 
                    : constraints.maxWidth) - (padding * 2);
                final itemWidth = (gridWidth - (UiSpacing.md * (crossAxisCount - 1))) / crossAxisCount;
                final childAspectRatio = itemWidth / adaptive.cardHeight;

                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: UiWidths.expanded),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(padding),
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
                            timeBadgeFontSize: adaptive.titleTextSize,
                            timeBadgeIconSize: adaptive.iconSize,
                          ),
                          SizedBox(height: UiSpacing.lg),
                          _AdaptiveInfoTiles(
                            adaptive: adaptive,
                            t: t,
                            balance: char.balance,
                            savings: char.savings,
                            totalAssets: totalAssets,
                            moneyGoal: game.gameMode == GameMode.standard
                                ? CheckStateUseCase.standardBalanceGoal.toDouble()
                                : CheckStateUseCase.marathonBalanceGoal.toDouble(),
                          ),
                          SizedBox(height: UiSpacing.lg),
                          GridView.count(
                            crossAxisCount: crossAxisCount,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: UiSpacing.md,
                            crossAxisSpacing: UiSpacing.md,
                            childAspectRatio: childAspectRatio,
                            children: [
                              ExpressiveStatCard(
                                label: t.happiness,
                                value: char.happiness.toString(),
                                icon: Icons.sentiment_satisfied_alt,
                                color: Colors.orange,
                                iconSize: adaptive.iconSize,
                                height: double.infinity,
                                valueStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: adaptive.headlineTextSize,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              ExpressiveStatCard(
                                label: t.energy,
                                value: char.energy.toString(),
                                icon: Icons.bolt,
                                color: Colors.blue,
                                iconSize: adaptive.iconSize,
                                height: double.infinity,
                                valueStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: adaptive.headlineTextSize,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              ExpressiveStatCard(
                                label: t.finIQ,
                                value: char.finIQ.toString(),
                                icon: Icons.psychology_outlined,
                                color: Colors.purple,
                                iconSize: adaptive.iconSize,
                                height: double.infinity,
                                valueStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: adaptive.headlineTextSize,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                              ExpressiveStatCard(
                                label: t.score,
                                value: char.score.toString(),
                                icon: Icons.star_outline,
                                color: Colors.amber,
                                iconSize: adaptive.iconSize,
                                height: double.infinity,
                                valueStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontSize: adaptive.headlineTextSize,
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: UiSpacing.md),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  label: t.choose_job,
                                  icon: Icons.work_outline,
                                  style: ButtonVariant.secondary,
                                  size: ButtonSize.large,
                                  onPressed: () =>
                                      context.router.pushPath('/job-chooser'),
                                ),
                              ),
                              SizedBox(width: UiSpacing.sm),
                              Expanded(
                                child: AppButton(
                                  label: t.choose_action,
                                  icon: Icons.local_activity_outlined,
                                  style: ButtonVariant.secondary,
                                  size: ButtonSize.large,
                                  onPressed: () =>
                                      context.router.pushPath('/action-chooser'),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: UiSpacing.lg),
                          _BouncingButton(
                            child: AppButton(
                              label: t.next_day,
                              icon: Icons.skip_next_outlined,
                              onPressed: () =>
                                  context.read<GameBloc>().add(EndDayPressed()),
                              size: ButtonSize.medium,
                              isFullWidth: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _BouncingButton extends StatefulWidget {
  final Widget child;
  const _BouncingButton({required this.child});

  @override
  State<_BouncingButton> createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<_BouncingButton> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) => setState(() => _scale = 0.96);
  void _onTapUp(TapUpDetails details) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.translucent,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}

class _AdaptiveInfoTiles extends StatelessWidget {
  final AdaptiveLayout adaptive;
  final AppLocalizations t;
  final int balance;
  final int savings;
  final int totalAssets;
  final double moneyGoal;

  const _AdaptiveInfoTiles({
    required this.adaptive,
    required this.t,
    required this.balance,
    required this.savings,
    required this.totalAssets,
    required this.moneyGoal,
  });

  @override
  Widget build(BuildContext context) {
    final isStackMode = adaptive.isCompact;

    final children = [
      Expanded(
        flex: isStackMode ? 0 : 1,
        child: ExpressiveInfoTile(
          title: t.wallet,
          value: balance,
          subtitle: t.total_assets(totalAssets.toString()),
          icon: Icons.account_balance_wallet_rounded,
          color: Colors.teal,
        ),
      ),
      if (isStackMode)
        SizedBox(height: UiSpacing.lg)
      else
        SizedBox(width: UiSpacing.lg),
      Expanded(
        flex: isStackMode ? 0 : 1,
        child: ExpressiveInfoTile(
          title: t.savings,
          value: savings,
          subtitle: t.savings_goal(moneyGoal.toInt().toString()),
          icon: Icons.savings_rounded,
          color: Colors.blue,
        ),
      ),
    ];

    if (isStackMode) {
      return Column(
        children: children
            .map((e) => e is Expanded ? e.child : e)
            .toList(),
      );
    }

    return Row(children: children);
  }
}
