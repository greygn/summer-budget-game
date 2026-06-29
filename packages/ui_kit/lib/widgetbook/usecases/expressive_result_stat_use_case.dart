import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Default',
  type: ExpressiveResultStat,
)
Widget stat(BuildContext context) {
  return const Center(
    child: ExpressiveResultStat(
      label: 'Completed',
      value: '42',
      icon: Icons.check_circle,
      color: Colors.green,
    ),
  );
}
