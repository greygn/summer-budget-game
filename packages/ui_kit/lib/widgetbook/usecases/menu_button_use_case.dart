import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Default',
  type: MenuButton,
)
Widget menuButton(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  return Center(
    child: SizedBox(
      width: 320,
      child: MenuButton(
        label: 'Continue',
        icon: Icons.play_arrow,
        onPressed: () {},
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
    ),
  );
}
