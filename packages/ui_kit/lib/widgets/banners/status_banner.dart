import 'package:flutter/material.dart';

import '../../adaptive/adaptive_layout.dart';
import '../../adaptive/ui_radius.dart';
import '../../adaptive/ui_spacing.dart';
import '../../theme/app_theme.dart';

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

    final effectiveBgColor = backgroundColor ??
        colorScheme.errorContainer.withValues(alpha: AppTheme.emphasisAlpha);
    final effectiveFgColor = foregroundColor ?? colorScheme.onErrorContainer;

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = AdaptiveLayout.of(constraints);

        return Container(
          padding: EdgeInsets.all(padding ?? layout.padding),
          decoration: BoxDecoration(
            color: effectiveBgColor,
            borderRadius: BorderRadius.circular(UiRadius.largeIncreased),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: effectiveFgColor,
                size: iconSize ?? layout.iconSize,
              ),
              SizedBox(width: layout.isCompact ? UiSpacing.md : UiSpacing.lg),
              Expanded(
                child: Text(
                  message,
                  style: (textStyle ??
                          theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ))
                      ?.copyWith(
                    color: effectiveFgColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
