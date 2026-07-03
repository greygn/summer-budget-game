import 'package:flutter/material.dart';

import 'ui_heights.dart';
import 'ui_icon_sizes.dart';
import 'ui_spacing.dart';
import 'ui_widths.dart';

enum AdaptiveSize {
  compact,
  medium,
  expanded,
  large,
}

class AdaptiveLayout {
  const AdaptiveLayout._(this.width);

  factory AdaptiveLayout.of(BoxConstraints constraints) {
    return AdaptiveLayout._(constraints.maxWidth);
  }

  final double width;

  AdaptiveSize get size {
    if (width < UiWidths.compact) {
      return AdaptiveSize.compact;
    }

    if (width < UiWidths.medium) {
      return AdaptiveSize.medium;
    }

    if (width < UiWidths.expanded) {
      return AdaptiveSize.expanded;
    }

    return AdaptiveSize.large;
  }

  bool get isCompact => size == AdaptiveSize.compact;
  bool get isMedium => size == AdaptiveSize.medium;
  bool get isExpanded => size == AdaptiveSize.expanded;
  bool get isLarge => size == AdaptiveSize.large;

  T value<T>({
    required T compact,
    required T medium,
    required T expanded,
    required T large,
  }) {
    switch (size) {
      case AdaptiveSize.compact:
        return compact;
      case AdaptiveSize.medium:
        return medium;
      case AdaptiveSize.expanded:
        return expanded;
      case AdaptiveSize.large:
        return large;
    }
  }

  double get cardHeight => value(
    compact: UiHeights.compact,
    medium: UiHeights.medium,
    expanded: UiHeights.expanded,
    large: UiHeights.large,
  );

  double get iconSize => value(
    compact: UiIconSizes.compact,
    medium: UiIconSizes.medium,
    expanded: UiIconSizes.expanded,
    large: UiIconSizes.large,
  );

  double get padding => value(
    compact: UiSpacing.md,
    medium: UiSpacing.lg,
    expanded: UiSpacing.xl,
    large: UiSpacing.xxl,
  );
}
