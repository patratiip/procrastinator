import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/di/scopes/app_dependencies_scope.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/calendar_entry_adding/entry_adding_calendar.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/last_entrys_list_widget/last_entrys_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/loosed_entries_list_widget/loosed_entries_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/today_lection_widget/bloc/today_lection_bloc.dart';
import 'package:procrastinator/src/features/student_app/2_statistic_screen/statistic_page.dart';
import 'package:procrastinator/src/features/student_app/3_kursplan_screen/kursplan_page.dart';
import 'package:procrastinator/src/features/student_app/4_student_profile_screen/student_profile_screen.dart';
import 'package:procrastinator/src/core/di/scopes/student_app_scope.dart';
import 'package:procrastinator/src/features/student_app/student_app_view.dart';

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          //Entries
          BlocProvider(
            create: (context) => EntriesListBloc(
                entrysRepository:
                    StudentAppScope.depConOf(context, listen: false)
                        .firebaseEntryRepository),
          ),

          //Lections
          BlocProvider(
              create: (context) => KursplanBloc(
                  lectionsRepository:
                      StudentAppScope.depConOf(context, listen: false)
                          .firebaseLectionRepository)),

          //Loosed Lections
          BlocProvider(
              create: (context) => LoosedEntriesBloc(
                    entriesRepository:
                        StudentAppScope.depConOf(context, listen: false)
                            .firebaseEntryRepository,
                    lectionsRepository:
                        StudentAppScope.depConOf(context, listen: false)
                            .firebaseLectionRepository,
                    comaringService:
                        StudentAppScope.depConOf(context, listen: false)
                            .comparingLectionsAndEntriesService,
                  )),

          //Statistic
          BlocProvider(
              create: (context) => StatisticDiagrammBloc(
                  AppScope.userOf(context, listen: false).group!,
                  entriesRepository:
                      StudentAppScope.depConOf(context, listen: false)
                          .firebaseEntryRepository,
                  groupRepository:
                      StudentAppScope.depConOf(context, listen: false)
                          .firebaseGroupRepository,
                  computingService:
                      StudentAppScope.depConOf(context, listen: false)
                          .statisticComputingServise)),

          //TodayLection
          BlocProvider(
              create: (context) => TodayLectionBloc(
                  lectionsRepository:
                      StudentAppScope.depConOf(context, listen: false)
                          .firebaseLectionRepository)
                ..add(LoadTodayLection())),

          //Calendar
          BlocProvider(
              create: (context) => CalendarBloc(
                  entriesRepository:
                      StudentAppScope.depConOf(context, listen: false)
                          .firebaseEntryRepository,
                  lectionsRepository:
                      StudentAppScope.depConOf(context, listen: false)
                          .firebaseLectionRepository,
                  geolocationRepository:
                      StudentAppScope.depConOf(context, listen: false)
                          .deviceGeolocationRepository,
                  userSchoolGeoposition: AppScope.userOf(context, listen: false)
                      .schoolGeoPosition!)
              // ..add(CalendarSubscriptionsRequested())
              ),
          BlocProvider(
              create: (context) => UserProfileBloc(
                  userRepository:
                      AppScope.depConOf(context, listen: false).userRepository,
                  groupRepository:
                      StudentAppScope.depConOf(context, listen: false)
                          .firebaseGroupRepository))
        ],
        child: const StudentAppView(),
      );
}
