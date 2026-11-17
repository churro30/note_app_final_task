import 'package:flutter/material.dart';

class ThemeColors {
  static Color primaryColor = Color(0xFFEAE2D6);
  static Color secondaryColor = Color(0xFFEAE2D6);
  static Color accentColor = Color(0xFFB7C7A9);
  static Color textColor = Color(0xFF18181B);
}

ThemeData primaryTheme = ThemeData(
  fontFamily: 'ShantellSans',
  // Seed Color
  colorScheme: ColorScheme.fromSeed(seedColor: ThemeColors.primaryColor),
  scaffoldBackgroundColor: ThemeColors.primaryColor,

  // App Bar Theme
  appBarTheme: AppBarThemeData(backgroundColor: ThemeColors.secondaryColor),
  // Bottom Navigation Theme
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: ThemeColors.secondaryColor,
    selectedItemColor: ThemeColors.accentColor,
    selectedIconTheme: IconThemeData(color: ThemeColors.accentColor),
    selectedLabelStyle: TextStyle(
      color: ThemeColors.accentColor,
      fontWeight: FontWeight.bold,
    ),
    unselectedItemColor: ThemeColors.textColor,
    unselectedLabelStyle: TextStyle(
      color: ThemeColors.accentColor,
      fontWeight: FontWeight.bold,
    ),
  ),

  // Text Theme
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: ThemeColors.textColor,
      fontSize: 14,
      letterSpacing: 1,
      fontFamily: 'ShantellSans',
    ),

    headlineMedium: TextStyle(
      color: ThemeColors.textColor,
      fontSize: 22,
      letterSpacing: 1,
      fontWeight: FontWeight.bold,
      fontFamily: 'ShantellSans',
    ),

    titleMedium: TextStyle(
      color: ThemeColors.accentColor,
      fontSize: 25,
      letterSpacing: 1,
      fontWeight: FontWeight.bold,
      fontFamily: 'ShantellSans',
    ),
  ),

  // Filled Button
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: ThemeColors.accentColor,
      foregroundColor: ThemeColors.primaryColor,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: FilledButton.styleFrom(
      foregroundColor: ThemeColors.primaryColor,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  // Side Drawer
  drawerTheme: DrawerThemeData(backgroundColor: ThemeColors.primaryColor),

  // Form Field
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: ThemeColors.accentColor.withValues(alpha: 0.5),
    contentPadding: EdgeInsets.all(16),
    errorStyle: TextStyle(color: ThemeColors.textColor),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Radio Theme
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.selected) ? ThemeColors.textColor : null,
    ),
  ),
);
