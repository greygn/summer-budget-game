import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Adaptive',
  type: MenuButton,
)
Widget adaptiveMenuButton(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  final screenSize = context.knobs.object.dropdown<String>(
    label: 'Screen size',
    options: const [
      'compact',
      'medium',
      'expanded',
      'large',
      'custom',
    ],
    initialOption: 'compact',
  );

  final width = switch (screenSize) {
    'compact' => 320.0,
    'medium' => 700.0,
    'expanded' => 960.0,
    'large' => 1320.0,
    _ => context.knobs.double.slider(
      label: 'Width',
      initialValue: 320,
      min: 240,
      max: 1600,
      divisions: 68,
    ),
  };

  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Continue',
  );

  final useCustomBg = context.knobs.boolean(
    label: 'Custom background',
    initialValue: false,
  );

  final backgroundColor = useCustomBg
      ? context.knobs.color(
    label: 'Background color',
    initialValue: colors.primary,
  )
      : colors.primary;

  final useCustomFg = context.knobs.boolean(
    label: 'Custom foreground',
    initialValue: false,
  );

  final foregroundColor = useCustomFg
      ? context.knobs.color(
    label: 'Foreground color',
    initialValue: colors.onPrimary,
  )
      : colors.onPrimary;

  final icon = context.knobs.object.dropdown<IconData>(
    label: 'Icon',
    options: const [
      Icons.play_arrow,
      Icons.arrow_forward,
      Icons.check,
      Icons.send,
    ],
    initialOption: Icons.play_arrow,
  );

  return Center(
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: width,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: MenuButton(
        label: label,
        icon: icon,
        onPressed: () {},
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
    ),
  );
}
