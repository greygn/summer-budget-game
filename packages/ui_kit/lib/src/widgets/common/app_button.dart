import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

enum ButtonVariant { primary, secondary }

enum ButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ButtonVariant style;
  final ButtonSize size;
  final bool isFullWidth;
  final AlignmentGeometry? alignment;

  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.style = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.isFullWidth = false,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final (height, iconSize, horizontalPadding, textStyle) = switch (size) {
      ButtonSize.small => (40.0, 18.0, 12.0, theme.textTheme.labelMedium),
      ButtonSize.medium => (48.0, 20.0, 20.0, theme.textTheme.labelLarge),
      ButtonSize.large => (56.0, 24.0, 24.0, theme.textTheme.titleMedium),
    };

    final buttonStyle = FilledButton.styleFrom(
      backgroundColor:
          style == ButtonVariant.primary ? theme.colorScheme.primary : null,
      foregroundColor:
          style == ButtonVariant.primary ? theme.colorScheme.onPrimary : null,
      textStyle: textStyle,
      minimumSize: Size(isFullWidth ? double.infinity : 0, height),
      alignment: alignment,
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: icon != null ? horizontalPadding : horizontalPadding + 8,
      ),
    );

    Widget button;
    switch (style) {
      case ButtonVariant.primary:
        if (icon != null) {
          button = FilledButton.icon(
            onPressed: onPressed,
            style: buttonStyle,
            icon: Icon(icon, size: iconSize),
            label: Text(label),
          );
        } else {
          button = FilledButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: Text(label),
          );
        }
        break;

      case ButtonVariant.secondary:
        if (icon != null) {
          button = FilledButton.tonalIcon(
            onPressed: onPressed,
            style: buttonStyle,
            icon: Icon(icon, size: iconSize),
            label: Text(label),
          );
        } else {
          button = FilledButton.tonal(
            onPressed: onPressed,
            style: buttonStyle,
            child: Text(label),
          );
        }
        break;
    }

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}

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
