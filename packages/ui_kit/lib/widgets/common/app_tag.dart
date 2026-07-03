import 'package:flutter/material.dart';
import 'package:ui_kit/adaptive/ui_radius.dart';
import 'package:ui_kit/adaptive/ui_spacing.dart';

import '../../adaptive/adaptive_layout.dart';

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
        final layout = AdaptiveLayout.of(constraints);

        final horizontalPadding = layout.value(
          compact: UiSpacing.sm,
          medium: UiSpacing.md,
          expanded: UiSpacing.lg,
          large: UiSpacing.xl,
        );

        final verticalPadding = layout.value(
          compact: UiSpacing.xs,
          medium: UiSpacing.sm,
          expanded: UiSpacing.sm,
          large: UiSpacing.md,
        );

        final gap = layout.value(
          compact: UiSpacing.xs,
          medium: UiSpacing.sm,
          expanded: UiSpacing.sm,
          large: UiSpacing.md,
        );

        final labelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: foreground,
          fontSize: layout.labelTextSize,
        );

        Widget content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: layout.iconSize,
                color: foreground,
              ),
              SizedBox(width: gap),
            ],
            Text(label, style: labelStyle),
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
            borderRadius: BorderRadius.circular(UiRadius.medium),
            onTap: onTap,
            child: content,
          );
        }

        return Material(
          color: background,
          borderRadius: BorderRadius.circular(UiRadius.medium),
          child: content,
        );
      },
    );
  }
}
