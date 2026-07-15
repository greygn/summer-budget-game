import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../adaptive/ui_spacing.dart';
import '../../../widgets/banners/status_banner.dart';


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