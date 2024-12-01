import 'package:flutter/material.dart';
import 'package:settings_repository/settings_repository.dart';

abstract class MyThemeTextField {
  static const textFieldInputBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1),
      borderRadius: BorderRadius.all(Radius.circular(12)));

// error
  static const errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: MyAppColorScheme.errorColor, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(12)));

  // focused
  static const focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: MyAppColorScheme.primary, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(12)));

  // focusedError
  static const focusedErrorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: MyAppColorScheme.primary, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(12)));

  // disabled
  static const disabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: MyAppColorScheme.primary, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(12)));

  // enabled
  static const enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(color: MyAppColorScheme.primary, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(12)));
}
