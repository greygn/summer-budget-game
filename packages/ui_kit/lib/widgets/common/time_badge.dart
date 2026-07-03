import 'package:flutter/material.dart';
import '../../adaptive/ui_icon_sizes.dart';
import '../../adaptive/ui_radius.dart';
import '../../adaptive/ui_spacing.dart';
import '../../adaptive/ui_text_sizes.dart';
import '../../theme/app_theme.dart';

class UITimeBadge extends StatelessWidget {
  final int time;
  final bool isLarge;
  final double? fontSize;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;

  const UITimeBadge({
    super.key,
    required this.time,
    this.isLarge = false,
    this.fontSize,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLow = time < UiSpacing.xs;

    if (isLarge) {
      return Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: UiSpacing.lg,
              vertical: UiSpacing.sm,
            ),
        decoration: BoxDecoration(
          color: isLow ? colorScheme.errorContainer : colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(UiRadius.largeIncreased),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_filled_rounded,
              size: iconSize ?? UiIconSizes.large,
              color: isLow ? colorScheme.error : colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: UiSpacing.sm),
            Text(
              '$time ч.',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: fontSize ?? UiTextSizes.titleMedium,
                color: isLow ? colorScheme.error : colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: UiIconSizes.compact,
              vertical: UiSpacing.sm,
            ),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(UiRadius.large),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: AppTheme.surfaceAlpha),
              blurRadius: UiRadius.small,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_filled_rounded,
              size: iconSize ?? UiIconSizes.expanded,
              color: colorScheme.onSecondaryContainer,
            ),
            const SizedBox(width: UiSpacing.sm),
            Text(
              '$time ч',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: fontSize,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
