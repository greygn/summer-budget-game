import 'package:flutter/material.dart';
import '../../../ui_kit.dart';
import '../../adaptive/ui_radius.dart';
import '../../adaptive/ui_spacing.dart';

class EditorTile extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final String? tagName;
  final Color? tagColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double? padding;
  final double? margin;
  final TextStyle? titleStyle;

  const EditorTile({
    super.key,
    required this.title,
    this.subtitle,
    this.tagName,
    this.tagColor,
    this.trailing,
    this.onTap,
    this.padding,
    this.margin,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: margin ?? UiSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(UiRadius.largeIncreased),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: AppTheme.emphasisAlpha),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(UiRadius.largeIncreased),
          child: Padding(
            padding: EdgeInsets.all(padding ?? UiSpacing.lg),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: (titleStyle ??
                            theme.textTheme.titleMedium)
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                      if (tagName != null) ...[
                        const SizedBox(height: UiSpacing.xs),
                        AppTag(
                          label: tagName!,
                          color: tagColor,
                        ),
                      ],
                      if (subtitle != null) ...[
                        const SizedBox(height: UiSpacing.xs),
                        subtitle!,
                      ],
                    ],
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: UiSpacing.md),
                  trailing!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

