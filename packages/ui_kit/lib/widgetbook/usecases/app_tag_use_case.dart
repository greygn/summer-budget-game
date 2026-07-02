import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Adaptive',
  type: AppTag,
)
Widget adaptiveTag(BuildContext context) {
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
      min: 72,
      max: 360,
      divisions: 31,
      initialValue: 160,
    ),
  };

  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Premium',
  );

  final showIcon = context.knobs.boolean(
    label: 'Show icon',
    initialValue: true,
  );

  final useCustomColor = context.knobs.boolean(
    label: 'Custom color',
    initialValue: false,
  );

  final color = useCustomColor
      ? context.knobs.color(
    label: 'Foreground color',
    initialValue: Colors.green,
  )
      : null;

  final useCustomBackground = context.knobs.boolean(
    label: 'Custom background',
    initialValue: false,
  );

  final backgroundColor = useCustomBackground
      ? context.knobs.color(
    label: 'Background color',
    initialValue: Colors.greenAccent,
  )
      : null;

  return Center(
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: width,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: AppTag(
        label: label,
        icon: showIcon ? Icons.star_rounded : null,
        color: color,
        backgroundColor: backgroundColor,
        onTap: () {},
      ),
    ),
  );
}
