import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../adaptive/ui_spacing.dart';
import '../../../widgets/banners/passive_income_banner.dart';

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
      incomeText: 'Завтра: +250 – 750 ₽ дохода',
      padding: padding,
      iconSize: iconSize,
      textStyle: textStyle,
    ),
  );
}