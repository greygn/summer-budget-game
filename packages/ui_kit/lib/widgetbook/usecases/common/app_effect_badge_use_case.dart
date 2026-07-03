import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../widgets/common/app_effect_badge.dart';

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