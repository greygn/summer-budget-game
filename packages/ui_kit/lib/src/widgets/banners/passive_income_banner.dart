import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class PassiveIncomeBanner extends StatelessWidget {
  final int savings;
  const PassiveIncomeBanner({super.key, required this.savings});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final baseColor = colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: baseColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_graph_rounded, color: baseColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Завтра: +${(savings * 0.005).round()} – ${(savings * 0.015).round().clamp(0, 5000)} ₽ дохода",
              style: theme.textTheme.labelMedium?.copyWith(
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
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: PassiveIncomeBanner(
      savings: context.knobs.int.slider(
        label: 'Savings',
        initialValue: 50000,
        min: 0,
        max: 1000000,
      ),
    ),
  );
}
