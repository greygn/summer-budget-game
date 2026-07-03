import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../widgets/cards/game_progress_card.dart';
import '../../../adaptive/ui_spacing.dart';

@widgetbook.UseCase(
  name: 'Default',
  type: GameProgressCard,
)
Widget buildGameProgressCardUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (padding, modeStyle, dayStyle, goalStyle, progHeight, tbFontSize, tbIconSize, tbPadding, maxWidth) = switch (size) {
    'Compact' => (
        UiSpacing.md,
        theme.textTheme.labelSmall,
        theme.textTheme.titleMedium,
        theme.textTheme.labelSmall,
        8.0,
        12.0,
        16.0,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        360.0
      ),
    'Medium' => (
        UiSpacing.lg,
        theme.textTheme.labelMedium,
        theme.textTheme.headlineSmall,
        theme.textTheme.labelLarge,
        12.0,
        16.0,
        20.0,
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        400.0
      ),
    'Expanded' => (
        UiSpacing.xl,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineMedium,
        theme.textTheme.titleSmall,
        14.0,
        18.0,
        22.0,
        const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        480.0
      ),
    'Large' => (
        UiSpacing.xl,
        theme.textTheme.titleSmall,
        theme.textTheme.headlineLarge,
        theme.textTheme.titleMedium,
        16.0,
        20.0,
        24.0,
        const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        560.0
      ),
    _ => (
        UiSpacing.lg,
        theme.textTheme.labelMedium,
        theme.textTheme.headlineSmall,
        theme.textTheme.labelLarge,
        12.0,
        16.0,
        20.0,
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        400.0
      ),
  };

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: GameProgressCard(
          modeTitle: context.knobs.string(
            label: 'Mode Title',
            initialValue: 'МАРАФОН',
          ),
          dayText: context.knobs.string(
            label: 'Day Text',
            initialValue: 'День 12 из 30',
          ),
          time: context.knobs.int.slider(
            label: 'Time',
            initialValue: 8,
            min: 0,
            max: 24,
          ),
          progress: context.knobs.double.slider(
            label: 'Progress',
            initialValue: 0.4,
            min: 0.0,
            max: 1.0,
          ),
          goalText: context.knobs.string(
            label: 'Goal Text',
            initialValue: 'Цель: 100 000 ₽',
          ),
          padding: padding,
          modeTitleStyle: modeStyle,
          dayTextStyle: dayStyle,
          goalTextStyle: goalStyle,
          progressHeight: progHeight,
          timeBadgeFontSize: tbFontSize,
          timeBadgeIconSize: tbIconSize,
          timeBadgePadding: tbPadding,
        ),
      ),
    ),
  );
}