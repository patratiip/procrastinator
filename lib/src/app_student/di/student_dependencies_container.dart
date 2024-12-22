import 'package:group_repository/group_repository.dart';

import 'package:procrastinator/src/app_student/features/entries/data/entry_repository.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/data/forgotten_entry_repository.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/data/lection_repository.dart';
import 'package:procrastinator/src/app_student/features/statistic/service/statistic_computing_service.dart';

/// {@template student_dependencies_container}
/// Composed dependencies from the [CompositionRoot].
///
/// This class contains all the dependencies that are required for student application
/// to work.
///
/// {@macro composition_process}
/// {@endtemplate}
base class StudentDependenciesContainer {
  /// {@macro student_dependencies_container}
  const StudentDependenciesContainer({
    required this.entryRepository,
    required this.lectionRepository,
    required this.entryAddingRepository,
    required this.forgottenEntryRepository,
    required this.firebaseGroupRepository,
    required this.statisticComputingServise,
  });

  /// [IEntryRepository] instance, used to manage entries.
  final IEntryRepository entryRepository;

  /// [ILectionRepository] instance, used to manage lections.
  final ILectionRepository lectionRepository;

  /// [IEntryAddingRepository] instance, used to manage entry adding process.
  final IEntryAddingRepository entryAddingRepository;

  /// [IForgottenEntryRepository] instance, used to manage forgotten entries requests.
  final IForgottenEntryRepository forgottenEntryRepository;

  /// [IStudentGroupRepository] instance, used to manage student group.
  final IStudentGroupRepository firebaseGroupRepository;

  /// [StatisticComputingServise] instance, used to manage attendance statistic.
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
