import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import '../../adaptive/ui_heights.dart';
import '../../adaptive/ui_icon_sizes.dart';
import '../../adaptive/ui_spacing.dart';

class ExpressiveStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final double? height;
  final double? iconSize;
  final double? padding;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const ExpressiveStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.height,
    this.iconSize,
    this.padding,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final shape = theme.cardTheme.shape;
    final themeRadius = shape is RoundedRectangleBorder && shape.borderRadius is BorderRadius
        ? shape.borderRadius as BorderRadius
        : BorderRadius.circular(24);

    return Container(
      width: double.infinity,
      height: height ?? UiHeights.medium,
      padding: EdgeInsets.all(padding ?? UiSpacing.lg),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? theme.colorScheme.surface,
        borderRadius: themeRadius,
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: themeRadius * 0.5,
            ),
            child: Icon(icon, size: iconSize ?? 24, color: color),
          ),
          const Spacer(),
          Text(
            label,
            style: (labelStyle ?? theme.textTheme.labelLarge)?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            value,
            style: (valueStyle ?? theme.textTheme.headlineSmall)?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Happiness', type: ExpressiveStatCard)
Widget buildExpressiveStatCardUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (height, iconSize, padding, width, labelStyle, valueStyle) = switch (size) {
    'Compact' => (
        UiHeights.compact,
        18.0,
        UiSpacing.md,
        140.0,
        theme.textTheme.labelSmall,
        theme.textTheme.titleMedium
      ),
    'Medium' => (
        UiHeights.medium,
        24.0,
        UiSpacing.lg,
        160.0,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall
      ),
    'Expanded' => (
        UiHeights.expanded,
        28.0,
        UiSpacing.xl,
        180.0,
        theme.textTheme.titleSmall,
        theme.textTheme.headlineMedium
      ),
    'Large' => (
        UiHeights.large,
        32.0,
        UiSpacing.xl,
        200.0,
        theme.textTheme.titleMedium,
        theme.textTheme.headlineLarge
      ),
    _ => (
        UiHeights.medium,
        24.0,
        UiSpacing.lg,
        160.0,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall
      ),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: SizedBox(
        width: width,
        child: ExpressiveStatCard(
          label: "Счастье",
          value: "85%",
          icon: Icons.face_retouching_natural_rounded,
          color: Colors.orange,
          height: height,
          iconSize: iconSize,
          padding: padding,
          labelStyle: labelStyle,
          valueStyle: valueStyle,
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Energy', type: ExpressiveStatCard)
Widget buildExpressiveStatEnergyUseCase(BuildContext context) {
  final size = context.knobs.object.dropdown<String>(
    label: 'Size',
    options: ['Compact', 'Medium', 'Expanded', 'Large'],
    initialOption: 'Medium',
  );

  final theme = Theme.of(context);
  final (height, iconSize, padding, width, labelStyle, valueStyle) = switch (size) {
    'Compact' => (
        UiHeights.compact,
        18.0,
        UiSpacing.md,
        140.0,
        theme.textTheme.labelSmall,
        theme.textTheme.titleMedium
      ),
    'Medium' => (
        UiHeights.medium,
        24.0,
        UiSpacing.lg,
        160.0,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall
      ),
    'Expanded' => (
        UiHeights.expanded,
        28.0,
        UiSpacing.xl,
        180.0,
        theme.textTheme.titleSmall,
        theme.textTheme.headlineMedium
      ),
    'Large' => (
        UiHeights.large,
        32.0,
        UiSpacing.xl,
        200.0,
        theme.textTheme.titleMedium,
        theme.textTheme.headlineLarge
      ),
    _ => (
        UiHeights.medium,
        24.0,
        UiSpacing.lg,
        160.0,
        theme.textTheme.labelLarge,
        theme.textTheme.headlineSmall
      ),
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: SizedBox(
        width: width,
        child: ExpressiveStatCard(
          label: "Энергия",
          value: "40%",
          icon: Icons.bolt_rounded,
          color: Colors.amber,
          height: height,
          iconSize: iconSize,
          padding: padding,
          labelStyle: labelStyle,
          valueStyle: valueStyle,
        ),
      ),
    ),
  );
}
