import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:procrastinator/src/features/app/presentation/procrastinator.dart';
import 'package:procrastinator/src/features/app/data/procrastinator_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/calendar_anmelung/domain/add_entry_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/data/last_entry_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/today_lesson_widget/domain/today_lection_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/domain/entry_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/data/lection_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

import 'firebase_options.dart';

Future<void> main() async {
  //Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(EntryAdapter());
  final entrysBox = await Hive.openBox<Entry>('entrys_box');

  Hive.registerAdapter(LectionAdapter());
  final lectionsBox = await Hive.openBox<Lection>('lections_box');

  GetIt.I.registerLazySingleton(() => EntryFirestoreRepository(entrysBox));
  GetIt.I.registerLazySingleton(() => LectionFirestoreRepository(lectionsBox));
  GetIt.I.registerLazySingleton(() => TodayLectionFirestoreRepository());
  GetIt.I.registerLazySingleton(() => ComparingLectionsAndEntrysRepository(entrysBox,lectionsBox ));

  GetIt.I.registerLazySingleton(() => CalenarEntryFirestoreRepository());
  GetIt.I.registerLazySingleton(() => StatisticRepository());

  final model = ProcrastinatorModel();
  await model.checkAuth();

  runApp(Procrastinator(model: model));
}
