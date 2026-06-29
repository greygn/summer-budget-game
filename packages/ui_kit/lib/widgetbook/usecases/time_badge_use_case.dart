import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Small',
  type: TimeBadge,
)
Widget smallBadge(BuildContext context) {
  return const Center(
    child: TimeBadge(
      duration: Duration(hours: 2),
    ),
  );
}

@UseCase(
  name: 'Medium',
  type: TimeBadge,
)
Widget mediumBadge(BuildContext context) {
  return const Center(
    child: TimeBadge(
      duration: Duration(hours: 6),
      size: AppBadgeSize.medium,
    ),
  );
}

@UseCase(
  name: 'Large',
  type: TimeBadge,
)
Widget largeBadge(BuildContext context) {
  return const Center(
    child: TimeBadge(
      duration: Duration(hours: 10),
      size: AppBadgeSize.large,
    ),
  );
}
