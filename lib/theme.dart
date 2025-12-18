import 'package:flutter/material.dart';

class AppTheme {
  static const Color teal = Color(0xFF31E1C9);
  static const Color darkBg = Color(0xFF071021);
  static const Color cardBg = Color(0xFF0D1B2A);
  static const Color codeBg = Color(0xFF061226);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBg,
    primaryColor: teal,
    colorScheme: const ColorScheme.dark(primary: teal),
    canvasColor: darkBg,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white70),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: teal,
    colorScheme: const ColorScheme.light(primary: teal),
    canvasColor: Colors.white,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Colors.black87),
      bodyLarge: TextStyle(color: Colors.black87),
    ),
  );
}
