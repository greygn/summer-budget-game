import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class ExpressiveStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const ExpressiveStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final shape = theme.cardTheme.shape;
    final themeRadius = shape is RoundedRectangleBorder && shape.borderRadius is BorderRadius
        ? shape.borderRadius as BorderRadius
        : BorderRadius.circular(24);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: themeRadius,
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: themeRadius * 0.5,
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          const Spacer(),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Happiness', type: ExpressiveStatCard)
Widget buildExpressiveStatCardUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: SizedBox(
      width: 160,
      height: 140,
      child: ExpressiveStatCard(
        label: "Счастье",
        value: "85%",
        icon: Icons.face_retouching_natural_rounded,
        color: Colors.orange,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Energy', type: ExpressiveStatCard)
Widget buildExpressiveStatEnergyUseCase(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: SizedBox(
      width: 160,
      height: 140,
      child: ExpressiveStatCard(
        label: "Энергия",
        value: "40%",
        icon: Icons.bolt_rounded,
        color: Colors.amber,
      ),
    ),
  );
}
