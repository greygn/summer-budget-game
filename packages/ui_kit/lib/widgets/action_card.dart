import 'package:flutter/material.dart';
import 'package:ui_kit/adaptive/ui_widths.dart';
import 'package:ui_kit/adaptive/ui_spacing.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.tags = const [],
    this.onTap,
  });

  final String title;
  final String? subtitle;

  final Widget? leading;
  final Widget? trailing;

  final List<Widget> tags;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final isCompact = width < UiWidths.compact;
        final isMedium =
            width >= UiWidths.compact && width < UiWidths.medium;
        final isExpanded =
            width >= UiWidths.medium && width < UiWidths.expanded;
        final isLarge = width >= UiWidths.expanded;

        final padding = switch (true) {
          _ when isCompact => EdgeInsets.all(UiSpacing.lg),
          _ when isMedium => EdgeInsets.all(UiSpacing.xl),
          _ when isExpanded => EdgeInsets.all(24),
          _ when isLarge => EdgeInsets.all(28),
          _ => EdgeInsets.all(UiSpacing.xl),
        };

        final innerGap = switch (true) {
          _ when isCompact => UiSpacing.md,
          _ when isMedium => UiSpacing.lg,
          _ when isExpanded => UiSpacing.lg,
          _ when isLarge => UiSpacing.xl,
          _ => UiSpacing.lg,
        };

        final subtitleGap = switch (true) {
          _ when isCompact => UiSpacing.xs,
          _ when isMedium => UiSpacing.sm,
          _ when isExpanded => UiSpacing.sm,
          _ when isLarge => UiSpacing.md,
          _ => UiSpacing.sm,
        };

        final tagsGap = switch (true) {
          _ when isCompact => UiSpacing.md,
          _ when isMedium => UiSpacing.md,
          _ when isExpanded => UiSpacing.lg,
          _ when isLarge => UiSpacing.xl,
          _ => UiSpacing.lg,
        };

        final titleStyle = theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w900,
          fontSize: isCompact ? 15 : isLarge ? 18 : null,
        );

        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: colorScheme.outlineVariant.withAlpha(120),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withAlpha(15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(28),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: padding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (leading != null) ...[
                          leading!,
                          SizedBox(width: innerGap),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: titleStyle),
                              if (subtitle != null) ...[
                                SizedBox(height: subtitleGap),
                                Text(
                                  subtitle!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        if (trailing != null) ...[
                          SizedBox(width: innerGap),
                          trailing!,
                        ],
                      ],
                    ),
                    if (tags.isNotEmpty) ...[
                      SizedBox(height: tagsGap),
                      Wrap(
                        spacing: UiSpacing.sm,
                        runSpacing: UiSpacing.sm,
                        children: tags,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
