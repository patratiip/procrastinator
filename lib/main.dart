import 'package:entry_repository/entry_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lection_repository/lection_repository.dart';

import 'package:procrastinator/src/features/app/presentation/procrastinator.dart';
import 'package:procrastinator/src/features/app/data/procrastinator_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_computing_service.dart';

import 'firebase_options.dart';

Future<void> main() async {
  //Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await Hive.initFlutter();
  // Hive.registerAdapter(EntryAdapter());
  // final entrysBox = await Hive.openBox<Entry>('entrys_box');

  // Hive.registerAdapter(LectionAdapter());
  // final lectionsBox = await Hive.openBox<Lection>('lections_box');

  GetIt.I.registerLazySingleton(() => FirebaseEntryRepository());
  GetIt.I.registerLazySingleton(() => FirebaseLectionRepository());
  // GetIt.I.registerLazySingleton(() => TodayLectionFirestoreRepository());
  GetIt.I.registerLazySingleton(() => ComparingLectionsAndEntriesService());

  // GetIt.I.registerLazySingleton(() => CalendarEntryFirestoreRepository());
  GetIt.I.registerLazySingleton(() => StatisticComputingServise());

  final model = ProcrastinatorModel();
  await model.checkAuth();

  runApp(Procrastinator(model: model));
}
