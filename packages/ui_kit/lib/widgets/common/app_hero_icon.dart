import 'package:flutter/material.dart';

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
