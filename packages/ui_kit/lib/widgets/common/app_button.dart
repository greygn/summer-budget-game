import 'package:flutter/material.dart';
import '../../adaptive/ui_radius.dart';
import '../../adaptive/ui_spacing.dart';
import '../../adaptive/ui_icon_sizes.dart';

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
      ButtonSize.small => (UiSpacing.sm * 5, UiIconSizes.expanded, UiSpacing.md, theme.textTheme.labelMedium),
      ButtonSize.medium => (UiSpacing.sm * 6, UiIconSizes.large, UiSpacing.xl, theme.textTheme.labelLarge),
      ButtonSize.large => (UiSpacing.sm * 7, UiSpacing.xl, UiSpacing.xl, theme.textTheme.titleMedium),
    };

    final buttonStyle = FilledButton.styleFrom(
      backgroundColor:
          style == ButtonVariant.primary ? theme.colorScheme.primary : null,
      foregroundColor:
          style == ButtonVariant.primary ? theme.colorScheme.onPrimary : null,
      textStyle: textStyle,
      minimumSize: Size(isFullWidth ? double.infinity : 0, height),
      alignment: alignment,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UiRadius.largeIncreased),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 0,
        horizontal: icon != null ? horizontalPadding : horizontalPadding + UiSpacing.sm,
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
