import 'package:procrastinator/src/features/initialization/logic/error_tracking_manager.dart';
import 'package:user_repository/user_repository.dart';

/// {@template dependencies_container}
/// Composed dependencies from the [CompositionRoot].
///
/// This class contains all the dependencies that are required for the application
/// to work.
///
/// {@macro composition_process}
/// {@endtemplate}
base class DependenciesContainer {
  /// {@macro dependencies_container}
  const DependenciesContainer({
    required this.userRepository,
    required this.errorTrackingManager,
  });

  // /// [AppSettingsBloc] instance, used to manage theme and locale.
  final UserRepository userRepository;

  /// [ErrorTrackingManager] instance, used to report errors.
  final ErrorTrackingManager errorTrackingManager;
}

/// {@template testing_dependencies_container}
/// A special version of [DependenciesContainer] that is used in tests.
///
/// In order to use [DependenciesContainer] in tests, it is needed to
/// extend this class and provide the dependencies that are needed for the test.
/// {@endtemplate}
base class TestDependenciesContainer implements DependenciesContainer {
  @override
  Object? noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'The test tries to access ${invocation.memberName} dependency, but '
      'it was not provided. Please provide the dependency in the test. '
      'You can do it by extending this class and providing the dependency.',
    );
  }
}

// class AppDependenciesContainer extends DependenciesContainer {
//   AppDependenciesContainer({
//     required super.errorTrackingManager,
//     required this.userRepository,
//   });

//   /// [UserRepository] instance, used to manage theme and locale.
//   final UserRepository userRepository;
// }

// class StudentsDependenciesContainer extends DependenciesContainer {
//   StudentsDependenciesContainer({required super.errorTrackingManager});
// }
