import 'package:flutter/material.dart';
import '../../adaptive/ui_icon_sizes.dart';
import '../../adaptive/ui_radius.dart';
import '../../adaptive/ui_spacing.dart';
import '../../adaptive/ui_text_sizes.dart';
import '../../theme/app_theme.dart';

class AppEffectBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPositive;
  final Color? customColor;
  final double? fontSize;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;

  const AppEffectBadge({
    super.key,
    required this.label,
    required this.icon,
    this.isPositive = true,
    this.customColor,
    this.fontSize,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultPositiveColor = theme.brightness == Brightness.dark 
        ? Colors.greenAccent 
        : Colors.green;
        
    final color = customColor ??
        (isPositive ? defaultPositiveColor : theme.colorScheme.error);

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: UiSpacing.md, 
        vertical: UiSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: AppTheme.surfaceAlpha),
        borderRadius: BorderRadius.circular(UiRadius.large),
        border: Border.all(color: color.withValues(alpha: AppTheme.strokeAlpha)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize ?? UiIconSizes.medium, color: color),
          const SizedBox(width: UiSpacing.sm),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: fontSize ?? UiTextSizes.labelMedium,
            ),
          ),
        ],
      ),
    );
  }
}
