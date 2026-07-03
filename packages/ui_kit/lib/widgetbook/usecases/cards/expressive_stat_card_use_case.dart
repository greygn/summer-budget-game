import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../widgets/cards/expressive_stat_card.dart';
import '../../../adaptive/ui_heights.dart';
import '../../../adaptive/ui_spacing.dart';

@widgetbook.UseCase(name: 'Happiness', type: ExpressiveStatCard)
Widget buildExpressiveStatCardUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (height, iconSize, padding, width, labelStyle, valueStyle) = switch (size) {
    'Compact' => (
        UiHeights.compact,
        18.0,
        UiSpacing.md,
        140.0,
        theme.textTheme.labelSmall,
        theme.textTheme.titleMedium
      ),
    'Medium' => (
        UiHeights.medium,
        24.0,
        UiSpacing.lg,
        160.0,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall
      ),
    'Expanded' => (
        UiHeights.expanded,
        28.0,
        UiSpacing.xl,
        180.0,
        theme.textTheme.titleSmall,
        theme.textTheme.headlineMedium
      ),
    'Large' => (
        UiHeights.large,
        32.0,
        UiSpacing.xl,
        200.0,
        theme.textTheme.titleMedium,
        theme.textTheme.headlineLarge
      ),
    _ => (
        UiHeights.medium,
        24.0,
        UiSpacing.lg,
        160.0,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall
      ),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: SizedBox(
        width: width,
        child: ExpressiveStatCard(
          label: "Счастье",
          value: "85%",
          icon: Icons.face_retouching_natural_rounded,
          color: Colors.orange,
          height: height,
          iconSize: iconSize,
          padding: padding,
          labelStyle: labelStyle,
          valueStyle: valueStyle,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Energy', type: ExpressiveStatCard)
Widget buildExpressiveStatEnergyUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (height, iconSize, padding, width, labelStyle, valueStyle) = switch (size) {
    'Compact' => (
        UiHeights.compact,
        18.0,
        UiSpacing.md,
        140.0,
        theme.textTheme.labelSmall,
        theme.textTheme.titleMedium
      ),
    'Medium' => (
        UiHeights.medium,
        24.0,
        UiSpacing.lg,
        160.0,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall
      ),
    'Expanded' => (
        UiHeights.expanded,
        28.0,
        UiSpacing.xl,
        180.0,
        theme.textTheme.titleSmall,
        theme.textTheme.headlineMedium
      ),
    'Large' => (
        UiHeights.large,
        32.0,
        UiSpacing.xl,
        200.0,
        theme.textTheme.titleMedium,
        theme.textTheme.headlineLarge
      ),
    _ => (
        UiHeights.medium,
        24.0,
        UiSpacing.lg,
        160.0,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall
      ),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: SizedBox(
        width: width,
        child: ExpressiveStatCard(
          label: "Энергия",
          value: "40%",
          icon: Icons.bolt_rounded,
          color: Colors.amber,
          height: height,
          iconSize: iconSize,
          padding: padding,
          labelStyle: labelStyle,
          valueStyle: valueStyle,
        ),
      ),
    ),
  );
}