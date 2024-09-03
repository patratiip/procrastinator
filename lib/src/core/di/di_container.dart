import 'package:entry_repository/entry_repository.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/main.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/loosed_entries_list_widget/domain/comaring_loosed_entries_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/domain/statistic_computing_service.dart';
import 'package:user_repository/user_repository.dart';

void initGetIt() {
  // locator.registerSingleton(FirebaseUserRepositoryB());
  // locator.registerSingleton(FirebaseUserRepo());
  locator.registerLazySingleton(() => FirebaseEntryRepository());
  locator.registerLazySingleton(() => FirebaseLectionRepository());
  locator.registerLazySingleton(() => DeviceGeolocationRepository());
  locator.registerLazySingleton(() => ComparingLectionsAndEntriesService());
  locator.registerLazySingleton(() => StatisticComputingServise());
}

class DiContainer {}
