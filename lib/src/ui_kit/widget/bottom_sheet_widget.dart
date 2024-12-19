// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

/// {@template bottom_sheet_widget}
/// Shows basic [BottomSheetWidget] with [child] in BottomScheet.
/// {@endtemplate}

class BottomSheetWidget extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsets padding;
  final double cornerRadius;
  final bool closable;

  /// {@macro bottom_sheet_widget}
  const BottomSheetWidget({
    super.key,
    required this.child,
    this.padding =
        const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 44),
    this.cornerRadius = 20.0,
    this.height,
    this.closable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Placeholder
                  const SizedBox(height: 26, width: 26),
                  // Swiper
                  closable
                      ? const SizedBox(height: 5, width: 60)
                      : Container(
                          height: 5,
                          width: 60,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onTertiary,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                  // Closer
                  closable
                      ? GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 26,
                            width: 26,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onTertiary,
                                borderRadius: BorderRadius.circular(20)),
                            child: Icon(
                              Icons.close_rounded,
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        )
                      : const SizedBox(height: 26, width: 26),
                ],
              ),

              // Content
              child,
            ],
          ),
        ),
      ),
    );
  }
}
