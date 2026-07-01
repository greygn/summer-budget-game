import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class AppEffectBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPositive;
  final Color? customColor;
  final double? fontSize;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;

  const AppEffectBadge({
    super.key,
    required this.label,
    required this.icon,
    this.isPositive = true,
    this.customColor,
    this.fontSize,
    this.iconSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultPositiveColor = theme.brightness == Brightness.dark 
        ? Colors.greenAccent 
        : Colors.green;
        
    final color = customColor ??
        (isPositive ? defaultPositiveColor : theme.colorScheme.error);

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize ?? 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: fontSize ?? 13,
            ),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Positive', type: AppEffectBadge)
Widget buildAppEffectBadgePositiveUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final (padding, iconSize, fontSize) = switch (size) {
    'Compact' => (const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 14.0, 11.0),
    'Medium' => (const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 16.0, 13.0),
    'Expanded' => (const EdgeInsets.symmetric(horizontal: 14, vertical: 10), 18.0, 14.0),
    'Large' => (const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 20.0, 15.0),
    _ => (const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 16.0, 13.0),
  };

  return Center(
    child: AppEffectBadge(
      label: context.knobs.string(label: 'Label', initialValue: '+500 ₽'),
      icon: Icons.payments_rounded,
      isPositive: true,
      padding: padding,
      iconSize: iconSize,
      fontSize: fontSize,
    ),
  );
}

@widgetbook.UseCase(name: 'Negative', type: AppEffectBadge)
Widget buildAppEffectBadgeNegativeUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final (padding, iconSize, fontSize) = switch (size) {
    'Compact' => (const EdgeInsets.symmetric(horizontal: 8, vertical: 4), 14.0, 11.0),
    'Medium' => (const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 16.0, 13.0),
    'Expanded' => (const EdgeInsets.symmetric(horizontal: 14, vertical: 10), 18.0, 14.0),
    'Large' => (const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 20.0, 15.0),
    _ => (const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 16.0, 13.0),
  };

  return Center(
    child: AppEffectBadge(
      label: context.knobs.string(label: 'Label', initialValue: '-200 ₽'),
      icon: Icons.payments_rounded,
      isPositive: false,
      padding: padding,
      iconSize: iconSize,
      fontSize: fontSize,
    ),
  );
}
