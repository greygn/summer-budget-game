import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../adaptive/ui_spacing.dart';

class PassiveIncomeBanner extends StatelessWidget {
  final int savings;
  final double? padding;
  final double? iconSize;
  final TextStyle? textStyle;

  const PassiveIncomeBanner({
    super.key,
    required this.savings,
    this.padding,
    this.iconSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final baseColor = colorScheme.primary;

    return Container(
      padding: EdgeInsets.all(padding ?? 12),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: baseColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_graph_rounded, color: baseColor, size: iconSize ?? 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Завтра: +${(savings * 0.005).round()} – ${(savings * 0.015).round().clamp(0, 5000)} ₽ дохода",
              style: (textStyle ?? theme.textTheme.labelMedium)?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Default', type: PassiveIncomeBanner)
Widget buildPassiveIncomeBannerUseCase(BuildContext context) {
  final size = context.knobs.list<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (padding, iconSize, textStyle) = switch (size) {
    'Compact' => (UiSpacing.sm, 16.0, theme.textTheme.labelSmall),
    'Medium' => (UiSpacing.md, 20.0, theme.textTheme.labelMedium),
    'Expanded' => (UiSpacing.lg, 24.0, theme.textTheme.labelLarge),
    'Large' => (UiSpacing.xl, 28.0, theme.textTheme.titleSmall),
    _ => (UiSpacing.md, 20.0, theme.textTheme.labelMedium),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: PassiveIncomeBanner(
      savings: context.knobs.int.slider(
        label: 'Savings',
        initialValue: 50000,
        min: 0,
        max: 1000000,
      ),
      padding: padding,
      iconSize: iconSize,
      textStyle: textStyle,
    ),
  );
}
