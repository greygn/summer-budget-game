import 'package:flutter/material.dart';
import 'package:ui_kit/adaptive/ui_radius.dart';

import '../../adaptive/adaptive_layout.dart';
import '../../adaptive/ui_spacing.dart';

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
        final layout = AdaptiveLayout.of(constraints);

        final horizontalPadding = layout.value(
          compact: UiSpacing.md,
          medium: UiSpacing.lg,
          expanded: UiSpacing.xl,
          large: UiSpacing.xxl,
        );

        final verticalPadding = layout.value(
          compact: UiSpacing.md,
          medium: UiSpacing.lg,
          expanded: UiSpacing.lg,
          large: UiSpacing.xl,
        );

        final iconContainerPadding = layout.value(
          compact: UiSpacing.sm,
          medium: UiSpacing.md,
          expanded: UiSpacing.lg,
          large: UiSpacing.lg,
        );

        final gap = layout.value(
          compact: UiSpacing.sm,
          medium: UiSpacing.md,
          expanded: UiSpacing.lg,
          large: UiSpacing.xl,
        );

        final titleStyle = theme.textTheme.titleMedium?.copyWith(
          fontSize: layout.titleTextSize,
          color: color,
        );

        final bodyTextStyle = theme.textTheme.bodySmall?.copyWith(
          color: color.withAlpha(153),
          fontSize: layout.bodyTextSize,
        );

        return Material(
          color: color.withAlpha(26),
          borderRadius: BorderRadius.circular(UiRadius.extraLargeIncr),
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
                      borderRadius: BorderRadius.circular(UiRadius.largeIncreased),
                    ),
                    child: Icon(icon, color: Colors.white, size: layout.iconSize),
                  ),
                  SizedBox(width: gap),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: titleStyle),
                        Text(subtitle, style: bodyTextStyle),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: color,
                    size: layout.iconSize,
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
