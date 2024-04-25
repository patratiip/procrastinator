import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_scheme_my.dart';

abstract class MyAppThemeDark {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    cardColor: MyAppColorScheme.secondaryBackgroundDark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MyAppColorScheme.primary,
      brightness: Brightness.dark,
      background: MyAppColorScheme.primaryBackgroundDark,
      secondary: MyAppColorScheme.secondary,
      surface: MyAppColorScheme.secondaryBackgroundDark,
    ),
//App Bar
    appBarTheme: const AppBarTheme(
      backgroundColor: MyAppColorScheme.primaryBackgroundDark,
      // actionsIconTheme: IconThemeData(color: MyAppColorScheme.primaryTextDark),
      // iconTheme: IconThemeData(color: MyAppColorScheme.primaryTextDark),
    ),

    //BOTTOM Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.shifting,
      // backgroundColor: MyAppColorScheme.secondaryBackgroundDark,
      selectedItemColor: MyAppColorScheme.primary,
      unselectedItemColor: MyAppColorScheme.secondaryText,
    ),

    /////////OTHER
    // scaffoldBackgroundColor: MyAppColorScheme.primaryBackgroundDark,
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
}
