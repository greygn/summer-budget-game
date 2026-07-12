import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui_kit.dart';
import '../../../domain/entity/game_event_entity.dart';
import '../../../l10n/app_localizations.dart';
import '../../bloc/game/game_bloc.dart';
import '../../bloc/game/game_event.dart';
import '../../bloc/game/game_state.dart';

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
        body: BlocBuilder<GameBloc, GameState>(
          builder: (context, state) {
            final event = state.saveRecord?.gameRecord.currentEvent;
            if (event == null || event.ID == 0) {
              return const Center(child: CircularProgressIndicator());
            }

            final isBad = _isEventBad(event);

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Spacer(),
                    AppHeroIcon(
                      icon: isBad
                          ? Icons.warning_rounded
                          : Icons.auto_awesome_rounded,
                      color: isBad
                          ? theme.colorScheme.error
                          : theme.colorScheme.primary,
                      onColor: isBad
                          ? theme.colorScheme.onError
                          : theme.colorScheme.onPrimary,
                      heroTag: 'event_icon',
                    ),
                    const SizedBox(height: 32),
                    Text(
                      event.title,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    AppInfoCard(
                      text: event.description,
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        if (event.moneyDelta != 0)
                          AppTag(
                            label:
                                '${event.moneyDelta > 0 ? '+' : ''}${event.moneyDelta} ${t.currency}',
                            icon: Icons.payments_outlined,
                            color:
                                event.moneyDelta > 0 ? Colors.green : Colors.red,
                          ),
                        if (event.happinessDelta != 0)
                          AppTag(
                            label:
                                '${event.happinessDelta > 0 ? '+' : ''}${event.happinessDelta}',
                            icon: Icons.sentiment_satisfied_alt,
                            color: event.happinessDelta > 0
                                ? Colors.orange
                                : Colors.blueGrey,
                          ),
                        if (event.finIQDelta != 0)
                          AppTag(
                            label:
                                'IQ ${event.finIQDelta > 0 ? '+' : ''}${event.finIQDelta}',
                            icon: Icons.psychology_outlined,
                            color: Colors.purple,
                          ),
                      ],
                    ),
                    const Spacer(),
                    if (event.options.isEmpty)
                      AppButton(
                        label: t.accept,
                        onPressed: () => context.router.maybePop(),
                        isFullWidth: true,
                        size: ButtonSize.large,
                      )
                    else
                      ...event.options.map((option) => Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: AppButton(
                              label: option.description,
                              onPressed: () {
                                context
                                    .read<GameBloc>()
                                    .add(GameEventOptionSelected(option));
                                context.router.maybePop();
                              },
                              isFullWidth: true,
                              style: ButtonVariant.secondary,
                            ),
                          )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _isEventBad(GameEventEntity event) {
    return event.moneyDelta < 0 ||
        event.happinessDelta < 0 ||
        event.finIQDelta < 0 ||
        event.pointsDelta < 0;
  }
}
