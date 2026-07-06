import 'package:flutter/material.dart';
import 'package:ui_kit/theme/app_theme.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../widgetbook/main.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: AppTheme.light,
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: AppTheme.dark,
            ),
          ],
        ),
      ],
    );
  }
}
