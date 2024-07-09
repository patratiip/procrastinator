import 'package:authentication_repository/authentication_repository.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/bloc_observer.dart';
import 'package:procrastinator/src/core/app/view/procrastinator.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_computing_service.dart';
import 'package:user_repository/user_repository.dart';

import 'firebase_options.dart';

Future<void> main() async {
  //Init
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Bloc Observer
  Bloc.observer = const AppBlocObserver();
  //Dependencies
  initGetIt();

  //Auth Repo
  await GetIt.I<FirebaseUserRepository>().user.first;

  runApp(ProcrastinatorApp(GetIt.I<FirebaseUserRepository>()));
}

void initGetIt() {
  GetIt.I.registerSingleton(FirebaseUserRepository());
  GetIt.I.registerSingleton(AuthenticationRepository());
  GetIt.I.registerFactory(() => FirebaseEntryRepository());
  GetIt.I.registerFactory(() => FirebaseLectionRepository());
  GetIt.I.registerFactory(() => DeviceGeolocationRepository());
  GetIt.I.registerLazySingleton(() => ComparingLectionsAndEntriesService());
  GetIt.I.registerLazySingleton(() => StatisticComputingServise());
}
