import 'package:flutter/material.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

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
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.w400,
        color: MyAppColorScheme.primaryTextDark,
      ),
      displayMedium: TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.w400,
        color: MyAppColorScheme.primaryTextDark,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: MyAppColorScheme.primaryTextDark,
      ),
      //
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: MyAppColorScheme.primaryTextDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: MyAppColorScheme.primaryTextDark,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: MyAppColorScheme.primaryTextDark,
      ),
      //
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: MyAppColorScheme.primaryTextDark,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: MyAppColorScheme.primaryTextDark,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: MyAppColorScheme.primaryTextDark,
      ),
      //
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyAppColorScheme.primaryTextDark,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: MyAppColorScheme.primaryTextDark,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: MyAppColorScheme.primaryTextDark,
      ),
      //
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: MyAppColorScheme.primaryTextDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: MyAppColorScheme.primaryTextDark,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: MyAppColorScheme.primaryTextDark,
      ),
    ),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    cardColor: MyAppColorScheme.secondaryBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyAppColorScheme.primary,
      brightness: Brightness.light,
      secondary: MyAppColorScheme.secondary,
      surface: MyAppColorScheme.primaryBackground,
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
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 64, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(fontSize: 44, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
      //
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
      //
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      //
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      //
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    ),
  );
}
