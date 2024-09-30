import 'package:flutter/material.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/last_entrys_list_widget/view/last_entrys_list_widget.dart';
import '../calendar_entry_adding/view/calendar_entry_adding.dart';
import '../today_lection_widget/view/today_lection_widget.dart';
import '../loosed_entries_list_widget/view/loosed_entries_list_widget.dart';

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
            CalendarEntryAddingWidget(),
            LoosedEntriesListWidget(),
            TodayLectionWidget(),
            LastEntrysListWidget(),
          ],
        ),
      ),
    );
  }
}
