import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/calendar_entry_adding/entry_adding_calendar.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/last_entrys_list_widget/last_entrys_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/loosed_entries_list_widget/loosed_entries_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/today_lection_widget/bloc/today_lection_bloc.dart';
import 'package:procrastinator/src/features/student_app/2_statistic_screen/statistic_page.dart';
import 'package:procrastinator/src/features/student_app/3_kursplan_screen/kursplan_page.dart';
import 'package:procrastinator/src/features/student_app/student_app_scope.dart';
import 'package:procrastinator/src/features/student_app/student_app_view.dart';

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          //Entries
          BlocProvider(
            create: (context) => EntrysListBloc(
                entrysRepository: StudentAppScope.depOf(context, listen: false)
                    .firebaseEntryRepository),
          ),

          //Lections
          BlocProvider(
              create: (context) => KursplanBloc(
                  lectionsRepository:
                      StudentAppScope.depOf(context, listen: false)
                          .firebaseLectionRepository)),

          //Loosed Lections
          BlocProvider(
              create: (context) => LoosedEntriesBloc(
                    entriesRepository:
                        StudentAppScope.depOf(context, listen: false)
                            .firebaseEntryRepository,
                    lectionsRepository:
                        StudentAppScope.depOf(context, listen: false)
                            .firebaseLectionRepository,
                    comaringService:
                        StudentAppScope.depOf(context, listen: false)
                            .comparingLectionsAndEntriesService,
                  )),

          //Statistic
          BlocProvider(
              create: (context) => StatisticDiagrammBloc(
                  entriesRepository:
                      StudentAppScope.depOf(context, listen: false)
                          .firebaseEntryRepository,
                  computingService:
                      StudentAppScope.depOf(context, listen: false)
                          .statisticComputingServise)),

          //TodayLection
          BlocProvider(
              create: (context) => TodayLectionBloc(
                  lectionsRepository:
                      StudentAppScope.depOf(context, listen: false)
                          .firebaseLectionRepository)
                ..add(LoadTodayLection())),

          //Calendar
          BlocProvider(
              create: (context) => CalendarBloc(
                    userRepository: AppScope.of(context, listen: false)
                        .dependenciesContainer
                        .userRepository,
                    entriesRepository:
                        StudentAppScope.depOf(context, listen: false)
                            .firebaseEntryRepository,
                    lectionsRepository:
                        StudentAppScope.depOf(context, listen: false)
                            .firebaseLectionRepository,
                    geolocationRepository:
                        StudentAppScope.depOf(context, listen: false)
                            .deviceGeolocationRepository,
                  )
              // ..add(CalendarInitializationEvent())
              ),
        ],
        child: const StudentAppView(),
      );
}
