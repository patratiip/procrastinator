import 'package:entry_repository/entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/main.dart';
import 'package:procrastinator/src/core/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/core/styles/theme/theme.dart';
import 'package:procrastinator/src/features/auth/login/view/login_screen.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/calendar_entry_adding/bloc/calendar_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/loosed_entries_list_widget/bloc/loosed_entries_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/loosed_entries_list_widget/domain/comaring_loosed_entries_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/today_lection_widget/bloc/today_lection_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/bloc/statistic_diagramm_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/domain/statistic_computing_service.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';
import 'package:procrastinator/src/features/student_app/student_main_screen.dart';

class ProcrastinatorAppView extends StatelessWidget {
  const ProcrastinatorAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Procrastinator',
        localizationsDelegates: const [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Localization.delegate.supportedLocales,

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
                        entrysRepository: locator<FirebaseEntryRepository>()),
                  ),

                  //Lections
                  BlocProvider(
                      create: (context) => KursplanBloc(
                          lectionsRepository:
                              locator<FirebaseLectionRepository>())),

                  //Loosed Lections
                  BlocProvider(
                      create: (context) => LoosedEntriesBloc(
                            entriesRepository:
                                locator<FirebaseEntryRepository>(),
                            lectionsRepository:
                                locator<FirebaseLectionRepository>(),
                            comaringService:
                                locator<ComparingLectionsAndEntriesService>(),
                          )),

                  //Statistic
                  BlocProvider(
                      create: (context) => StatisticDiagrammBloc(
                          entriesRepository: locator<FirebaseEntryRepository>(),
                          computingService:
                              locator<StatisticComputingServise>())),

                  //TodayLection
                  BlocProvider(
                      create: (context) => TodayLectionBloc(
                          lectionsRepository:
                              locator<FirebaseLectionRepository>())
                        ..add(LoadTodayLection())),

                  //Calendar
                  BlocProvider(
                      create: (context) => CalendarBloc(
                            userRepository: context
                                .read<AuthenticationBloc>()
                                .authenticationRepository,
                            entriesRepository:
                                locator<FirebaseEntryRepository>(),
                            lectionsRepository:
                                locator<FirebaseLectionRepository>(),
                            geolocationRepository:
                                locator<DeviceGeolocationRepository>(),
                          )
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
