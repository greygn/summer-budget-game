import 'package:flutter/material.dart';
import '../../adaptive/ui_radius.dart';
import '../../adaptive/ui_spacing.dart';
import '../../theme/app_theme.dart';
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
        : BorderRadius.circular(UiRadius.largeIncreased);

    return Container(
      padding: EdgeInsets.all(padding ?? UiSpacing.xl),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? colorScheme.primaryContainer.withValues(alpha: AppTheme.strokeAlpha),
        borderRadius: themeRadius,
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: AppTheme.surfaceAlpha),
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
            borderRadius: BorderRadius.circular(UiRadius.extraLargeIncr),
            child: LinearProgressIndicator(
              minHeight: progressHeight ?? UiSpacing.md,
              value: progress.clamp(0.0, 1.0),
              backgroundColor: colorScheme.primary.withValues(alpha: AppTheme.surfaceAlpha),
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
