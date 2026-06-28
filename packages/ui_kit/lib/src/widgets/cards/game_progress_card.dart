import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../common/time_badge.dart';

class GameProgressCard extends StatelessWidget {
  final String modeTitle;
  final String dayText;
  final int time;
  final double progress;
  final String goalText;

  const GameProgressCard({
    super.key,
    required this.modeTitle,
    required this.dayText,
    required this.time,
    required this.progress,
    required this.goalText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final shape = theme.cardTheme.shape;
    final themeRadius = shape is RoundedRectangleBorder && shape.borderRadius is BorderRadius
        ? shape.borderRadius as BorderRadius
        : BorderRadius.circular(24);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? colorScheme.primaryContainer.withValues(alpha: 0.2),
        borderRadius: themeRadius,
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      modeTitle.toUpperCase(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      dayText,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              UITimeBadge(time: time, isLarge: true),
            ],
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              minHeight: 12,
              value: progress.clamp(0.0, 1.0),
              backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation(colorScheme.primary),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            goalText,
            style: theme.textTheme.labelLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(
  name: 'Default',
  type: GameProgressCard,
)
Widget buildGameProgressCardUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: GameProgressCard(
          modeTitle: context.knobs.string(
            label: 'Mode Title',
            initialValue: 'МАРАФОН',
          ),
          dayText: context.knobs.string(
            label: 'Day Text',
            initialValue: 'День 12 из 30',
          ),
          time: context.knobs.int.slider(
            label: 'Time',
            initialValue: 8,
            min: 0,
            max: 24,
          ),
          progress: context.knobs.double.slider(
            label: 'Progress',
            initialValue: 0.4,
            min: 0.0,
            max: 1.0,
          ),
          goalText: context.knobs.string(
            label: 'Goal Text',
            initialValue: 'Цель: 100 000 ₽',
          ),
        ),
      ),
    ),
  );
}
