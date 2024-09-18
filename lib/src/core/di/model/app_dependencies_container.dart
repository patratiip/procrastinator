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
base class AppDependenciesContainer {
  /// {@macro dependencies_container}
  const AppDependenciesContainer({
    required this.userRepository,
    required this.currentUser,
    required this.errorTrackingManager,
  });

  /// [UserRepository] instance, used to manage theme and locale.
  final UserRepository userRepository;

  /// [MyUser] user data.
  final MyUser currentUser;

  /// [ErrorTrackingManager] instance, used to report errors.
  final ErrorTrackingManager errorTrackingManager;
}

/// {@template testing_dependencies_container}
/// A special version of [AppDependenciesContainer] that is used in tests.
///
/// In order to use [AppDependenciesContainer] in tests, it is needed to
/// extend this class and provide the dependencies that are needed for the test.
/// {@endtemplate}
base class TestDependenciesContainer implements AppDependenciesContainer {
  @override
  Object? noSuchMethod(Invocation invocation) {
    throw UnimplementedError(
      'The test tries to access ${invocation.memberName} dependency, but '
      'it was not provided. Please provide the dependency in the test. '
      'You can do it by extending this class and providing the dependency.',
    );
  }
}
