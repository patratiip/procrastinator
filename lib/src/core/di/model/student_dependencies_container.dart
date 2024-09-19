import 'package:entry_repository/entry_repository.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/features/student_app/1_anmeldung_page/loosed_entries_list_widget/domain/comaring_loosed_entries_repository.dart';
import 'package:procrastinator/src/features/student_app/2_statistic_page/domain/statistic_computing_service.dart';

/// {@template student_dependencies_container}
/// Composed dependencies from the [CompositionRoot].
///
/// This class contains all the dependencies that are required for the application
/// to work.
///
/// {@macro composition_process}
/// {@endtemplate}
base class StudentDependenciesContainer {
  /// {@macro student_dependencies_container}
  const StudentDependenciesContainer({
    required this.firebaseEntryRepository,
    required this.firebaseLectionRepository,
    required this.deviceGeolocationRepository,
    required this.comparingLectionsAndEntriesService,
    required this.statisticComputingServise,
    
  });

  /// [FirebaseEntryRepository] instance, used to manage theme and locale.
  final FirebaseEntryRepository firebaseEntryRepository;

  /// [FirebaseLectionRepository] instance, used to manage theme and locale.
  final FirebaseLectionRepository firebaseLectionRepository;

  /// [DeviceGeolocationRepository] instance, used to manage theme and locale.
  final DeviceGeolocationRepository deviceGeolocationRepository;

  /// [ComparingLectionsAndEntriesService] instance, used to manage theme and locale.
  final ComparingLectionsAndEntriesService comparingLectionsAndEntriesService;

  /// [StatisticComputingServise] instance, used to manage theme and locale.
  final StatisticComputingServise statisticComputingServise;

  //  FirebaseEntryRepository();
  //  FirebaseLectionRepository();
  //  DeviceGeolocationRepository();
  //  ComparingLectionsAndEntriesService();
  // StatisticComputingServise();


}

/// {@template testing_student_dependencies_container}
/// A special version of [StudentDependenciesContainer] that is used in tests.
///
/// In order to use [StudentDependenciesContainer] in tests, it is needed to
/// extend this class and provide the dependencies that are needed for the test.
/// {@endtemplate}
base class TestDependenciesContainer implements StudentDependenciesContainer {
  @override
  Object? noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'The test tries to access ${invocation.memberName} dependency, but '
      'it was not provided. Please provide the dependency in the test. '
      'You can do it by extending this class and providing the dependency.',
    );
  }
}