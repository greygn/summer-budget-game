import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../widgets/inputs/app_editor_field.dart';

@widgetbook.UseCase(name: 'Default', type: AppEditorField)
Widget buildAppEditorFieldUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final (fontSize, iconSize) = switch (size) {
    'Compact' => (14.0, 20.0),
    'Medium' => (16.0, 24.0),
    'Expanded' => (18.0, 26.0),
    'Large' => (20.0, 28.0),
    _ => (16.0, 24.0),
  };

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Center(
      child: AppEditorField(
        label: context.knobs.string(label: 'Label', initialValue: 'Название'),
        icon: context.knobs.object.dropdown<IconData>(
          label: 'Icon',
          options: [
            Icons.title_rounded,
            Icons.payments_rounded,
            Icons.bolt_rounded,
            Icons.description_rounded,
          ],
          initialOption: Icons.title_rounded,
        ),
        isNumber: context.knobs.boolean(label: 'Is Number', initialValue: false),
        maxLines: context.knobs.int.slider(
          label: 'Max Lines',
          initialValue: 1,
          min: 1,
          max: 5,
        ),
        fontSize: fontSize,
        iconSize: iconSize,
      ),
    ),
  );
}