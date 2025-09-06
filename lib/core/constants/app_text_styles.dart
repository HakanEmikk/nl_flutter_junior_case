import 'package:flutter/material.dart';

class AppTextStyles {
  // FONT FAMILY
  static const String _fontFamily = 'InstrumentSans';

  // Light TextTheme
  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      // Heading1 - 48px
      fontFamily: _fontFamily,
      fontSize: 48,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      // Heading2 - 40px
      fontFamily: _fontFamily,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      // Heading3 - 32px
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      // Heading4 - 24px
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      // Heading5 - 20px
      fontFamily: _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      // Heading6 - 18px
      fontFamily: _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    bodySmall: TextStyle(
      // BodyXSmall - 10px
      fontFamily: _fontFamily,
      fontSize: 10,
    ),
    bodyMedium: TextStyle(
      // BodyNormal - 14px
      fontFamily: _fontFamily,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      // BodyLarge - 16px
      fontFamily: _fontFamily,
      fontSize: 16,
    ),
    titleMedium: TextStyle(
      // BodyXLarge - 18px
      fontFamily: _fontFamily,
      fontSize: 18,
    ),
    titleSmall: TextStyle(
      // BodySmall - 12px
      fontFamily: _fontFamily,
      fontSize: 12,
    ),
  );

  // Dark TextTheme
  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
    bodyMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
    bodyLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
    titleMedium: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
    titleSmall: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
    labelLarge: TextStyle(
      fontFamily: _fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );
}
