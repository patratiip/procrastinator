import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:procrastinator/src/features/app/di/app_scope.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/forgotten_entries/bloc/forgotten_entry_bloc/forgotten_entries_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/student_profile_screen/bloc/user_profile_bloc.dart';
import 'package:procrastinator/src/features/student_app/di/student_app_scope.dart';
import 'package:procrastinator/src/features/student_app/features/entries/bloc/last_entries_list_bloc/last_entries_list_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/loosed_entries/bloc/loosed_entries_bloc/loosed_entries_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/bloc/lection_plan_bloc/lection_plan_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/bloc/today_lection_bloc/today_lection_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/statistic/bloc/statistic_diagramm_bloc.dart';
import 'package:procrastinator/src/features/student_app/widget/student_app_view.dart';

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          // Entries
          BlocProvider(
            create: (context) => EntriesListBloc(
                entrysRepository:
                    StudentAppScope.depConOf(context).entryRepository),
          ),

          // Lection plan
          BlocProvider(
              create: (context) => LectionPlanBloc(
                  lectionsRepository:
                      StudentAppScope.depConOf(context).lectionRepository)),

          // Loosed lections
          BlocProvider(
              create: (context) => LoosedEntriesBloc(
                    entriesRepository:
                        StudentAppScope.depConOf(context).entryRepository,
                    lectionsRepository:
                        StudentAppScope.depConOf(context).lectionRepository,
                  )),

          // Statistic
          BlocProvider(
              create: (context) => StatisticDiagrammBloc(
                  AppScope.userOf(context).group!,
                  entriesRepository:
                      StudentAppScope.depConOf(context).entryRepository,
                  groupRepository:
                      StudentAppScope.depConOf(context).firebaseGroupRepository,
                  computingService: StudentAppScope.depConOf(context)
                      .statisticComputingServise)),

          // Today lection
          BlocProvider(
              create: (context) => TodayLectionBloc(
                  lectionsRepository:
                      StudentAppScope.depConOf(context).lectionRepository)
                ..add(const TodayLectionEvent.loadLection())),

          // User profile
          BlocProvider(
              create: (context) => UserProfileBloc(
                  userRepository: AppScope.depConOf(context).userRepository,
                  groupRepository: StudentAppScope.depConOf(context)
                      .firebaseGroupRepository)),

          // Entry adding
          BlocProvider(
              create: (context) => EntryAddingBloc(
                    entryAddingRepository:
                        StudentAppScope.depConOf(context).entryAddingRepository,
                  )),

          // Forgotten entries requests
          BlocProvider(
              create: (context) => ForgottenEntriesBloc(
                    forgottenEntriesRepository:
                        StudentAppScope.depConOf(context)
                            .forgottenEntryRepository,
                  )),
        ],
        child: const StudentAppView(),
      );
}
