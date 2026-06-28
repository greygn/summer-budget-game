import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class AppHeroIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color onColor;
  final String heroTag;

  const AppHeroIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.onColor,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 64,
          color: onColor,
        ),
      ),
    );
  }
}


@widgetbook.UseCase(name: 'Event Success', type: AppHeroIcon)
Widget buildAppHeroIconSuccessUseCase(BuildContext context) {
  final theme = Theme.of(context);
  return Center(
    child: AppHeroIcon(
      icon: Icons.auto_awesome_rounded,
      color: theme.colorScheme.primary,
      onColor: theme.colorScheme.onPrimary,
      heroTag: 'success_icon',
    ),
  );
}

@widgetbook.UseCase(name: 'Event Danger', type: AppHeroIcon)
Widget buildAppHeroIconDangerUseCase(BuildContext context) {
  final theme = Theme.of(context);
  return Center(
    child: AppHeroIcon(
      icon: Icons.warning_rounded,
      color: theme.colorScheme.error,
      onColor: theme.colorScheme.onError,
      heroTag: 'danger_icon',
    ),
  );
}
