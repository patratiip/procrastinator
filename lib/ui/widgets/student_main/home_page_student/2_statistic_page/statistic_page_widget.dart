import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/fake_data/user_fake_data/user_fake_data.dart';

import '../1_anmeldung_page_home/last_entrys_list_widget/last_entrys_list_widget.dart';
import 'unactual_widgets/statistic_circle_widget.dart';
import 'actual_statistic_circle_widget.dart';
import 'unactual_widgets/statistic_circle_widget_new.dart';

class StatisticPageWidget extends StatelessWidget {
  const StatisticPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      children: [
        Container(
          padding: EdgeInsets.only(top: 24, right: 16, left: 16, bottom: 32),
          child: StatisticCircleNewB(),
        ),
        Container(
            padding: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 42),
            child: LastEntrysListWidget()),
      ],
    );
  }
}
