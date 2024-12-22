import 'package:flutter/material.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/widget/widget_entry_adding.dart';
import 'package:procrastinator/src/app_student/features/entries/widget/last_entries_list_widget.dart';
import 'package:procrastinator/src/app_student/features/loosed_entries/widget/loosed_entries_list_widget.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/widget/today_lection_widget.dart';
import 'package:procrastinator/src/app_student/features/student_main_screen/widget/scroll_controller_provider.dart';

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
            EntryAddingWidget(),
            LoosedEntriesListWidget(),
            TodayLectionWidget(),
            LastEntriesListWidget(),
          ],
        ),
      ),
    );
  }
}
