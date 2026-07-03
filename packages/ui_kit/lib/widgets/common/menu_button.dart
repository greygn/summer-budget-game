import 'package:flutter/material.dart';

import '../../adaptive/adaptive_layout.dart';
import '../../adaptive/ui_spacing.dart';

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
        final layout = AdaptiveLayout.of(constraints);

        final gap = layout.value(
          compact: UiSpacing.sm,
          medium: UiSpacing.md,
          expanded: UiSpacing.lg,
          large: UiSpacing.xl,
        );

        final horizontalPadding = layout.value(
          compact: UiSpacing.lg,
          medium: UiSpacing.xl,
          expanded: UiSpacing.xxl,
          large: UiSpacing.xxxl,
        );

        final textStyle = theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: layout.isCompact ? 16 : layout.isLarge ? 20 : 18,
          letterSpacing: 1,
          color: foregroundColor,
        );

        return SizedBox(
          width: double.infinity,
          height: layout.cardHeight,
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
                Icon(icon, size: layout.iconSize),
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
