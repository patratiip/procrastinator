import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:group_repository/group_repository.dart';

import 'package:procrastinator/src/features/student_app/features/entries/data/entry_repository.dart';
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
    required this.entryRepository,
    required this.lectionRepository,
    required this.firebaseGroupRepository,
    required this.deviceGeolocationRepository,
    required this.statisticComputingServise,
  });

  /// [IEntryRepository] instance, used to manage theme and locale.
  final IEntryRepository entryRepository;

  /// [ILectionRepository] instance, used to manage theme and locale.
  final ILectionRepository lectionRepository;

  /// [IStudentGroupRepository] instance, used to manage theme and locale.
  final IStudentGroupRepository firebaseGroupRepository;

  /// [DeviceGeolocationRepository] instance, used to manage theme and locale.
  final DeviceGeolocationRepository deviceGeolocationRepository;

  /// [StatisticComputingServise] instance, used to manage theme and locale.
  final StatisticComputingServise statisticComputingServise;
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
