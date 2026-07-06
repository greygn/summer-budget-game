import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../widgets/common/app_button.dart';

@widgetbook.UseCase(name: 'Button', type: AppButton)
Widget buildAppButtonUseCase(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'ДЕЙСТВИЯ',
  );

  final variant = context.knobs.object.dropdown<ButtonVariant>(
    label: 'Variant',
    options: ButtonVariant.values,
    initialOption: ButtonVariant.primary,
  );

  final size = context.knobs.object.dropdown<ButtonSize>(
    label: 'Size',
    options: ButtonSize.values,
    initialOption: ButtonSize.medium,
  );

  final hasIcon = context.knobs.boolean(
    label: 'Icon',
    initialValue: true,
  );

  final isFullWidth = context.knobs.boolean(
    label: 'Full Width',
    initialValue: false,
  );

  final enabled = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppButton(
        label: label,
        icon: hasIcon ? Icons.bolt_rounded : null,
        onPressed: enabled ? () {} : null,
        style: variant,
        size: size,
        isFullWidth: isFullWidth,
        alignment: isFullWidth ? Alignment.centerLeft : null,
      ),
    ),
  );
}