import 'package:flutter/material.dart';

class PassiveIncomeBanner extends StatelessWidget {
  final String incomeText;
  final double? padding;
  final double? iconSize;
  final TextStyle? textStyle;

  const PassiveIncomeBanner({
    super.key,
    required this.incomeText,
    this.padding,
    this.iconSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final baseColor = colorScheme.primary;

    return Container(
      padding: EdgeInsets.all(padding ?? 12),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: baseColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.auto_graph_rounded,
            color: baseColor,
            size: iconSize ?? 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              incomeText,
              style: (textStyle ?? theme.textTheme.labelMedium)?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
