import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class StatusBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const StatusBanner({
    super.key,
    required this.message,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Используем withValues для корректной прозрачности в Flutter 3.27+
    final effectiveBgColor = backgroundColor ?? colorScheme.errorContainer.withValues(alpha: 0.5);
    final effectiveFgColor = foregroundColor ?? colorScheme.onErrorContainer;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: effectiveFgColor),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: effectiveFgColor,
                fontWeight: FontWeight.bold,
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
    ),
  );
}
