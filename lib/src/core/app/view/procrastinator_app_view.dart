import 'package:entry_repository/entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/core/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/core/styles/theme/theme.dart';
import 'package:procrastinator/src/features/auth/login/login.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/calendar_anmelung/bloc/new_calendar_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/bloc/loosed_entrys_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/today_lesson_widget/bloc/today_lesson_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/statistic_diagramm_widget/bloc/statistic_diagramm_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_computing_service.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';
import 'package:procrastinator/src/features/student_app/student_main_screen.dart';

class ProcrastinatorAppView extends StatelessWidget {
  const ProcrastinatorAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Procrastinator',

        //THEME
        theme: MyAppThemeLight.themeLight,
        darkTheme: MyAppThemeDark.darkTheme,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  // BlocProvider(
                  //   create: (context) => SignInBloc(
                  //       context.read<AuthenticationBloc>().authenticationRepository),
                  // ),

                  //Entries
                  BlocProvider(
                    create: (context) => EntrysListBloc(
                        entrysRepository: GetIt.I<FirebaseEntryRepository>()),
                  ),
                  //Lections
                  BlocProvider(
                      create: (context) => KursplanBloc(
                          lectionsRepository:
                              GetIt.I<FirebaseLectionRepository>())),
                  //Statistic
                  BlocProvider(
                      create: (context) => StatisticDiagrammBloc(
                          EntrysListBloc(
                              entrysRepository:
                                  GetIt.I<FirebaseEntryRepository>()),
                          GetIt.I<StatisticComputingServise>())),
                  //TodayLection
                  BlocProvider(
                      create: (context) => TodayLessonBloc(
                          lectionsRepository:
                              GetIt.I<FirebaseLectionRepository>())
                        ..add(LoadTodayLection())),

                  //Calendar
                  BlocProvider(
                      create: (context) => CalendarBloc(
                          EntrysListBloc(
                              entrysRepository:
                                  GetIt.I<FirebaseEntryRepository>()),
                          KursplanBloc(
                              lectionsRepository:
                                  GetIt.I<FirebaseLectionRepository>()),
                          LoosedEntrysBloc(
                            EntrysListBloc(
                                entrysRepository:
                                    GetIt.I<FirebaseEntryRepository>()),
                            KursplanBloc(
                                lectionsRepository:
                                    GetIt.I<FirebaseLectionRepository>()),
                            comaringRepository:
                                GetIt.I<ComparingLectionsAndEntriesService>(),
                          ),
                          entrysRepository: GetIt.I<FirebaseEntryRepository>())
                      // ..add(CalendarInitializationEvent())
                      ),
                ],
                child: const StudentMainScreen(),
              );
            } else {
              return const LoginScreen();
            }
          }),
        ));
  }
}







// class Procrastinator extends StatelessWidget {
//   final ProcrastinatorModel model;
//   static final mainNavigation = MainNavigation();

//   const Procrastinator({super.key, required this.model});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
      // debugShowCheckedModeBanner: false,
      // title: 'Procrastinator',

      // //THEME
      // theme: MyAppThemeLight.themeLight,
      // darkTheme: MyAppThemeDark.darkTheme,

//       //ROUTING
//       initialRoute: mainNavigation.initialRoute(model.isAuth),
//       routes: mainNavigation.routes,
//       onGenerateRoute: mainNavigation.onGenerateRoute,
//     );
//   }
// }
