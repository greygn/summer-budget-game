import 'package:flutter/material.dart';
import 'package:ui_kit/adaptive/ui_spacing.dart';

import '../../adaptive/ui_widths.dart';
import '../../adaptive/ui_icon_sizes.dart';

class AppTag extends StatelessWidget {
  const AppTag({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.backgroundColor,
    this.onTap,
  });

  final String label;
  final IconData? icon;

  final Color? color;
  final Color? backgroundColor;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final foreground = color ?? colorScheme.primary;

    final background =
        backgroundColor ?? foreground.withAlpha(35);

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isCompact = width < UiWidths.compact;
        final isMedium = width >= UiWidths.compact
            && width < UiWidths.medium;
        final isExpanded = width >= UiWidths.medium
            && width < UiWidths.expanded;
        final isLarge = width >= UiWidths.expanded
            && width < UiWidths.large;

        final horizontalPadding = switch (true) {
          _ when isCompact => UiSpacing.sm,
          _ when isMedium => UiSpacing.md,
          _ when isExpanded => UiSpacing.lg,
          _ when isLarge => UiSpacing.xl,
          _ => UiSpacing.md,
        };

        final verticalPadding = switch (true) {
          _ when isCompact => UiSpacing.xs,
          _ when isMedium => UiSpacing.sm,
          _ when isExpanded => UiSpacing.sm,
          _ when isLarge => UiSpacing.md,
          _ => UiSpacing.sm,
        };

        final iconSize = switch (true) {
          _ when isCompact => UiIconSizes.compact,
          _ when isMedium => UiIconSizes.medium,
          _ when isExpanded => UiIconSizes.expanded,
          _ when isLarge => UiIconSizes.large,
          _ => UiIconSizes.medium,
        };

        final gap = switch (true) {
          _ when isCompact => UiSpacing.xs,
          _ when isMedium => UiSpacing.sm,
          _ when isExpanded => UiSpacing.sm,
          _ when isLarge => UiSpacing.md,
          _ => UiSpacing.sm,
        };

        final textStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w700,
          fontSize: isCompact ? 11.5 : isLarge ? 14 : null,
        );

        Widget content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: iconSize,
                color: foreground,
              ),
              SizedBox(width: gap),
            ],
            Text(label, style: textStyle),
          ],
        );

        content = Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: content,
        );

        if (onTap != null) {
          content = InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: content,
          );
        }

        return Material(
          color: background,
          borderRadius: BorderRadius.circular(14),
          child: content,
        );
      },
    );
  }
}
