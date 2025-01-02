// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/widget/lection_bottom_sheet_content.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/widget/lection_widget.dart';
import 'package:procrastinator/src/ui_kit/widget/bottom_sheet_widget.dart';

/// {@template lection_list_widget}
/// Shows [LectionListWidget].
/// {@endtemplate}
class LectionListWidget extends StatelessWidget {
  final List<Lection> lectionList;

  /// {@macro lection_list_widget}
  const LectionListWidget({super.key, required this.lectionList});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: lectionList.length,
        itemBuilder: (BuildContext context, int index) {
          return LectionWidget(
            tappable: true,
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return BottomSheetWidget(
                  child: LectionBottomSheetContent(lection: lectionList[index]),
                );
              },
            ),
            lection: lectionList[index],
          );
        });
  }
}
