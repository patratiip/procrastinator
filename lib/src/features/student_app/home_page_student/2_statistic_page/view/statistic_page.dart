import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/last_entrys_list_widget/view/last_entrys_list_widget.dart';

import 'actual_statistic_circle_widget.dart';

class StatisticPageWidget extends StatelessWidget {
  const StatisticPageWidget({super.key});

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
              child: const LastEntrysListWidget()),
        ],
      ),
    );
  }
}
