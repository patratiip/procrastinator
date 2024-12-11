import 'package:flutter/material.dart';
import 'package:procrastinator/src/features/student_app/features/calendar_entry_adding/entry_adding_calendar.dart';
import 'package:procrastinator/src/features/student_app/features/entries/widget/last_entries_list_widget.dart';
import 'package:procrastinator/src/features/student_app/features/entries/widget/loosed_entries_list_widget.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/widget/today_lection_widget.dart';
import 'package:procrastinator/src/ui_kit/controllers/scroll_controller_provider.dart';

/// {@template student_main_screen_widget}
/// Widget that shows [StudentMainScreen]
/// {@endtemplate }
class StudentMainScreen extends StatelessWidget {
  /// {@macro student_main_screen_widget}
  StudentMainScreen({super.key});
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ScrollControllerProvider(
      scrollController: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: false,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CalendarEntryAddingWidget(),
            LoosedEntriesListWidget(),
            TodayLectionWidget(),
            LastEntriesListWidget(),
          ],
        ),
      ),
    );
  }
}
