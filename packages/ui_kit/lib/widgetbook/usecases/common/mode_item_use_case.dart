import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Adaptive',
  type: ModeItem,
)
Widget adaptiveModeItem(BuildContext context) {
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
      initialValue: 360,
      min: 240,
      max: 1600,
      divisions: 68,
    ),
  };

  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Sprint',
  );

  final subtitle = context.knobs.string(
    label: 'Subtitle',
    initialValue: 'Complete the challenge',
  );

  final useCustomColor = context.knobs.boolean(
    label: 'Custom color',
    initialValue: false,
  );

  final color = useCustomColor
      ? context.knobs.color(
    label: 'Color',
    initialValue: Colors.blue,
  )
      : Colors.blue;

  final icon = context.knobs.object.dropdown<IconData>(
    label: 'Icon',
    options: const [
      Icons.timer,
      Icons.flash_on,
      Icons.flag,
      Icons.local_fire_department,
    ],
    initialOption: Icons.timer,
  );

  return Center(
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: width,
      height: 120,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: ModeItem(
        title: title,
        subtitle: subtitle,
        icon: icon,
        color: color,
        onTap: () {},
      ),
    ),
  );
}
