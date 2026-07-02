import 'package:flutter/material.dart';

import '../adaptive/ui_widths.dart';
import '../adaptive/ui_heights.dart';
import '../adaptive/ui_icon_sizes.dart';
import '../adaptive/ui_spacing.dart';

class ExpressiveResultStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const ExpressiveResultStat({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isCompact = width < UiWidths.compact;
        final isMedium =
            width >= UiWidths.compact && width < UiWidths.medium;
        final isExpanded =
            width >= UiWidths.medium && width < UiWidths.expanded;
        final isLarge = width >= UiWidths.expanded;

        final cardHeight = switch (true) {
          _ when isCompact => UiHeights.compact,
          _ when isMedium => UiHeights.medium,
          _ when isExpanded => UiHeights.expanded,
          _ when isLarge => UiHeights.large,
          _ => UiHeights.expanded,
        };

        final padding = switch (true) {
          _ when isCompact => UiSpacing.lg,
          _ when isMedium => UiSpacing.lg,
          _ when isExpanded => UiSpacing.xl,
          _ when isLarge => UiSpacing.xxl,
          _ => UiSpacing.xl,
        };

        final iconSize = switch (true) {
          _ when isCompact => UiIconSizes.compact,
          _ when isMedium => UiIconSizes.medium,
          _ when isExpanded => UiIconSizes.expanded,
          _ when isLarge => UiIconSizes.large,
          _ => UiIconSizes.medium,
        };

        final valueStyle = theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w900,
          color: color,
          fontSize: isCompact ? 24 : isLarge ? 36 : null,
        );

        final labelStyle = theme.textTheme.labelMedium?.copyWith(
          color: color.withAlpha(200),
          fontWeight: FontWeight.bold,
          fontSize: isCompact ? 11 : isLarge ? 14 : null,
        );

        return Container(
          height: cardHeight,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: color.withAlpha(52)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: iconSize),
              SizedBox(height: isCompact ? UiSpacing.sm : UiSpacing.md),
              Text(
                value,
                style: valueStyle,
              ),
              SizedBox(height: isCompact ? 2 : 4),
              Text(
                label,
                style: labelStyle,
              ),
            ],
          ),
        );
      },
    );
  }
}
