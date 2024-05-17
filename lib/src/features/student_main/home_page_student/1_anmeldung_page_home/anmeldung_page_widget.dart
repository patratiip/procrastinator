import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/heutige_unterricht_widget/bloc/today_lesson_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/heutige_unterricht_widget/domain/today_lection_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/domain/entry_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/presentation/last_entrys_list_widget.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/bloc/loosed_entrys_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

import 'calendar_anmelung/presentation/anmeldung_calendar_widget.dart';
import 'heutige_unterricht_widget/presentation/heutige_unterricht_widget.dart';
import 'loosed_lessons_list_widget/presentation/loosed_lessons_list_widget.dart';

class AnmeldungPageWidget extends StatefulWidget {
  const AnmeldungPageWidget({super.key});

  @override
  State<AnmeldungPageWidget> createState() => _AnmeldungPageWidgetState();
}

class _AnmeldungPageWidgetState extends State<AnmeldungPageWidget> {
  final _todayLessonBlock =
      TodayLessonBloc(GetIt.I<TodayLectionFirestoreRepository>());

  final _blockLastEntrys =
      LastEntrysListBloc(GetIt.I<EntryFirestoreRepository>());

  final _loosedLectionsListBloc = LoosedEntrysBloc(
      GetIt.I<LectionFirestoreRepository>(),
      GetIt.I<EntryFirestoreRepository>(),
      GetIt.I<ComparingLectionsAndEntrysRepository>());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _todayLessonBlock.add(LoadTodayLection());
          _blockLastEntrys.add(LoadLastEntrys());
          _loosedLectionsListBloc
              .add(ComairingLectionsAndVisits(completer: completer));
          return completer.future;
        },
        displacement: 10,
        color: MyAppColorScheme.primary,
        child: ListView(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
          primary: true,
          children: [
            const CalendarAnmeldungWidget(),
            const LoosedEntrysListWidget(),
            HeutigeUnterrichtWidget(),
            LastEntrysListWidget(),
          ],
        ),
      ),
    );
  }
}
