import 'package:procrastinator/src/features/initialization/logic/error_tracking_manager.dart';

/// {@template dependencies_container}
/// Composed dependencies from the [CompositionRoot].
///
/// This class contains all the dependencies that are required for the application
/// to work.
///
/// {@macro composition_process}
/// {@endtemplate}
base class StudentDependenciesContainer {
  /// {@macro dependencies_container}
  const StudentDependenciesContainer({
    // required this.appSettingsBloc,
    required this.errorTrackingManager,
  });

  // /// [AppSettingsBloc] instance, used to manage theme and locale.
  // final AppSettingsBloc appSettingsBloc;

  /// [ErrorTrackingManager] instance, used to report errors.
  final ErrorTrackingManager errorTrackingManager;
}

/// {@template testing_dependencies_container}
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
