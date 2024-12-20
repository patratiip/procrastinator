import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/styles/text_field_theme.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/ui_kit/text/text_theme.dart';

/// {@template settings_screen}
/// [AppThemeData] class that holds theme settings
/// {@endtemplate}

abstract class AppThemeData {
  /// {@macro settings_screen}
  /// Dark theme
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    cardColor: MyAppColorScheme.secondaryBackgroundDark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: MyAppColorScheme.primary,
      brightness: Brightness.dark,
      secondary: MyAppColorScheme.secondary,
      surface: MyAppColorScheme.primaryBackgroundDark,
      onSurface: MyAppColorScheme.primaryTextDark,
      onTertiary: MyAppColorScheme.secondaryTextDark,
    ),

    // App Bar
    appBarTheme: const AppBarTheme(
      backgroundColor: MyAppColorScheme.primaryBackgroundDark,
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: MyAppColorScheme.primary,
      unselectedItemColor: MyAppColorScheme.secondaryText,
    ),

    // Elevated Button
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)))),
      backgroundColor: WidgetStatePropertyAll(MyAppColorScheme.primary),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
    )),

    // Text styles
    textTheme: MyTextTheme.textTheme,
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    cardColor: MyAppColorScheme.secondaryBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyAppColorScheme.primary,
      brightness: Brightness.light,
      secondary: MyAppColorScheme.secondary,
      surface: MyAppColorScheme.primaryBackground,
      onSurface: MyAppColorScheme.primaryText,
      onTertiary: MyAppColorScheme.secondaryText,
    ),

    // App Bar
    appBarTheme: const AppBarTheme(
      backgroundColor: MyAppColorScheme.primaryBackground,
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: MyAppColorScheme.primary,
        unselectedItemColor: MyAppColorScheme.secondaryText),

    // Elevated Button
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)))),
      backgroundColor: WidgetStatePropertyAll(MyAppColorScheme.primary),
    )),

    // Text styles
    textTheme: MyTextTheme.textTheme,
  );
}
