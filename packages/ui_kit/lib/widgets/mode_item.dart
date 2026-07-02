import 'package:flutter/material.dart';

import '../adaptive/ui_widths.dart';
import '../adaptive/ui_icon_sizes.dart';
import '../adaptive/ui_spacing.dart';

class ModeItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const ModeItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isCompact = width < UiWidths.compact;
        final isMedium =
            width >= UiWidths.compact && width < UiWidths.medium;
        final isExpanded =
            width >= UiWidths.medium && width < UiWidths.expanded;
        final isLarge = width >= UiWidths.expanded;

        final horizontalPadding = switch (true) {
          _ when isCompact => UiSpacing.lg,
          _ when isMedium => UiSpacing.xl,
          _ when isExpanded => UiSpacing.xxl,
          _ when isLarge => UiSpacing.xxxl,
          _ => UiSpacing.xl,
        };

        final verticalPadding = switch (true) {
          _ when isCompact => UiSpacing.md,
          _ when isMedium => UiSpacing.lg,
          _ when isExpanded => UiSpacing.lg,
          _ when isLarge => UiSpacing.xl,
          _ => UiSpacing.lg,
        };

        final iconContainerPadding = switch (true) {
          _ when isCompact => UiSpacing.sm,
          _ when isMedium => UiSpacing.md,
          _ when isExpanded => UiSpacing.lg,
          _ when isLarge => UiSpacing.lg,
          _ => UiSpacing.md,
        };

        final iconSize = switch (true) {
          _ when isCompact => UiIconSizes.compact,
          _ when isMedium => UiIconSizes.medium,
          _ when isExpanded => UiIconSizes.expanded,
          _ when isLarge => UiIconSizes.large,
          _ => UiIconSizes.medium,
        };

        final gap = switch (true) {
          _ when isCompact => UiSpacing.sm,
          _ when isMedium => UiSpacing.md,
          _ when isExpanded => UiSpacing.lg,
          _ when isLarge => UiSpacing.xl,
          _ => UiSpacing.md,
        };

        final titleStyle = theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: isCompact ? 16 : isLarge ? 22 : 20,
          color: color,
        );

        final subtitleStyle = theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: color.withAlpha(153),
          fontSize: isCompact ? 11.5 : isLarge ? 14 : null,
        );

        final chevronSize = switch (true) {
          _ when isCompact => 20.0,
          _ when isMedium => 22.0,
          _ when isExpanded => 24.0,
          _ when isLarge => 26.0,
          _ => 22.0,
        };

        return Material(
          color: color.withAlpha(26),
          borderRadius: BorderRadius.circular(32),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(iconContainerPadding),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(icon, color: Colors.white, size: iconSize),
                  ),
                  SizedBox(width: gap),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: titleStyle),
                        Text(subtitle, style: subtitleStyle),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: color,
                    size: chevronSize,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
