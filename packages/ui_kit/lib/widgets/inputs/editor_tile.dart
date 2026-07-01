import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../../ui_kit.dart';
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
  final double? tagFontSize;
  final EdgeInsetsGeometry? tagPadding;

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
    this.tagFontSize,
    this.tagPadding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: margin ?? UiSpacing.md),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
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
                        style: (titleStyle ?? theme.textTheme.titleMedium)?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (tagName != null) ...[
                        const SizedBox(height: UiSpacing.xs),
                        AppTag(
                          label: tagName!,
                          color: tagColor ?? theme.colorScheme.primary,
                          fontSize: tagFontSize,
                          padding: tagPadding,
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

@widgetbook.UseCase(name: 'Default', type: EditorTile)
Widget buildEditorTileUseCase(BuildContext context) {
  final showTag = context.knobs.boolean(label: 'Show Tag', initialValue: true);
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (padding, margin, titleStyle, tagFontSize, tagPadding, maxWidth) = switch (size) {
    'Compact' => (
        UiSpacing.md, 
        UiSpacing.sm, 
        theme.textTheme.titleSmall,
        9.0,
        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        340.0
      ),
    'Medium' => (
        UiSpacing.lg, 
        UiSpacing.md, 
        theme.textTheme.titleMedium,
        11.0,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        400.0
      ),
    'Expanded' => (
        UiSpacing.xl, 
        UiSpacing.lg, 
        theme.textTheme.titleLarge,
        12.0,
        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        460.0
      ),
    'Large' => (
        UiSpacing.xl, 
        UiSpacing.lg, 
        theme.textTheme.headlineSmall,
        14.0,
        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        520.0
      ),
    _ => (
        UiSpacing.lg, 
        UiSpacing.md, 
        theme.textTheme.titleMedium,
        11.0,
        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        400.0
      ),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: EditorTile(
          title: context.knobs.string(label: 'Title', initialValue: 'Купить кофе'),
          tagName: showTag
              ? context.knobs.string(label: 'Tag Name', initialValue: 'BASIC')
              : null,
          tagColor: showTag
              ? context.knobs.color(label: 'Tag Color', initialValue: Colors.blue)
              : null,
          subtitle: Text(
            context.knobs.string(label: 'Subtitle Text', initialValue: '-150 ₽ | Счастье: +5'),
            style: Theme.of(context).textTheme.labelMedium,
          ),
          trailing: context.knobs.boolean(label: 'Show Delete Icon', initialValue: true)
              ? IconButton(
                  icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
                  onPressed: () {},
                )
              : null,
          onTap: () {},
          padding: padding,
          margin: margin,
          titleStyle: titleStyle,
          tagFontSize: tagFontSize,
          tagPadding: tagPadding,
        ),
      ),
    ),
  );
}
