// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// {@template card_widget}
/// Shows [CardWidget].
/// {@endtemplate}

class CardWidget extends StatelessWidget {
  final bool tappable;
  final double? height;
  final VoidCallback? onTap;
  final Widget child;

  /// {@macro card_widget}
  const CardWidget({
    super.key,
    this.tappable = false,
    this.height,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return tappable
        ? _Tappable(
            onTap: onTap,
            height: height,
            child: child,
          )
        : _Normal(
            height: height,
            child: child,
          );
  }
}

class _Tappable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? height;
  const _Tappable({required this.child, this.onTap, this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap ?? () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                height: height ?? 80,
                constraints: const BoxConstraints(maxWidth: 600),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: child,
                ),
              ),
            ),
          )),
    );
  }
}

class _Normal extends StatelessWidget {
  final Widget child;
  final double? height;
  const _Normal({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 80,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: child,
      ),
    );
  }
}
