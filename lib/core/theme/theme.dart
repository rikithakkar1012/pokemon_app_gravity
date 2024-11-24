import 'package:flutter/material.dart';

import 'app_palette.dart';

class AppTheme {
  static final lightThemeMode = ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppPalette.backgroundColor,
      primaryColor: AppPalette.primary,
      primaryColorDark: AppPalette.primaryDark,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.primary,
        titleTextStyle: TextStyle(
          color: Colors.white, // Title text color for the AppBar
          fontSize: 20, // Adjust font size if needed
          fontWeight: FontWeight.bold, // Optional: make it bold
        ),
      ));
}
