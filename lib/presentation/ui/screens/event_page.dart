import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_event.dart';
import '../../bloc/game/game_state.dart';
import '../utils/entity_localization.dart';

@RoutePage()
class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return BlocListener<GameBloc, GameState>(
      listenWhen: (previous, current) =>
          previous.saveRecord?.gameRecord.isOver !=
          current.saveRecord?.gameRecord.isOver,
      listener: (context, state) {
        if (state.saveRecord?.gameRecord.isOver ?? false) {
          context.router.pushPath('/results');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(t.event_title),
          automaticallyImplyLeading: false,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final adaptive = AdaptiveLayout.of(constraints);

            return BlocBuilder<GameBloc, GameState>(
              builder: (context, state) {
                final event = state.saveRecord?.gameRecord.currentEvent;
                if (event == null || event.ID == 0) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: UiWidths.compact),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(adaptive.padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppHeroIcon(
                            icon: state.isEventBad
                                ? Icons.warning_rounded
                                : Icons.auto_awesome_rounded,
                            color: state.isEventBad
                                ? theme.colorScheme.error
                                : theme.colorScheme.primary,
                            onColor: state.isEventBad
                                ? theme.colorScheme.onError
                                : theme.colorScheme.onPrimary,
                            heroTag: 'event_icon',
                          ),
                          SizedBox(height: UiSpacing.xl),
                          Text(
                            event.getTitle(context),
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                              fontSize: adaptive.headlineTextSize,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: UiSpacing.lg),
                          AppInfoCard(
                            text: event.getDescription(context),
                          ),
                          const SizedBox(height: UiSpacing.lg),
                          Wrap(
                            spacing: UiSpacing.sm,
                            runSpacing: UiSpacing.sm,
                            alignment: WrapAlignment.center,
                            children: [
                              if (event.moneyDelta != 0)
                                _buildTag(
                                  context,
                                  adaptive,
                                  '${event.moneyDelta > 0 ? '+' : ''}${event.moneyDelta} ₽',
                                  Icons.payments_outlined,
                                  color: event.moneyDelta > 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              if (event.happinessDelta != 0)
                                _buildTag(
                                  context,
                                  adaptive,
                                  '${event.happinessDelta > 0 ? '+' : ''}${event.happinessDelta}',
                                  Icons.sentiment_satisfied_alt,
                                  color: event.happinessDelta > 0
                                      ? Colors.orange
                                      : Colors.blueGrey,
                                ),
                              if (event.finIQDelta != 0)
                                _buildTag(
                                  context,
                                  adaptive,
                                  'IQ ${event.finIQDelta > 0 ? '+' : ''}${event.finIQDelta}',
                                  Icons.psychology_outlined,
                                  color: Colors.purple,
                                ),
                              if (event.energyDelta != 0)
                                _buildTag(
                                  context,
                                  adaptive,
                                  '${event.energyDelta > 0 ? '+' : ''}${event.energyDelta}',
                                  Icons.bolt,
                                  color: Colors.blue,
                                ),
                            ],
                          ),
                          SizedBox(height: UiSpacing.xxl),
                          if (event.options.isEmpty)
                            AppButton(
                              label: t.accept,
                              onPressed: () => context.router.maybePop(),
                              isFullWidth: true,
                              size: (adaptive.isCompact || adaptive.isMedium)
                                  ? ButtonSize.medium
                                  : ButtonSize.large,
                            )
                          else
                            ...event.options.asMap().entries.map((entry) {
                              final index = entry.key;
                              final option = entry.value;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: UiSpacing.md),
                                child: AppButton(
                                  label: option.getLocalizedDescription(context, event.ID, index),
                                  onPressed: () {
                                    context
                                        .read<GameBloc>()
                                        .add(GameEventOptionSelected(option));
                                    context.router.maybePop();
                                  },
                                  isFullWidth: true,
                                  style: ButtonVariant.secondary,
                                  size: (adaptive.isCompact || adaptive.isMedium)
                                      ? ButtonSize.medium
                                      : ButtonSize.large,
                                ),
                              );
                            }),
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
