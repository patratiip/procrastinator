import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:group_repository/group_repository.dart';

import 'package:procrastinator/src/features/student_app/features/entries/data/firebase_entry_repository.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/data/lection_repository.dart';
import 'package:procrastinator/src/features/student_app/features/statistic/service/statistic_computing_service.dart';

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
    required this.firebaseGroupRepository,
    required this.deviceGeolocationRepository,
    required this.statisticComputingServise,
  });

  /// [EntryRepositoryImpl] instance, used to manage theme and locale.
  final EntryRepositoryImpl firebaseEntryRepository;

  /// [LectionRepositoryImpl] instance, used to manage theme and locale.
  final LectionRepositoryImpl firebaseLectionRepository;

  /// [IStudentGroupRepository] instance, used to manage theme and locale.
  final IStudentGroupRepository firebaseGroupRepository;

  /// [DeviceGeolocationRepository] instance, used to manage theme and locale.
  final DeviceGeolocationRepository deviceGeolocationRepository;

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
