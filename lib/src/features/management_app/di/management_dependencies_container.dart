import 'package:group_repository/group_repository.dart';
import 'package:procrastinator/src/features/student_app/features/entries/data/entry_repository.dart';
import 'package:procrastinator/src/features/student_app/features/statistic/service/statistic_computing_service.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/data/lection_repository.dart';

/// {@template student_dependencies_container}
/// Composed dependencies from the [CompositionRoot].
///
/// This class contains all the dependencies that are required for the application
/// to work.
///
/// {@macro composition_process}
/// {@endtemplate}
base class ManagementDependenciesContainer {
  /// {@macro student_dependencies_container}
  const ManagementDependenciesContainer({
    required this.firebaseEntryRepository,
    required this.firebaseLectionRepository,
    required this.statisticComputingServise,
    required this.firebaseGroupRepository,
  });

  /// [EntryRepositoryImpl] instance, used to manage theme and locale.
  final EntryRepositoryImpl firebaseEntryRepository;

  /// [LectionRepositoryImpl] instance, used to manage theme and locale.
  final LectionRepositoryImpl firebaseLectionRepository;

  /// [StatisticComputingServise] instance, used to manage theme and locale.
  final StatisticComputingServise statisticComputingServise;

  /// [IManagementGroupRepository] instance, used to manage theme and locale.
  final IManagementGroupRepository firebaseGroupRepository;
}

/// {@template testing_student_dependencies_container}
/// A special version of [ManagementDependenciesContainer] that is used in tests.
///
/// In order to use [ManagementDependenciesContainer] in tests, it is needed to
/// extend this class and provide the dependencies that are needed for the test.
/// {@endtemplate}
base class TestDependenciesContainer
    implements ManagementDependenciesContainer {
  @override
  Object? noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'The test tries to access ${invocation.memberName} dependency, but '
      'it was not provided. Please provide the dependency in the test. '
      'You can do it by extending this class and providing the dependency.',
    );
  }
}
