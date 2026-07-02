import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import '../../adaptive/ui_spacing.dart';
import '../../adaptive/ui_icon_sizes.dart';

class ExpressiveInfoTile extends StatelessWidget {
  final String title;
  final num value;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final String? suffix;
  final bool enableAnimation;
  final Duration animationDuration;

  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? iconPadding;
  final double? height;
  final double? iconSize;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final TextStyle? subtitleStyle;

  const ExpressiveInfoTile({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.color,
    this.suffix,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 600),
    this.padding,
    this.borderRadius,
    this.iconPadding,
    this.height,
    this.iconSize,
    this.titleStyle,
    this.valueStyle,
    this.subtitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    final shape = theme.cardTheme.shape;
    final themeRadius = shape is RoundedRectangleBorder && shape.borderRadius is BorderRadius
        ? shape.borderRadius as BorderRadius
        : BorderRadius.circular(24);

    return Container(
      height: height,
      padding: padding ?? const EdgeInsets.all(UiSpacing.lg),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: 0.1),
        borderRadius: borderRadius ?? themeRadius,
        border: Border.all(
          color: effectiveColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          if (icon != null)
            Container(
              padding: iconPadding ?? const EdgeInsets.all(UiIconSizes.compact),
              decoration: BoxDecoration(
                color: effectiveColor,
                borderRadius: (borderRadius as BorderRadius? ?? themeRadius),
              ),
              child: Icon(
                icon,
                size: iconSize ?? 24,
                color: ThemeData.estimateBrightnessForColor(effectiveColor) == Brightness.dark
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
          if (icon != null) const SizedBox(width: UiSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: (titleStyle ?? theme.textTheme.labelLarge)?.copyWith(
                    color: effectiveColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildValue(context, effectiveColor),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: (subtitleStyle ?? theme.textTheme.labelSmall)?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValue(BuildContext context, Color color) {
    final theme = Theme.of(context);
    final style = (valueStyle ?? theme.textTheme.headlineSmall)?.copyWith(
      fontWeight: FontWeight.w900,
      color: color,
      letterSpacing: -0.5,
    );

    if (enableAnimation) {
      return AnimatedDigitWidget(
        key: ValueKey(value),
        value: value,
        suffix: suffix,
        duration: animationDuration,
        textStyle: style,
      );
    }

    return Text('$value${suffix ?? ''}', style: style);
  }
}
