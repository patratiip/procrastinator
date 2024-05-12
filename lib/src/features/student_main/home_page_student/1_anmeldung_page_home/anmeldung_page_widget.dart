import 'package:flutter/cupertino.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/presentation/last_entrys_list_widget.dart';

import 'calendar_anmelung/anmeldung_calendar_widget.dart';
import 'heutige_unterricht_widget/presentation/heutige_unterricht_widget.dart';
import 'loosed_lessons_list_widget/loosed_lessons_list_widget.dart';

class AnmeldungPageWidget extends StatelessWidget {
  AnmeldungPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: true,
        children: [
          Container(child: CalendarAnmeldungWidget()),
          Container(child: LastEntrysListWidget()),
          Container(child: LoosedEntrysListWidget()),
          Container(child: HeutigeUnterrichtWidget()),
        ],
      ),
    );
  }
}
