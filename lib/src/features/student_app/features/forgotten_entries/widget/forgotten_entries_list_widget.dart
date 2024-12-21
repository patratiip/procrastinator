// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/src/features/student_app/features/forgotten_entries/model/forgotten_request.dart';
import 'package:procrastinator/src/features/student_app/features/forgotten_entries/widget/forgotten_entry_widget.dart';

import 'package:procrastinator/src/ui_kit/widget/bottom_sheet_widget.dart';

/// {@template forgotten_entries_request_list_widget}
/// Shows [ForgottenEntriesListWidget].
/// {@endtemplate}
class ForgottenEntriesListWidget extends StatelessWidget {
  final List<ForgottenRequestStudent> requestList;

  /// {@macro forgotten_entries_request_list_widget}
  const ForgottenEntriesListWidget({super.key, required this.requestList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: requestList.length,
        itemBuilder: (BuildContext context, int index) {
          return ForgottenEntryWidget(
            // tappable: true,
            // onTap: () => showModalBottomSheet(
            //   context: context,
            //   builder: (context) {
            //     return BottomSheetWidget(
            //       child: LectionBottomSheetContent(lection: requestList[index]),
            //     );
            //   },
            // ),
            request: requestList[index],
          );
        });
  }
}
