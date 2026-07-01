import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../adaptive/ui_spacing.dart';
import '../common/time_badge.dart';

class GameProgressCard extends StatelessWidget {
  final String modeTitle;
  final String dayText;
  final int time;
  final double progress;
  final String goalText;
  final double? padding;
  final TextStyle? modeTitleStyle;
  final TextStyle? dayTextStyle;
  final TextStyle? goalTextStyle;
  final double? progressHeight;
  final double? timeBadgeFontSize;
  final double? timeBadgeIconSize;
  final EdgeInsetsGeometry? timeBadgePadding;

  const GameProgressCard({
    super.key,
    required this.modeTitle,
    required this.dayText,
    required this.time,
    required this.progress,
    required this.goalText,
    this.padding,
    this.modeTitleStyle,
    this.dayTextStyle,
    this.goalTextStyle,
    this.progressHeight,
    this.timeBadgeFontSize,
    this.timeBadgeIconSize,
    this.timeBadgePadding,
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
      padding: EdgeInsets.all(padding ?? UiSpacing.xl),
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
                      style: (modeTitleStyle ?? theme.textTheme.labelMedium)?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      dayText,
                      style: (dayTextStyle ?? theme.textTheme.headlineSmall)?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              UITimeBadge(
                time: time, 
                isLarge: true,
                fontSize: timeBadgeFontSize,
                iconSize: timeBadgeIconSize,
                padding: timeBadgePadding,
              ),
            ],
          ),
          const SizedBox(height: UiSpacing.xl),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              minHeight: progressHeight ?? 12,
              value: progress.clamp(0.0, 1.0),
              backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation(colorScheme.primary),
            ),
          ),
          const SizedBox(height: UiSpacing.md),
          Text(
            goalText,
            style: (goalTextStyle ?? theme.textTheme.labelLarge)?.copyWith(
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
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (padding, modeStyle, dayStyle, goalStyle, progHeight, tbFontSize, tbIconSize, tbPadding, maxWidth) = switch (size) {
    'Compact' => (
        UiSpacing.md,
        theme.textTheme.labelSmall,
        theme.textTheme.titleMedium,
        theme.textTheme.labelSmall,
        8.0,
        12.0,
        16.0,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        360.0
      ),
    'Medium' => (
        UiSpacing.lg,
        theme.textTheme.labelMedium,
        theme.textTheme.headlineSmall,
        theme.textTheme.labelLarge,
        12.0,
        16.0,
        20.0,
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        400.0
      ),
    'Expanded' => (
        UiSpacing.xl,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineMedium,
        theme.textTheme.titleSmall,
        14.0,
        18.0,
        22.0,
        const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        480.0
      ),
    'Large' => (
        UiSpacing.xl,
        theme.textTheme.titleSmall,
        theme.textTheme.headlineLarge,
        theme.textTheme.titleMedium,
        16.0,
        20.0,
        24.0,
        const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        560.0
      ),
    _ => (
        UiSpacing.lg,
        theme.textTheme.labelMedium,
        theme.textTheme.headlineSmall,
        theme.textTheme.labelLarge,
        12.0,
        16.0,
        20.0,
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        400.0
      ),
  };

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
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
          padding: padding,
          modeTitleStyle: modeStyle,
          dayTextStyle: dayStyle,
          goalTextStyle: goalStyle,
          progressHeight: progHeight,
          timeBadgeFontSize: tbFontSize,
          timeBadgeIconSize: tbIconSize,
          timeBadgePadding: tbPadding,
        ),
      ),
    ),
  );
}
