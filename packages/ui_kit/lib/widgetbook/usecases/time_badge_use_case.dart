import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Adaptive',
  type: TimeBadge,
)
Widget adaptiveTimeBadge(BuildContext context) {
  final screenSize = context.knobs.object.dropdown<String>(
    label: 'Screen size',
    options: const [
      'compact',
      'medium',
      'expanded',
      'large',
      'custom',
    ],
    initialOption: 'compact',
  );

  final width = switch (screenSize) {
    'compact' => 320.0,
    'medium' => 700.0,
    'expanded' => 960.0,
    'large' => 1320.0,
    _ => context.knobs.double.slider(
      label: 'Width',
      initialValue: 200,
      min: 120,
      max: 1600,
      divisions: 74,
    ),
  };

  final hours = context.knobs.double.slider(
    label: 'Hours',
    initialValue: 2,
    min: 1,
    max: 24,
    divisions: 23,
  ).toInt();

  final badgeSize = context.knobs.object.dropdown<AppBadgeSize>(
    label: 'Badge size',
    options: const [
      AppBadgeSize.small,
      AppBadgeSize.medium,
      AppBadgeSize.large,
    ],
    initialOption: AppBadgeSize.small,
  );

  return Center(
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: width,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: TimeBadge(
        duration: Duration(hours: hours),
        size: badgeSize,
      ),
    ),
  );
}
