import 'package:flutter/material.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/view/last_entrys_list_widget.dart';
import 'calendar_anmelung/view/anmeldung_calendar_widget.dart';
import 'today_lesson_widget/view/today_lesson_widget.dart';
import 'loosed_lessons_list_widget/view/loosed_lessons_list_widget.dart';

class AnmeldungPageWidget extends StatelessWidget {
  const AnmeldungPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: true,
        child: Column(
          children: [
            EntryAddingWidget(),
            LoosedEntrysListWidget(),
            HeutigeUnterrichtWidget(),
            LastEntrysListWidget(),
          ],
        ),
      ),
    );
  }
}
