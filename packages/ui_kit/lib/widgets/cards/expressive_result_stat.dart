import 'package:flutter/material.dart';

import '../../adaptive/adaptive_layout.dart';
import '../../adaptive/ui_spacing.dart';

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

        final valueStyle = theme.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w900,
          color: color,
          fontSize: layout.isCompact ? 24 : layout.isLarge ? 36 : null,
        );

        final labelStyle = theme.textTheme.labelMedium?.copyWith(
          color: color.withAlpha(200),
          fontWeight: FontWeight.bold,
          fontSize: layout.isCompact ? 11 : layout.isLarge ? 14 : null,
        );

        return Container(
          height: layout.cardHeight,
          padding: EdgeInsets.all(layout.padding),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: color.withAlpha(52)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: layout.iconSize),
              SizedBox(height: layout.isCompact ? UiSpacing.sm : UiSpacing.md),
              Text(
                value,
                style: valueStyle,
              ),
              SizedBox(height: layout.isCompact ? 2 : 4),
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
