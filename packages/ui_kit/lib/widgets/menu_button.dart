import 'package:flutter/material.dart';

import '../adaptive/ui_widths.dart';
import '../adaptive/ui_heights.dart';
import '../adaptive/ui_icon_sizes.dart';
import '../adaptive/ui_spacing.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;

  const MenuButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
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

        final buttonHeight = switch (true) {
          _ when isCompact => UiHeights.compact,
          _ when isMedium => UiHeights.medium,
          _ when isExpanded => UiHeights.expanded,
          _ when isLarge => UiHeights.large,
          _ => UiHeights.medium,
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

        final horizontalPadding = switch (true) {
          _ when isCompact => UiSpacing.lg,
          _ when isMedium => UiSpacing.xl,
          _ when isExpanded => UiSpacing.xxl,
          _ when isLarge => UiSpacing.xxxl,
          _ => UiSpacing.xl,
        };

        final textStyle = theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: isCompact ? 16 : isLarge ? 20 : 18,
          letterSpacing: 1,
          color: foregroundColor,
        );

        return SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: iconSize),
                SizedBox(width: gap),
                Text(label, style: textStyle),
              ],
            ),
          ),
        );
      },
    );
  }
}
