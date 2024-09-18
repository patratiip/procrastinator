import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/features/student_app/1_anmeldung_page/calendar_entry_adding/entry_adding_calendar.dart';
import 'package:procrastinator/src/features/student_app/1_anmeldung_page/last_entrys_list_widget/last_entrys_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_anmeldung_page/loosed_entries_list_widget/loosed_entries_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_anmeldung_page/today_lection_widget/bloc/today_lection_bloc.dart';
import 'package:procrastinator/src/features/student_app/2_statistic_page/statistic_page.dart';
import 'package:procrastinator/src/features/student_app/3_kursplan_page/kursplan_page.dart';
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
                entrysRepository: StudentAppScope.of(context, listen: false)
                    .studentDependenciesContainer
                    .firebaseEntryRepository),
          ),

          //Lections
          BlocProvider(
              create: (context) => KursplanBloc(
                  lectionsRepository: StudentAppScope.of(context, listen: false)
                      .studentDependenciesContainer
                      .firebaseLectionRepository)),

          //Loosed Lections
          BlocProvider(
              create: (context) => LoosedEntriesBloc(
                    entriesRepository:
                        StudentAppScope.of(context, listen: false)
                            .studentDependenciesContainer
                            .firebaseEntryRepository,
                    lectionsRepository:
                        StudentAppScope.of(context, listen: false)
                            .studentDependenciesContainer
                            .firebaseLectionRepository,
                    comaringService: StudentAppScope.of(context, listen: false)
                        .studentDependenciesContainer
                        .comparingLectionsAndEntriesService,
                  )),

          //Statistic
          BlocProvider(
              create: (context) => StatisticDiagrammBloc(
                  entriesRepository: StudentAppScope.of(context, listen: false)
                      .studentDependenciesContainer
                      .firebaseEntryRepository,
                  computingService: StudentAppScope.of(context, listen: false)
                      .studentDependenciesContainer
                      .statisticComputingServise)),

          //TodayLection
          BlocProvider(
              create: (context) => TodayLectionBloc(
                  lectionsRepository: StudentAppScope.of(context, listen: false)
                      .studentDependenciesContainer
                      .firebaseLectionRepository)
                ..add(LoadTodayLection())),

          //Calendar
          BlocProvider(
              create: (context) => CalendarBloc(
                    userRepository:
                        AppDependenciesScope.of(context).userRepository,
                    entriesRepository:
                        StudentAppScope.of(context, listen: false)
                            .studentDependenciesContainer
                            .firebaseEntryRepository,
                    lectionsRepository:
                        StudentAppScope.of(context, listen: false)
                            .studentDependenciesContainer
                            .firebaseLectionRepository,
                    geolocationRepository:
                        StudentAppScope.of(context, listen: false)
                            .studentDependenciesContainer
                            .deviceGeolocationRepository,
                  )
              // ..add(CalendarInitializationEvent())
              ),
        ],
        child: const StudentAppView(),
      );
}
