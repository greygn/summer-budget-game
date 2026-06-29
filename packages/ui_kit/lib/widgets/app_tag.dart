import 'package:flutter/material.dart';

class AppTag extends StatelessWidget {
  const AppTag({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.backgroundColor,
    this.onTap,
  });

  final String label;
  final IconData? icon;

  final Color? color;
  final Color? backgroundColor;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final foreground = color ?? colorScheme.primary;

    final background =
        backgroundColor ?? foreground.withAlpha(35);

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: 16,
            color: foreground,
          ),
          const SizedBox(width: 8),
        ],
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );

    content = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: content,
    );

    if (onTap != null) {
      content = InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: content,
      );
    }

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(14),
      child: content,
    );
  }
}
