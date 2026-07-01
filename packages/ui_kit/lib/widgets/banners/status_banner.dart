import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../adaptive/ui_spacing.dart';

class StatusBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? iconSize;
  final double? padding;
  final TextStyle? textStyle;

  const StatusBanner({
    super.key,
    required this.message,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.iconSize,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Используем withValues для корректной прозрачности в Flutter 3.27+
    final effectiveBgColor = backgroundColor ?? colorScheme.errorContainer.withValues(alpha: 0.5);
    final effectiveFgColor = foregroundColor ?? colorScheme.onErrorContainer;

    return Container(
      padding: EdgeInsets.all(padding ?? 16),
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: effectiveFgColor, size: iconSize),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: (textStyle ?? const TextStyle(fontWeight: FontWeight.bold)).copyWith(
                color: effectiveFgColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Default', type: StatusBanner)
Widget buildStatusBannerUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (padding, iconSize, textStyle) = switch (size) {
    'Compact' => (UiSpacing.sm, 18.0, theme.textTheme.labelMedium),
    'Medium' => (UiSpacing.md, 24.0, theme.textTheme.labelLarge),
    'Expanded' => (UiSpacing.lg, 28.0, theme.textTheme.titleSmall),
    'Large' => (UiSpacing.xl, 32.0, theme.textTheme.titleMedium),
    _ => (UiSpacing.md, 24.0, theme.textTheme.labelLarge),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: StatusBanner(
      message: context.knobs.string(
        label: 'Message',
        initialValue: "Инфляция: +10% к ценам",
      ),
      icon: Icons.trending_up_rounded,
      backgroundColor: context.knobs.colorOrNull(
        label: 'Background Color',
      ),
      foregroundColor: context.knobs.colorOrNull(
        label: 'Foreground Color',
      ),
      padding: padding,
      iconSize: iconSize,
      textStyle: textStyle?.copyWith(fontWeight: FontWeight.bold),
    ),
  );
}
