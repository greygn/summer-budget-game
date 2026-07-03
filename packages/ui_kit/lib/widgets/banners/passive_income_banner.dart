import 'package:flutter/material.dart';

import '../../adaptive/adaptive_layout.dart';
import '../../adaptive/ui_spacing.dart';
import '../../theme/app_theme.dart';

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

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = AdaptiveLayout.of(constraints);

        return Container(
          padding: EdgeInsets.all(padding ?? layout.padding),
          decoration: BoxDecoration(
            color: baseColor.withValues(alpha: AppTheme.surfaceAlpha),
            borderRadius: BorderRadius.circular(UiSpacing.lg),
            border: Border.all(
              color: baseColor.withValues(alpha: AppTheme.strokeAlpha),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.auto_graph_rounded,
                color: baseColor,
                size: iconSize ?? layout.iconSize,
              ),
              SizedBox(width: layout.isCompact ? UiSpacing.sm : UiSpacing.md),
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
      },
    );
  }
}
