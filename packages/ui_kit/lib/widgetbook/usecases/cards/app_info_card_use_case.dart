import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../widgets/cards/app_info_card.dart';
import '../../../adaptive/ui_spacing.dart';


@widgetbook.UseCase(name: 'Default', type: AppInfoCard)
Widget buildAppInfoCardUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final (padding, textStyle) = switch (size) {
    'Compact' => (UiSpacing.md, Theme.of(context).textTheme.bodyMedium),
    'Medium' => (UiSpacing.lg, Theme.of(context).textTheme.bodyLarge),
    'Expanded' => (UiSpacing.xl, Theme.of(context).textTheme.titleMedium),
    'Large' => (UiSpacing.xl, Theme.of(context).textTheme.titleLarge),
    _ => (UiSpacing.lg, Theme.of(context).textTheme.bodyLarge),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: AppInfoCard(
        text: context.knobs.string(
          label: 'Text',
          initialValue: 'Вы нашли на улице старый кошелек. В нем оказалось несколько купюр и странная записка.',
        ),
        padding: padding,
        textAlign: TextAlign.center,
        textStyle: textStyle,
      ),
    ),
  );
}