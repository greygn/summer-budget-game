import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgets/cards/expressive_info_tile.dart';
import '../../adaptive/ui_icon_sizes.dart';
import '../../adaptive/ui_spacing.dart';

@widgetbook.UseCase(name: 'Wallet', type: ExpressiveInfoTile)
Widget buildExpressiveInfoTileUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (height, iconSize, padding, iconPadding, tStyle, vStyle, sStyle) = switch (size) {
    'Compact' => (
        null,
        UiIconSizes.compact,
        UiSpacing.md,
        UiSpacing.sm,
        theme.textTheme.labelMedium,
        theme.textTheme.titleMedium,
        theme.textTheme.labelSmall
      ),
    'Medium' => (
        null,
        UiIconSizes.medium,
        UiSpacing.lg,
        UiSpacing.md,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall,
        theme.textTheme.labelSmall
      ),
    'Expanded' => (
        null,
        UiIconSizes.expanded,
        UiSpacing.xl,
        UiSpacing.lg,
        theme.textTheme.titleSmall,
        theme.textTheme.headlineMedium,
        theme.textTheme.labelMedium
      ),
    'Large' => (
        null,
        UiIconSizes.large,
        UiSpacing.xl,
        UiSpacing.lg,
        theme.textTheme.titleMedium,
        theme.textTheme.headlineLarge,
        theme.textTheme.labelLarge
      ),
    _ => (
        null,
        UiIconSizes.medium,
        UiSpacing.lg,
        UiSpacing.md,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall,
        theme.textTheme.labelSmall
      ),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ExpressiveInfoTile(
          title: "В кошельке",
        value: 15400,
        subtitle: "Общие активы: 25400 ₽",
        icon: Icons.account_balance_wallet_rounded,
        color: Colors.teal,
        suffix: ' ₽',
        height: height,
        iconSize: iconSize,
        padding: EdgeInsets.all(padding),
        iconPadding: EdgeInsets.all(iconPadding),
        titleStyle: tStyle,
        valueStyle: vStyle,
        subtitleStyle: sStyle,
      ),
    ),
  )
  );
}

@widgetbook.UseCase(name: 'Savings', type: ExpressiveInfoTile)
Widget buildExpressiveInfoTileSavingsUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (height, iconSize, padding, iconPadding, tStyle, vStyle, sStyle) = switch (size) {
    'Compact' => (
        null,
        UiIconSizes.compact,
        UiSpacing.md,
        UiSpacing.sm,
        theme.textTheme.labelMedium,
        theme.textTheme.titleMedium,
        theme.textTheme.labelSmall
      ),
    'Medium' => (
        null,
        UiIconSizes.medium,
        UiSpacing.lg,
        UiSpacing.md,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall,
        theme.textTheme.labelSmall
      ),
    'Expanded' => (
        null,
        UiIconSizes.expanded,
        UiSpacing.xl,
        UiSpacing.lg,
        theme.textTheme.titleSmall,
        theme.textTheme.headlineMedium,
        theme.textTheme.labelMedium
      ),
    'Large' => (
        null,
        UiIconSizes.large,
        UiSpacing.xl,
        UiSpacing.lg,
        theme.textTheme.titleMedium,
        theme.textTheme.headlineLarge,
        theme.textTheme.labelLarge
      ),
    _ => (
        null,
        UiIconSizes.medium,
        UiSpacing.lg,
        UiSpacing.md,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall,
        theme.textTheme.labelSmall
      ),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: ExpressiveInfoTile(
          title: "Накопления",
        value: 125000,
        subtitle: "Цель: 100 000 ₽",
        icon: Icons.savings_rounded,
        color: Colors.blue,
        suffix: ' ₽',
        height: height,
        iconSize: iconSize,
        padding: EdgeInsets.all(padding),
        iconPadding: EdgeInsets.all(iconPadding),
        titleStyle: tStyle,
        valueStyle: vStyle,
        subtitleStyle: sStyle,
      ),
    ),
  )
  );
}