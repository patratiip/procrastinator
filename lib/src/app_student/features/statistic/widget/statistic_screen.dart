import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/src/app_student/features/entries/widget/last_entries_list_widget.dart';
import 'package:procrastinator/src/app_student/features/statistic/widget/statistic_circle_widget.dart';

class StatisticScreenWidget extends StatelessWidget {
  const StatisticScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: true,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 24, right: 16, left: 16),
            child: const StatisticCircle(),
          ),
          Container(
              padding: const EdgeInsets.only(
                  top: 16, right: 16, left: 16, bottom: 42),
              child: const LastEntriesListWidget()),
        ],
      ),
    );
  }
}
