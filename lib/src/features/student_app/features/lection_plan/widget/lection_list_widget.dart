// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';

import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/widget/lection_bottom_sheet_widget.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/widget/lection_widget.dart';

/// {@template lection_list_widget}
/// Shows [LectionListWidget].
/// {@endtemplate}
class LectionListWidget extends StatelessWidget {
  final List<Lection> lectionList;

  /// {@macro lection_list_widget}
  const LectionListWidget({super.key, required this.lectionList});
  @override
  Widget build(BuildContext context) {
    //TODO: When the feature wold be separated, delete [filteredLections]
    final filteredLections = lectionList
        .where((lection) => lection.date.isAfter(DateTime.now()))
        .toList();
    return ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: filteredLections.length,
        itemBuilder: (BuildContext context, int index) {
          return LectionWidget(
            tappable: true,
            onTap: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return LectionBottomSheetWidget(
                    lection: filteredLections[index]);
              },
            ),
            lection: filteredLections[index],
          );
        });
  }
}
