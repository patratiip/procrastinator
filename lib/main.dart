import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:procrastinator/src/features/app/data/procrastinator.dart';
import 'package:procrastinator/src/features/app/data/procrastinator_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/calendar_anmelung/domain/add_entry_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/heutige_unterricht_widget/domain/today_lection_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/domain/entry_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

import 'firebase_options.dart';

Future<void> main() async {
  //Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.I.registerLazySingleton(() => EntryFirestoreRepository());
  GetIt.I.registerLazySingleton(() => LectionFirestoreRepository());
  GetIt.I.registerLazySingleton(() => TodayLectionFirestoreRepository());
  GetIt.I.registerLazySingleton(() => ComparingLectionsAndEntrysRepository());

  GetIt.I.registerLazySingleton(() => CalenarEntryFirestoreRepository());
  GetIt.I.registerLazySingleton(() => StatisticRepository());

  final model = ProcrastinatorModel();
  await model.checkAuth();

  runApp(Procrastinator(model: model));
}
