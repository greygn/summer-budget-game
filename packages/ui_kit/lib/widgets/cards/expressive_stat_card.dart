import 'package:flutter/material.dart';
import 'package:ui_kit/adaptive/ui_radius.dart';
import '../../adaptive/adaptive_layout.dart';
import '../../adaptive/ui_spacing.dart';
import '../../theme/app_theme.dart';

class ExpressiveStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final double? height;
  final double? iconSize;
  final double? padding;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const ExpressiveStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.height,
    this.iconSize,
    this.padding,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final shape = theme.cardTheme.shape;
    final themeRadius = shape is RoundedRectangleBorder && shape.borderRadius is BorderRadius
        ? shape.borderRadius as BorderRadius
        : BorderRadius.circular(UiRadius.largeIncreased);

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = AdaptiveLayout.of(constraints);

        return Container(
          width: double.infinity,
          height: height ?? layout.cardHeight,
          padding: EdgeInsets.all(padding ?? layout.padding),
          decoration: BoxDecoration(
            color: theme.cardTheme.color ?? theme.colorScheme.surface,
            borderRadius: themeRadius,
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: AppTheme.emphasisAlpha),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(UiSpacing.sm),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: AppTheme.surfaceAlpha),
                  borderRadius:BorderRadius.all(Radius.circular(UiRadius.largeIncreased)), 
                ),
                child: Icon(
                  icon,
                  size: iconSize ?? layout.iconSize,
                  color: color,
                ),
              ),
              const Spacer(),
              Text(
                label,
                style: (labelStyle ?? theme.textTheme.labelLarge)?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: (valueStyle ?? theme.textTheme.headlineSmall)?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
