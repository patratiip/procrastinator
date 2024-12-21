import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/features/student_app/features/forgotten_entries/model/forgotten_request.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';
import 'package:procrastinator/src/ui_kit/widget/card_widget.dart';

/// {@template forgotten_entry_request_widget}
/// Shows [ForgottenEntryWidget].
/// {@endtemplate}

class ForgottenEntryWidget extends StatelessWidget {
  final double? height;
  final ForgottenRequestStudent request;
  final bool tappable;
  final VoidCallback? onTap;

  /// {@macro forgotten_entry_request_widget}
  const ForgottenEntryWidget({
    super.key,
    required this.request,
    this.height,
    this.tappable = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yy');

    return CardWidget(
      tappable: tappable,
      onTap: onTap,
      height: height ?? 80,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Lection theme
            Expanded(
              flex: 3,
              child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      color: request.approved
                          ? const Color.fromARGB(255, 137, 232, 135)
                          : const Color.fromARGB(255, 255, 101, 108),
                      border: Border.all(
                          width: 1,
                          color: request.approved
                              ? MyAppColorScheme.secondary
                              : MyAppColorScheme.errorColor),
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: request.approved
                          ? Text(
                              'Approved',
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            )
                          : Text(
                              'Not Approved',
                              style: const TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                    )
                  ])),
            ),

            // Trainer Image
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: 44,
                  height: 44,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    image: DecorationImage(
                      image: AssetImage(Images.lutzLogotypePng),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Reason
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  request.reason.length > 10
                      ? '${request.reason.substring(0, 10)}...'
                      : request.reason,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            // Date
            Text(dateFormat.format(request.date)),
          ]),
    );
  }
}
