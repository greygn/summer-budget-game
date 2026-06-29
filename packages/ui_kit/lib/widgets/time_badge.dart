import 'package:flutter/material.dart';

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

    late final EdgeInsets padding;
    late final double iconSize;
    late final TextStyle? textStyle;

    switch (size) {
      case AppBadgeSize.small:
        padding = const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        );
        iconSize = 16;
        textStyle = theme.textTheme.labelMedium;

      case AppBadgeSize.medium:
        padding = const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        );
        iconSize = 18;
        textStyle = theme.textTheme.titleSmall;

      case AppBadgeSize.large:
        padding = const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        );
        iconSize = 22;
        textStyle = theme.textTheme.titleMedium;
    }

    final background = isShort
        ? colorScheme.errorContainer
        : colorScheme.secondaryContainer;

    final foreground = isShort
        ? colorScheme.onErrorContainer
        : colorScheme.onSecondaryContainer;

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(18),
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
            const SizedBox(width: 8),
            Text(
              "${duration.inHours} ч",
              style: textStyle?.copyWith(
                color: foreground,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum AppBadgeSize {
  small,
  medium,
  large,
}
