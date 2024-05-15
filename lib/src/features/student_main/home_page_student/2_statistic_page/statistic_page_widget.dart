import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../1_anmeldung_page_home/last_entrys_list_widget/presentation/last_entrys_list_widget.dart';
import 'statistic_diagramm_widget/presentation/actual_statistic_circle_widget.dart';

class StatisticPageWidget extends StatelessWidget {
  const StatisticPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 24, right: 16, left: 16, bottom: 32),
          child: StatisticCircle(),
        ),
        Container(
            padding:
                const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 42),
            child: LastEntrysListWidget()),
      ],
    );
  }
}
