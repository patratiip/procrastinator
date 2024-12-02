import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/app/di/app_scope.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/calendar_entry_adding/calendar_entry_adding_button/bloc/calendar_entry_adding_button_bloc.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/calendar_entry_adding/calendar_error_message_widget/bloc/calendar_error_message_bloc.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/calendar_entry_adding/entry_adding_calendar.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/last_entries_list_widget/last_entries_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/loosed_entries_list_widget/loosed_entries_list_widget.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/today_lection_widget/bloc/today_lection_bloc.dart';
import 'package:procrastinator/src/features/student_app/2_statistic_screen/statistic_page.dart';
import 'package:procrastinator/src/features/student_app/3_lection_plan_screen/lection_plan_page.dart';
import 'package:procrastinator/src/features/student_app/4_student_profile_screen/student_profile_screen.dart';
import 'package:procrastinator/src/features/student_app/di/student_app_scope.dart';
import 'package:procrastinator/src/features/student_app/student_app_view.dart';

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          // Entries
          BlocProvider(
            create: (context) => EntriesListBloc(
                entrysRepository:
                    StudentAppScope.depConOf(context).firebaseEntryRepository),
          ),

          // Lection plan
          BlocProvider(
              create: (context) => LectionPlanBloc(
                  lectionsRepository: StudentAppScope.depConOf(context)
                      .firebaseLectionRepository)),

          // Loosed lections
          BlocProvider(
              create: (context) => LoosedEntriesBloc(
                    entriesRepository: StudentAppScope.depConOf(context)
                        .firebaseEntryRepository,
                    lectionsRepository: StudentAppScope.depConOf(context)
                        .firebaseLectionRepository,
                  )),

          // Statistic
          BlocProvider(
              create: (context) => StatisticDiagrammBloc(
                  AppScope.userOf(context).group!,
                  entriesRepository:
                      StudentAppScope.depConOf(context).firebaseEntryRepository,
                  groupRepository:
                      StudentAppScope.depConOf(context).firebaseGroupRepository,
                  computingService: StudentAppScope.depConOf(context)
                      .statisticComputingServise)),

          // Today lection
          BlocProvider(
              create: (context) => TodayLectionBloc(
                  lectionsRepository: StudentAppScope.depConOf(context)
                      .firebaseLectionRepository)
                ..add(LoadTodayLection())),

          // User profile
          BlocProvider(
              create: (context) => UserProfileBloc(
                  userRepository: AppScope.depConOf(context).userRepository,
                  groupRepository: StudentAppScope.depConOf(context)
                      .firebaseGroupRepository)),

          // Calendar
          BlocProvider(
              create: (context) => CalendarBloc(
                    entriesRepository: StudentAppScope.depConOf(context)
                        .firebaseEntryRepository,
                    lectionsRepository: StudentAppScope.depConOf(context)
                        .firebaseLectionRepository,
                  )),

          // Entry adding button
          BlocProvider(
            create: (context) => CalendarEntryAddingButtonBloc(
                entriesRepository:
                    StudentAppScope.depConOf(context).firebaseEntryRepository,
                geolocationRepository: StudentAppScope.depConOf(context)
                    .deviceGeolocationRepository,
                userSchoolGeoposition:
                    AppScope.userOf(context).schoolGeoPosition!),
          ),

          // Error Widget
          BlocProvider(create: (context) => CalendarErrorMessageBloc()),
        ],
        child: const StudentAppView(),
      );
}
