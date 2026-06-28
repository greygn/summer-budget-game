import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

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
      padding: padding ?? const EdgeInsets.all(16),
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
              padding: iconPadding ?? const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: effectiveColor,
                borderRadius: (borderRadius as BorderRadius? ?? themeRadius) * 0.7,
              ),
              child: Icon(
                icon,
                size: 24,
                color: ThemeData.estimateBrightnessForColor(effectiveColor) == Brightness.dark
                    ? Colors.white
                    : Colors.black87,
              ),
            ),
          if (icon != null) const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
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
                    style: theme.textTheme.labelSmall?.copyWith(
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
    final style = theme.textTheme.headlineSmall?.copyWith(
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

@widgetbook.UseCase(name: 'Default', type: ExpressiveInfoTile)
Widget buildExpressiveInfoTileUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: Center(
      child: ExpressiveInfoTile(
        title: "В кошельке",
        value: 15400,
        subtitle: "Общие активы: 25400 ₽",
        icon: Icons.account_balance_wallet_rounded,
        color: Colors.teal,
        suffix: ' ₽',
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Накопления', type: ExpressiveInfoTile)
Widget buildExpressiveInfoTileSavingsUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: Center(
      child: ExpressiveInfoTile(
        title: "Накопления",
        value: 125000,
        subtitle: "Цель: 100 000 ₽",
        icon: Icons.savings_rounded,
        color: Colors.blue,
        suffix: ' ₽',
      ),
    ),
  );
}
