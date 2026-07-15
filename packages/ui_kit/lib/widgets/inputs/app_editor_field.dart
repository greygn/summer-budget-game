import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../adaptive/ui_icon_sizes.dart';
import '../../adaptive/ui_spacing.dart';
import '../../adaptive/ui_text_sizes.dart';

enum AppEditorFieldSize { compact, medium, expanded, large }

class AppEditorField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData? icon;
  final bool isNumber;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final String? initialValue;
  final double? fontSize;
  final double? iconSize;
  final AppEditorFieldSize size;

  const AppEditorField({
    super.key,
    this.controller,
    required this.label,
    this.icon,
    this.isNumber = false,
    this.maxLines = 1,
    this.onChanged,
    this.initialValue,
    this.fontSize,
    this.iconSize,
    this.size = AppEditorFieldSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseTextStyle = theme.textTheme.bodyLarge;

    final (effectiveFontSize, effectiveIconSize) = switch (size) {
      AppEditorFieldSize.compact => (UiTextSizes.bodyMedium, UiIconSizes.large),
      AppEditorFieldSize.medium => (UiTextSizes.bodyLarge, UiSpacing.xl),
      AppEditorFieldSize.expanded => (UiIconSizes.expanded, UiSpacing.xl),
      AppEditorFieldSize.large => (UiIconSizes.large, UiTextSizes.headlineMedium),
    };

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      style: baseTextStyle?.copyWith(fontSize: fontSize ?? effectiveFontSize),
      keyboardType: isNumber
          ? const TextInputType.numberWithOptions(
        signed: true,
        decimal: false,
      )
          : TextInputType.text,
      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9-]'))]
          : null,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: fontSize ?? effectiveFontSize),
        prefixIcon: icon != null ? Icon(icon, size: iconSize ?? effectiveIconSize) : null,
      ),
    );
  }
}
