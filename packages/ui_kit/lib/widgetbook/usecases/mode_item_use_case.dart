import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Default',
  type: ModeItem,
)
Widget mode(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 360,
      height: 100,
      child: ModeItem(
        title: 'Sprint',
        subtitle: 'Complete the challenge',
        icon: Icons.timer,
        color: Colors.blue,
        onTap: () {},
      ),
    ),
  );
}
