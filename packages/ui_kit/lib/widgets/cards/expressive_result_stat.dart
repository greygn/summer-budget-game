import 'package:flutter/material.dart';
import 'package:ui_kit/adaptive/ui_radius.dart';

import '../../adaptive/adaptive_layout.dart';
import '../../adaptive/ui_spacing.dart';
import '../../theme/app_theme.dart';

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

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = AdaptiveLayout.of(constraints);

        final headlineStyle = theme.textTheme.headlineMedium?.copyWith(
          color: color,
          fontSize: layout.headlineTextSize,
        );

        final labelStyle = theme.textTheme.labelMedium?.copyWith(
          color: color.withValues(alpha: AppTheme.emphasisAlpha),
          fontSize: layout.labelTextSize,
        );

        return Container(
          height: layout.cardHeight,
          padding: EdgeInsets.all(layout.padding),
          decoration: BoxDecoration(
            color: color.withValues(alpha: AppTheme.surfaceAlpha),
            borderRadius: BorderRadius.circular(UiRadius.extraLarge),
            border: Border.all(color: color.withValues(alpha: AppTheme.strokeAlpha)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: layout.iconSize),
              SizedBox(height: layout.isCompact ? UiSpacing.sm : UiSpacing.md),
              Text(
                value,
                style: headlineStyle,
              ),
              SizedBox(height: layout.isCompact ? UiSpacing.xs : UiSpacing.sm),
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
