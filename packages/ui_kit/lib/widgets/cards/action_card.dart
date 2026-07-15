import 'package:flutter/material.dart';
import 'package:ui_kit/adaptive/ui_radius.dart';
import 'package:ui_kit/adaptive/ui_spacing.dart';
import 'package:ui_kit/theme/app_theme.dart';

import '../../adaptive/adaptive_layout.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.tags = const [],
    this.onTap,
    this.isSelected = false,
  });

  final String title;
  final String? subtitle;

  final Widget? leading;
  final Widget? trailing;

  final List<Widget> tags;

  final VoidCallback? onTap;

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final layout = AdaptiveLayout.of(constraints);
        // ... (existing layout logic)
        final padding = layout.value(
          compact: EdgeInsets.all(UiSpacing.md),
          medium: EdgeInsets.all(UiSpacing.lg),
          expanded: EdgeInsets.all(UiSpacing.xl),
          large: EdgeInsets.all(UiSpacing.xxl),
        );

        final innerGap = layout.value(
          compact: UiSpacing.md,
          medium: UiSpacing.lg,
          expanded: UiSpacing.lg,
          large: UiSpacing.xl,
        );

        final subtitleGap = layout.value(
          compact: UiSpacing.xs,
          medium: UiSpacing.sm,
          expanded: UiSpacing.sm,
          large: UiSpacing.md,
        );

        final tagsGap = layout.value(
          compact: UiSpacing.md,
          medium: UiSpacing.md,
          expanded: UiSpacing.lg,
          large: UiSpacing.xl,
        );

        final titleStyle = theme.textTheme.titleMedium?.copyWith(
          fontSize: layout.titleTextSize,
          fontWeight: isSelected ? FontWeight.bold : null,
          color: isSelected ? colorScheme.primary : null,
        );

        return Container(
          decoration: BoxDecoration(
            color: isSelected 
                ? colorScheme.primary.withValues(alpha: 0.05)
                : colorScheme.surface,
            borderRadius: BorderRadius.circular(UiRadius.extraLarge),
            border: Border.all(
              color: isSelected 
                  ? colorScheme.primary 
                  : colorScheme.outlineVariant.withValues(alpha: AppTheme.emphasisAlpha),
              width: isSelected ? 2.0 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : colorScheme.shadow.withValues(alpha: AppTheme.surfaceAlpha),
                blurRadius: isSelected ? 16 : 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(UiRadius.extraLarge),
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
