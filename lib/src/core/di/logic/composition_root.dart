import 'package:clock/clock.dart';
import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/di/model/app_dependencies_container.dart';
import 'package:procrastinator/src/core/utils/refined_logger.dart';
import 'package:procrastinator/src/features/initialization/logic/error_tracking_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

/// {@template composition_root}
/// A place where all dependencies are initialized.
/// {@endtemplate}
///
/// {@template composition_process}
/// Composition of dependencies is a process of creating and configuring
/// instances of classes that are required for the application to work.
///
/// It is a good practice to keep all dependencies in one place to make it
/// easier to manage them and to ensure that they are initialized only once.
/// {@endtemplate}
final class CompositionRoot {
  /// {@macro composition_root}
  const CompositionRoot(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  /// Composes dependencies and returns result of composition.
  Future<CompositionResult> composeAppDependencies() async {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies = await AppDependenciesFactory(config, logger).create();
    logger.info('Dependencies initialized');

    stopwatch.stop();
    final result = CompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );

    return result;
  }

  // /// Composes dependencies for Student App and returns result of composition.
  // Future<CompositionResult> composeStudentDependencies() async {
  //   final stopwatch = clock.stopwatch()..start();

  //   logger.info('Initializing dependencies...');
  //   // initialize dependencies
  //   final dependencies =
  //       await StudentDependenciesFactory(config, logger).create();
  //   logger.info('Student dependencies initialized');

  //   stopwatch.stop();
  //   final result = CompositionResult(
  //     dependencies: dependencies,
  //     msSpent: stopwatch.elapsedMilliseconds,
  //   );

  //   return result;
  // }
}

/// {@template factory}
/// Factory that creates an instance of [T].
/// {@endtemplate}
abstract class Factory<T> {
  /// Creates an instance of [T].
  T create();
}

/// {@template async_factory}
/// Factory that creates an instance of [T] asynchronously.
/// {@endtemplate}
abstract class AsyncFactory<T> {
  /// Creates an instance of [T].
  Future<T> create();
}

/// {@template dependencies_factory}
/// Factory that creates an instance of [DependenciesContainer].
/// {@endtemplate}
class AppDependenciesFactory extends AsyncFactory<DependenciesContainer> {
  /// {@macro dependencies_factory}
  AppDependenciesFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  @override
  Future<DependenciesContainer> create() async {
    // final sharedPreferences = SharedPreferencesAsync();

    final errorTrackingManager =
        await ErrorTrackingManagerFactory(config, logger).create();
    final userRepository = await FirebaseUserRepositoryFactory().create();

    return DependenciesContainer(
      userRepository: userRepository,
      errorTrackingManager: errorTrackingManager,
    );
  }
}

// /// {@template dependencies_factory}
// /// Factory that creates an instance of [DependenciesContainer].
// /// {@endtemplate}
// class StudentDependenciesFactory extends AsyncFactory<DependenciesContainer> {
//   /// {@macro dependencies_factory}
//   StudentDependenciesFactory(this.config, this.logger);

//   /// Application configuration
//   final Config config;

//   /// Logger used to log information during composition process.
//   final RefinedLogger logger;

//   @override
//   Future<DependenciesContainer> create() async {
//     final errorTrackingManager =
//         await ErrorTrackingManagerFactory(config, logger).create();
//     // final settingsBloc = await SettingsBlocFactory(sharedPreferences).create();

//     return StudentsDependenciesContainer(
//       // appSettingsBloc: settingsBloc,
//       errorTrackingManager: errorTrackingManager,
//     );
//   }
// }

/// {@template error_tracking_manager_factory}
/// Factory that creates an instance of [ErrorTrackingManager].
/// {@endtemplate}
class ErrorTrackingManagerFactory extends AsyncFactory<ErrorTrackingManager> {
  /// {@macro error_tracking_manager_factory}
  ErrorTrackingManagerFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  @override
  Future<ErrorTrackingManager> create() async {
    final errorTrackingManager = SentryTrackingManager(
      logger,
      sentryDsn: config.sentryDsn,
      environment: config.environment.value,
    );

    if (config.enableSentry) {
      await errorTrackingManager.enableReporting();
    }

    return errorTrackingManager;
  }
}

//////////////////////////////////////////////////////////////////////////
/////Auth Repo
// final userRepository = FirebaseUserRepository();
// await userRepository.user.first;

/// {@template firebase_user_repo_factory}
/// Factory that creates an instance of [FirebaseUserRepository].
/// {@endtemplate}
class FirebaseUserRepositoryFactory
    extends AsyncFactory<FirebaseUserRepository> {
  /// {@macro firebase_user_repo_factory}
  FirebaseUserRepositoryFactory();

  @override
  Future<FirebaseUserRepository> create() async {
    ///Auth Repo
    final userRepository = FirebaseUserRepository();
    await userRepository.user.first;
    return userRepository;
  }
}

// /// {@template settings_bloc_factory}
// /// Factory that creates an instance of [AppSettingsBloc].
// /// {@endtemplate}
// class SettingsBlocFactory extends AsyncFactory<AppSettingsBloc> {
//   /// {@macro settings_bloc_factory}
//   SettingsBlocFactory(this.sharedPreferences);

//   /// Shared preferences instance
//   final SharedPreferencesAsync sharedPreferences;

//   @override
//   Future<AppSettingsBloc> create() async {
//     final appSettingsRepository = AppSettingsRepositoryImpl(
//       datasource: AppSettingsDatasourceImpl(sharedPreferences: sharedPreferences),
//     );

//     final appSettings = await appSettingsRepository.getAppSettings();
//     final initialState = AppSettingsState.idle(appSettings: appSettings);

//     return AppSettingsBloc(
//       appSettingsRepository: appSettingsRepository,
//       initialState: initialState,
//     );
//   }
// }

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class CompositionResult {
  /// {@macro composition_result}
  const CompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies container
  final DependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$CompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
