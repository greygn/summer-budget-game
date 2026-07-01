import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Adaptive',
  type: ExpressiveResultStat,
)
Widget adaptiveStat(BuildContext context) {
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
      initialValue: 220,
      min: 180,
      max: 1600,
      divisions: 70,
    ),
  };

  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Completed',
  );

  final value = context.knobs.string(
    label: 'Value',
    initialValue: '42',
  );

  final useCustomColor = context.knobs.boolean(
    label: 'Custom color',
    initialValue: false,
  );

  final color = useCustomColor
      ? context.knobs.color(
    label: 'Color',
    initialValue: Colors.green,
  )
      : Colors.green;

  final icon = context.knobs.object.dropdown<IconData>(
    label: 'Icon',
    options: const [
      Icons.check_circle,
      Icons.trending_up,
      Icons.star,
      Icons.favorite,
    ],
    initialOption: Icons.check_circle,
  );

  return Center(
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: width,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: ExpressiveResultStat(
        label: label,
        value: value,
        icon: icon,
        color: color,
      ),
    ),
  );
}
