import 'package:flutter/material.dart';

import '../adaptive/ui_widths.dart';
import '../adaptive/ui_icon_sizes.dart';
import '../adaptive/ui_spacing.dart';

class TimeBadge extends StatelessWidget {
  const TimeBadge({
    super.key,
    required this.duration,
    this.size = AppBadgeSize.small,
  });

  final Duration duration;
  final AppBadgeSize size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final hours = duration.inHours;
    final isShort = hours < 4;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isCompact = width < UiWidths.compact;
        final isMedium =
            width >= UiWidths.compact && width < UiWidths.medium;
        final isExpanded =
            width >= UiWidths.medium && width < UiWidths.expanded;
        final isLarge = width >= UiWidths.expanded;

        final resolvedSize = switch (true) {
          _ when isCompact => AppBadgeSize.small,
          _ when isMedium => AppBadgeSize.small,
          _ when isExpanded => size == AppBadgeSize.large
              ? AppBadgeSize.large
              : AppBadgeSize.medium,
          _ when isLarge => size,
          _ => size,
        };

        late EdgeInsets padding;
        late final double iconSize;
        late final TextStyle? textStyle;
        late final double gap;
        late final double radius;

        switch (resolvedSize) {
          case AppBadgeSize.small:
            padding = const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            );
            iconSize = UiIconSizes.compact;
            textStyle = theme.textTheme.labelMedium;
            gap = UiSpacing.xs;
            radius = 18;

          case AppBadgeSize.medium:
            padding = const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            );
            iconSize = UiIconSizes.medium;
            textStyle = theme.textTheme.titleSmall;
            gap = UiSpacing.sm;
            radius = 18;

          case AppBadgeSize.large:
            padding = const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 12,
            );
            iconSize = UiIconSizes.large;
            textStyle = theme.textTheme.titleMedium;
            gap = UiSpacing.sm;
            radius = 20;
        }

        if (isCompact) {
          padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 7);
        } else if (isLarge) {
          padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
        }

        final background = isShort
            ? colorScheme.errorContainer
            : colorScheme.secondaryContainer;

        final foreground = isShort
            ? colorScheme.onErrorContainer
            : colorScheme.onSecondaryContainer;

        return Material(
          color: background,
          borderRadius: BorderRadius.circular(radius),
          child: Padding(
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  size: iconSize,
                  color: foreground,
                ),
                SizedBox(width: gap),
                Text(
                  '${duration.inHours} ч',
                  style: textStyle?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum AppBadgeSize {
  small,
  medium,
  large,
}
