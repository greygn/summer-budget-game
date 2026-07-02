import 'package:flutter/material.dart';
import '../../adaptive/ui_spacing.dart';

class AppInfoCard extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double? padding;
  final TextStyle? textStyle;

  const AppInfoCard({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final shape = theme.cardTheme.shape;
    final themeRadius = shape is RoundedRectangleBorder && shape.borderRadius is BorderRadius
        ? shape.borderRadius as BorderRadius
        : BorderRadius.circular(24);

    return Container(
      padding: EdgeInsets.all(padding ?? UiSpacing.xl),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: themeRadius,
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        text,
        style: (textStyle ?? theme.textTheme.bodyLarge)?.copyWith(
          height: 1.5,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        textAlign: textAlign,
      ),
    );
  }
}

