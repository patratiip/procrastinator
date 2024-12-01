import 'package:flutter/material.dart';

/// {@template theme_settings_screen}
/// Widget that shows [BackAppbarArrow]for all AppBars's in the App
/// {@endtemplate}
class BackAppbarArrow extends StatelessWidget {
  /// {@macro theme_settings_screen}
  const BackAppbarArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_rounded, size: 28),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
