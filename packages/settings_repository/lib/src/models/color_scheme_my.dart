import 'package:flutter/material.dart';

abstract class MyAppColorScheme {
  // Main Colors
  static const primary = Color(0xFF332BFA);
  static const secondary = Color(0xFF6FD06E);
  // Accent Colors
  static const primaryAccentColor = Color(0xFF7f7cdb);
  static const secondaryAccentColor = Color(0xFF85CD85);

  // Text Colors
  static const primaryText = Color(0xFF14181B);
  static const secondaryText = Color(0xFF677681);

  // Background Colors
  static const primaryBackground = Color(0xFFF2F2F2);
  static const secondaryBackground = Color(0xFFFFFFFF);

  // Reaction Colors
  static const errorColor = Color(0xFFf83b46);
  static const warningColor = Color(0xFFec9c4b);
  static const sucsessColor = Color(0xFF6bbd78);

  // DARK MODE

  // Text Colors
  static const primaryTextDark = Color(0xFFffffff);
  static const secondaryTextDark = Color(0xFFa5b0be);

  // Background Colors
  static const primaryBackgroundDark = Color(0xFF000000);
  static const secondaryBackgroundDark = Color(0xFF1a1f24);

  static of(BuildContext context) {}
}
