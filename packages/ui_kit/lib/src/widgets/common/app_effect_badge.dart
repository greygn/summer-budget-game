import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class AppEffectBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPositive;
  final Color? customColor;

  const AppEffectBadge({
    super.key,
    required this.label,
    required this.icon,
    this.isPositive = true,
    this.customColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // В тёмной теме используем чуть более мягкий зеленый, если не задан customColor
    final defaultPositiveColor = theme.brightness == Brightness.dark 
        ? Colors.greenAccent 
        : Colors.green;
        
    final color = customColor ??
        (isPositive ? defaultPositiveColor : theme.colorScheme.error);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Default', type: AppEffectBadge)
Widget buildAppEffectBadgeUseCase(BuildContext context) {
  return Center(
    child: AppEffectBadge(
      label: context.knobs.string(label: 'Label', initialValue: '+500 ₽'),
      icon: Icons.payments_rounded,
      isPositive:
          context.knobs.boolean(label: 'Is Positive', initialValue: true),
    ),
  );
}
