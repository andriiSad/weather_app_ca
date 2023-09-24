import 'package:flutter/material.dart';
import 'package:weather_app_ca/core/res/fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: Fonts.aeonik,
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: Colors.blue,
    ),
    useMaterial3: true,
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      titleLarge: TextStyle(
        fontSize: 28,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlue,
      elevation: 1,
    ),
  );
  static ThemeData darkTheme = lightTheme.copyWith(
    brightness: Brightness.dark,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blueGrey,
      elevation: 1,
    ),
  );
}
