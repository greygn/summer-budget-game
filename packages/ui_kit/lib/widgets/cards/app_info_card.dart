import 'package:flutter/material.dart';
import '../../adaptive/adaptive_layout.dart';
import '../../adaptive/ui_spacing.dart';
import '../../adaptive/ui_radius.dart';
import '../../theme/app_theme.dart';

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
    final themeRadius =
        shape is RoundedRectangleBorder && shape.borderRadius is BorderRadius
            ? shape.borderRadius as BorderRadius
            : BorderRadius.circular(UiRadius.largeIncreased);

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = AdaptiveLayout.of(constraints);

        return Container(
          padding: EdgeInsets.all(padding ?? layout.padding),
          decoration: BoxDecoration(
            color: theme.cardTheme.color ?? theme.colorScheme.surface,
            borderRadius: themeRadius,
            border: Border.all(
              color: theme.colorScheme.outlineVariant
                  .withValues(alpha: AppTheme.emphasisAlpha),
            ),
          ),
          child: Text(
            text,
            style: (textStyle ?? theme.textTheme.bodyLarge)?.copyWith(
              height: AppTheme.lineHeightDefault,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: textAlign,
          ),
        );
      },
    );
  }
}
