import 'package:flutter/material.dart';

class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
      ),
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
          primary: Colors.blue, background: Colors.white),
    ),
    AppTheme.darkTheme: ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
      ),
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
          primary: Colors.teal, background: Colors.black),
    )
  };
}

enum AppTheme { lightTheme, darkTheme, systemTheme }
