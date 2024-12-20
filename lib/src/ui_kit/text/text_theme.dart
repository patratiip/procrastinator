import 'package:flutter/material.dart';

abstract class MyTextTheme {
  // Text styles
  static const textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 64, fontWeight: FontWeight.w400),
    displayMedium: TextStyle(fontSize: 44, fontWeight: FontWeight.w400),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
    //
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
    //
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    //
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    //
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  );
}
