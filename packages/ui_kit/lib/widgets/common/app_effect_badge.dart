import 'package:flutter/material.dart';

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
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize ?? 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: fontSize ?? 12,
            ),
          ),
        ],
      ),
    );
  }
}

