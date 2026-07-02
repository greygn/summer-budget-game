import 'package:flutter/material.dart';

class StatusBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? iconSize;
  final double? padding;
  final TextStyle? textStyle;

  const StatusBanner({
    super.key,
    required this.message,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.iconSize,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBgColor = backgroundColor ?? colorScheme.errorContainer.withValues(alpha: 0.5);
    final effectiveFgColor = foregroundColor ?? colorScheme.onErrorContainer;

    return Container(
      padding: EdgeInsets.all(padding ?? 16),
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: effectiveFgColor, size: iconSize),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: (textStyle ?? const TextStyle(fontWeight: FontWeight.bold)).copyWith(
                color: effectiveFgColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
