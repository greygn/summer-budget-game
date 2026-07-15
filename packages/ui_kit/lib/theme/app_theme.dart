import 'package:flutter/material.dart';

import '../adaptive/ui_radius.dart';
import '../adaptive/ui_spacing.dart';
import '../adaptive/ui_text_sizes.dart';

class AppTheme {
  static const _seedColor = Colors.deepPurple;

  static const double surfaceAlpha = 0.1;
  static const double strokeAlpha = 0.2;
  static const double inputAlpha = 0.3;
  static const double emphasisAlpha = 0.5;
  static const double lineHeightDefault = 1.5;

  static ThemeData get light => _buildTheme(Brightness.light);
  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,

      textTheme: const TextTheme(
        displaySmall: TextStyle(fontWeight: FontWeight.w900),
        headlineMedium: TextStyle(fontWeight: FontWeight.w800),
        titleLarge: TextStyle(fontWeight: FontWeight.w700),
        titleMedium: TextStyle(fontWeight: FontWeight.w900),
        labelMedium: TextStyle(fontWeight: FontWeight.w700),
        bodySmall: TextStyle(fontWeight: FontWeight.w800),
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(UiRadius.largeIncreased)),
        color: colorScheme.surfaceContainerLow,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: inputAlpha),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(UiRadius.largeIncreased),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(UiSpacing.xl),
      ),

      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: UiTextSizes.titleLarge,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
