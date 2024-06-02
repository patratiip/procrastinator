import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/core/router/main_navigation.dart';
import 'package:procrastinator/src/features/app/data/procrastinator_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/domain/entry_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/bloc/loosed_entrys_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/today_lesson_widget/bloc/today_lesson_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/today_lesson_widget/domain/today_lection_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

import '../../../core/styles/theme/app_theme_dark.dart';
import '../../../core/styles/theme/app_theme_light.dart';

class Procrastinator extends StatelessWidget {
  final ProcrastinatorModel model;
  static final mainNavigation = MainNavigation();

  const Procrastinator({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LastEntrysListBloc>(
          create: (context) => LastEntrysListBloc(
              entrysRepository: GetIt.I<EntryFirestoreRepository>()),
        ),
        BlocProvider<TodayLessonBloc>(
          create: (context) => TodayLessonBloc(
              lectionsRepository: GetIt.I<TodayLectionFirestoreRepository>()),
        ),
        BlocProvider<LoosedEntrysBloc>(
          create: (context) => LoosedEntrysBloc(
              LastEntrysListBloc(
                  entrysRepository: GetIt.I<EntryFirestoreRepository>()),
              KursplanBloc(
                  lectionsRepository: GetIt.I<LectionFirestoreRepository>()),
              comaringRepository:
                  GetIt.I<ComparingLectionsAndEntrysRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Procrastinator',

        //THEME
        theme: MyAppThemeLight.themeLight,
        darkTheme: MyAppThemeDark.darkTheme,

        //ROUTING
        initialRoute: mainNavigation.initialRoute(model.isAuth),
        routes: mainNavigation.routes,
        onGenerateRoute: mainNavigation.onGenerateRoute,
      ),
    );
  }
}
