import 'package:flutter/material.dart';

class AppTheme {
  static const _seedColor = Colors.deepPurple;

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
      ),

      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: colorScheme.surfaceContainerLow,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(20),
      ),

      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
