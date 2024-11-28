import 'package:flutter/material.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/calendar_entry_adding/entry_adding_calendar.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/last_entries_list_widget/last_entries_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/loosed_entries_list_widget/loosed_entries_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/today_lection_widget/today_lection_widget.dart';

/// {@template student_main_screen_widget}
/// Widget that shows [StudentMainScreen]
/// {@endtemplate }
class StudentMainScreen extends StatelessWidget {
  /// {@macro student_main_screen_widget}
  const StudentMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
      primary: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CalendarEntryAddingWidget(),
          LoosedEntriesListWidget(),
          TodayLectionWidget(),
          LastEntriesListWidget(),
        ],
      ),
    );
  }
}
