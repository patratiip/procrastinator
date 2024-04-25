import 'package:flutter/cupertino.dart';
import 'package:procrastinator/ui/widgets/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/last_entrys_list_widget.dart';

import 'calendar_anmelung/anmeldung_calendar_widget.dart';
import 'heutige_unterricht_widget/heutige_unterricht_widget.dart';
import 'loosed_lessons_list_widget/loosed_lessons_list_widget.dart';

class AnmeldungPageWidget extends StatelessWidget {
  AnmeldungPageWidget({super.key});

  // final _heutigeUnterricht = fakeDataLessons[1];
  // final _anmeldungen = fakeAnmeldungen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: true,
        children: [
          Container(child: CalendarAnmeldungWidget()),
          Container(child: LoosedEntrysListWidget()),
          Container(child: HeutigeUnterrichtWidget()),
          Container(child: LastEntrysListWidget()),
        ],
      ),
    );
  }
}
