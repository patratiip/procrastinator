import 'package:authentication_repository/authentication_repository.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/core/app/bloc_observer.dart';
import 'package:procrastinator/src/core/app/view/procrastinator.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_computing_service.dart';

import 'firebase_options.dart';

Future<void> main() async {
  //Init
  WidgetsFlutterBinding.ensureInitialized();

  //Bloc Observer
  Bloc.observer = const AppBlocObserver();

  //Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.I.registerSingleton(AuthenticationRepository());

  // GetIt.I.registerLazySingleton(() => AuthenticationRepository());
  GetIt.I.registerLazySingleton(() => FirebaseEntryRepository());
  GetIt.I.registerLazySingleton(() => FirebaseLectionRepository());
  GetIt.I.registerLazySingleton(() => ComparingLectionsAndEntriesService());
  GetIt.I.registerLazySingleton(() => StatisticComputingServise());

  //Auth Repo
  await GetIt.I<AuthenticationRepository>().user.first;

  runApp(Procrastinator(
      authenticationRepository: GetIt.I<AuthenticationRepository>()));

  // final model = ProcrastinatorModel();
  // await model.checkAuth();

  // runApp(Procrastinator(model: model));

  // await Hive.initFlutter();
  // Hive.registerAdapter(EntryAdapter());
  // final entrysBox = await Hive.openBox<Entry>('entrys_box');

  // Hive.registerAdapter(LectionAdapter());
  // final lectionsBox = await Hive.openBox<Lection>('lections_box');
}
