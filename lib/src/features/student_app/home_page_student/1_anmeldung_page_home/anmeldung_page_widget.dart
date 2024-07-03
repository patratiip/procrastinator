import 'package:entry_repository/entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/calendar_anmelung/bloc/new_calendar_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/view/last_entrys_list_widget.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/bloc/loosed_entrys_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';

import 'calendar_anmelung/view/anmeldung_calendar_widget.dart';
import 'today_lesson_widget/view/today_lesson_widget.dart';
import 'loosed_lessons_list_widget/view/loosed_lessons_list_widget.dart';

class AnmeldungPageWidget extends StatelessWidget {
  const AnmeldungPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: true,
        child: Column(
          children: [
            BlocProvider(
              create: (context) => CalendarBloc(
                  EntrysListBloc(
                      entrysRepository: GetIt.I<FirebaseEntryRepository>()),
                  KursplanBloc(
                      lectionsRepository: GetIt.I<FirebaseLectionRepository>()),
                  LoosedEntrysBloc(
                    EntrysListBloc(
                        entrysRepository: GetIt.I<FirebaseEntryRepository>()),
                    KursplanBloc(
                        lectionsRepository:
                            GetIt.I<FirebaseLectionRepository>()),
                    comaringRepository:
                        GetIt.I<ComparingLectionsAndEntriesService>(),
                  ),
                  entrysRepository: GetIt.I<FirebaseEntryRepository>())
                ..add(CalendarInitializationEvent()),
              child: const EntryAddingWidget(),
            ),
            LoosedEntrysListWidget(),
            HeutigeUnterrichtWidget(),
            LastEntrysListWidget(),
          ],
        ),
      ),
    );
  }
}
