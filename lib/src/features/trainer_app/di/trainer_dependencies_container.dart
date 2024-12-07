import 'package:group_repository/group_repository.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/domain/lection_repository.dart';

/// {@template student_dependencies_container}
/// Composed dependencies from the [CompositionRoot].
///
/// This class contains all the dependencies that are required for the application
/// to work.
///
/// {@macro composition_process}
/// {@endtemplate}
base class TrainerDependenciesContainer {
  /// {@macro student_dependencies_container}
  const TrainerDependenciesContainer({
    required this.firebaseLectionRepository,
    required this.firebaseGroupRepository,
  });

  /// [LectionRepository] instance, used to manage theme and locale.
  final LectionRepository firebaseLectionRepository;

  /// [ITrainerGroupRepository] instance, used to manage theme and locale.
  final ITrainerGroupRepository firebaseGroupRepository;
}

/// {@template testing_student_dependencies_container}
/// A special version of [TrainerDependenciesContainer] that is used in tests.
///
/// In order to use [TrainerDependenciesContainer] in tests, it is needed to
/// extend this class and provide the dependencies that are needed for the test.
/// {@endtemplate}
base class TestDependenciesContainer implements TrainerDependenciesContainer {
  @override
  Object? noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'The test tries to access ${invocation.memberName} dependency, but '
      'it was not provided. Please provide the dependency in the test. '
      'You can do it by extending this class and providing the dependency.',
    );
  }
}
