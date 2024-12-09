import 'package:flutter/material.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

/// {@template my_circular_progress}
/// Description [MyCircularProgress].
/// {@endtemplate}
/// {@macro my_circular_progress}
class MyCircularProgress extends StatelessWidget {
  final double? size;
  const MyCircularProgress({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size ?? 40,
        width: size ?? 40,
        child: const CircularProgressIndicator(
          color: MyAppColorScheme.primary,
        ),
      ),
    );
  }
}
