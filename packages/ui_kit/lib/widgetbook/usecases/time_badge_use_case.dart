import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../widgets/common/time_badge.dart';

@widgetbook.UseCase(name: 'Large (Low Time)', type: UITimeBadge)
Widget buildUITimeBadgeLargeLowUseCase(BuildContext context) {
  return const Center(child: UITimeBadge(time: 2, isLarge: true));
}

@widgetbook.UseCase(name: 'Small', type: UITimeBadge)
Widget buildUITimeBadgeSmallUseCase(BuildContext context) {
  return const Center(child: UITimeBadge(time: 12, isLarge: false));
}