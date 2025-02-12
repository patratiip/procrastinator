import 'package:package_info_plus/package_info_plus.dart';
import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/utils/logger.dart';
import 'package:procrastinator/src/core/utils/error_tracking_manager/error_tracking_manager.dart';
import 'package:procrastinator/src/platform/settings/bloc/app_settings_bloc.dart';
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
    required this.logger,
    required this.config,
    required this.packageInfo,
    required this.userRepository,
    required this.appSettingsBloc,
    required this.errorTrackingManager,
  });

  /// [Logger] instance, used to log messages.
  final Logger logger;

  /// [Config] instance, contains configuration of the application.
  final Config config;

  /// [IUserRepository] instance, used to manage theme and locale.
  final IUserRepository userRepository;

  /// [AppSettingsBloc] instance, used to manage theme and locale.
  final AppSettingsBloc appSettingsBloc;

  /// [ErrorTrackingManager] instance, used to report errors.
  final ErrorTrackingManager errorTrackingManager;

  /// [PackageInfo] instance, contains information about the application.
  final PackageInfo packageInfo;
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
