import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF0052FF); // Electric Blue
  static const Color background = Color(0xFFF8F9FC); // Crisp Background
  static const Color darkNeutral = Color(0xFF0F172A); // Slate-900 (crisp dark neutral)
  static const Color textSecondary = Color(0xFF475569); // Slate-600

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        primaryContainer: primaryColor,
        onPrimaryContainer: Colors.white,
        secondary: Color(0xFF505F76),
        onSecondary: Colors.white,
        surface: background,
        onSurface: darkNeutral,
        surfaceContainerHighest: Color(0xFFEAEDFF),
        onSurfaceVariant: textSecondary,
        outline: Color(0xFF737688),
        outlineVariant: Color(0xFFC3C5D9),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: darkNeutral,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: darkNeutral,
        ),
      ),
    );
  }
}
