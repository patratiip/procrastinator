import 'package:flutter/material.dart';

class ScrollControllerProvider extends InheritedWidget {
  final ScrollController scrollController;

  const ScrollControllerProvider({
    super.key,
    required this.scrollController,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant ScrollControllerProvider oldWidget) {
    return oldWidget.scrollController != scrollController;
  }

  // Convenient method for accessing ScrollController
  static ScrollController of(BuildContext context) {
    final ScrollControllerProvider? result =
        context.dependOnInheritedWidgetOfExactType<ScrollControllerProvider>();
    assert(result != null, 'No ScrollControllerProvider found in context');
    return result!.scrollController;
  }
}
