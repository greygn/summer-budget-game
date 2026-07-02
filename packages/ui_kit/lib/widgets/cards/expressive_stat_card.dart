import 'package:flutter/material.dart';
import '../../adaptive/ui_heights.dart';
import '../../adaptive/ui_spacing.dart';

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
        : BorderRadius.circular(24);

    return Container(
      width: double.infinity,
      height: height ?? UiHeights.medium,
      padding: EdgeInsets.all(padding ?? UiSpacing.lg),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: themeRadius,
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: themeRadius * 0.5,
            ),
            child: Icon(icon, size: iconSize ?? 24, color: color),
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
  }
}
