import 'package:flutter/material.dart';
import '../../adaptive/ui_radius.dart';
import '../../adaptive/ui_spacing.dart';
import '../../theme/app_theme.dart';

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
        padding: const EdgeInsets.all(UiSpacing.xxl),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(UiRadius.extraLargeIncr),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: AppTheme.inputAlpha),
              blurRadius: UiRadius.largeIncreased,
              offset: const Offset(0, UiSpacing.md),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: UiRadius.extraLargeIncr + UiRadius.extraLargeIncr,
          color: onColor,
        ),
      ),
    );
  }
}
