import 'package:flutter/material.dart';

import '../color_scheme_my.dart';

abstract class MyAppThemeLight {
  static final themeLight = ThemeData(
    useMaterial3: true,
    cardColor: MyAppColorScheme.secondaryBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyAppColorScheme.primary,
      brightness: Brightness.light,
      // background: MyAppColorScheme.primaryBackground,
      secondary: MyAppColorScheme.secondary,
      // surface: MyAppColorScheme.secondaryBackground,
      surface: MyAppColorScheme.primaryBackground,
    ),

// colorScheme: ColorScheme(brightness: Brightness.light, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, background: background, onBackground: onBackground, surface: surface, onSurface: onSurface)

    //App Bar
    appBarTheme: const AppBarTheme(
      // surfaceTintColor: MyAppColorScheme.secondaryBackground,
      backgroundColor: MyAppColorScheme.primaryBackground,
    ),

    //BOTTOM Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        // backgroundColor: MyAppColorScheme.secondaryBackground,
        selectedItemColor: MyAppColorScheme.primary,
        unselectedItemColor: MyAppColorScheme.secondaryText),

    /////////OTHER
    // scaffoldBackgroundColor: MyAppColorScheme.primaryBackground,
    // primaryColor: MyAppColorScheme.primary,

    ////////BUTTONS
    ////Elevated Button
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)))),
      // shape: MaterialStatePropertyAll(RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //   topLeft: Radius.circular(0),
      //   topRight: Radius.circular(0),
      //   bottomLeft: Radius.circular(8),
      //   bottomRight: Radius.circular(8),
      // ))),

      //maximumSize: MaterialStatePropertyAll(Size(600, 100)),
      backgroundColor: MaterialStatePropertyAll(MyAppColorScheme.primary),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      // overlayColor: MaterialStatePropertyAll(MyAppColorScheme.primary),
      //surfaceTintColor: MaterialStatePropertyAll(MyAppColorScheme.),
    )),

    ////Text Button
    //

    ////////TEXT
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
