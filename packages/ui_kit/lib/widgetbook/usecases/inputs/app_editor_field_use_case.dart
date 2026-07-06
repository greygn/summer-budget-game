import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../widgets/inputs/app_editor_field.dart';

@widgetbook.UseCase(name: 'Default', type: AppEditorField)
Widget buildAppEditorFieldUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<AppEditorFieldSize>(
    label: 'Size',
    options: AppEditorFieldSize.values,
    initialOption: AppEditorFieldSize.medium,
    labelBuilder: (value) => value.name[0].toUpperCase() + value.name.substring(1),
  );

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
        size: size,
      ),
    ),
  );
}
