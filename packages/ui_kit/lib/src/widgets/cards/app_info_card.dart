import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class AppInfoCard extends StatelessWidget {
  final String text;
  final TextAlign textAlign;

  const AppInfoCard({
    super.key,
    required this.text,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final shape = theme.cardTheme.shape;
    final themeRadius = shape is RoundedRectangleBorder && shape.borderRadius is BorderRadius
        ? shape.borderRadius as BorderRadius
        : BorderRadius.circular(24);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: themeRadius,
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(
          height: 1.5,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        textAlign: textAlign,
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Default', type: AppInfoCard)
Widget buildAppInfoCardUseCase(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: AppInfoCard(
        text: context.knobs.string(
          label: 'Text',
          initialValue: 'Вы нашли на улице старый кошелек. В нем оказалось несколько купюр и странная записка.',
        ),
      ),
    ),
  );
}
