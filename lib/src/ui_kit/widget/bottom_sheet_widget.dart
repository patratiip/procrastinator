// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';

/// {@template bottom_sheet_widget}
/// Shows basic [BottomSheetWidget] with [child] in BottomScheet.
/// {@endtemplate}

class BottomSheetWidget extends StatelessWidget {
  final double? height;
  final Widget child;

  /// {@macro bottom_sheet_widget}
  const BottomSheetWidget({
    super.key,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      constraints: const BoxConstraints(maxWidth: 600),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12,
            left: 16,
            right: 16,
            bottom: 44,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  // Swiper
                  Container(
                    height: 5,
                    width: 60,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(8)),
                  ),

                  // Header
                  Text(
                    Localization.of(context).lectionInfoHeader,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Content
              child,
            ],
          ),
        ),
      ),
    );
  }
}
