import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class UITimeBadge extends StatelessWidget {
  final int time;
  final bool isLarge;

  const UITimeBadge({
    super.key,
    required this.time,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLow = time < 4;

    if (isLarge) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isLow ? colorScheme.errorContainer : colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_filled_rounded, 
              size: 20, 
              color: isLow ? colorScheme.error : colorScheme.onSecondaryContainer
            ),
            const SizedBox(width: 8),
            Text(
              '$time ч.',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: isLow ? colorScheme.error : colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      );
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.05), 
              blurRadius: 10
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.access_time_filled_rounded, 
                 size: 18, color: colorScheme.onSecondaryContainer),
            const SizedBox(width: 8),
            Text(
              '$time ч',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w900,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Large (Low Time)', type: UITimeBadge)
Widget buildUITimeBadgeLargeLowUseCase(BuildContext context) {
  return const Center(child: UITimeBadge(time: 2, isLarge: true));
}

@widgetbook.UseCase(name: 'Small', type: UITimeBadge)
Widget buildUITimeBadgeSmallUseCase(BuildContext context) {
  return const Center(child: UITimeBadge(time: 12, isLarge: false));
}
