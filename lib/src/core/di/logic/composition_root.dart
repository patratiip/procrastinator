import 'package:clock/clock.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/di/model/app_dependencies_container.dart';
import 'package:procrastinator/src/core/di/model/student_dependencies_container.dart';
import 'package:procrastinator/src/core/utils/refined_logger.dart';
import 'package:procrastinator/src/features/initialization/logic/error_tracking_manager.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page/loosed_entries_list_widget/domain/comaring_loosed_entries_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/domain/statistic_computing_service.dart';
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
  Future<AppCompositionResult> composeAppDependencies() async {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies = await AppDependenciesFactory(config, logger).create();
    logger.info('Dependencies initialized');

    stopwatch.stop();
    final result = AppCompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );

    return result;
  }

  /// Composes dependencies for Student App and returns result of composition.
  Future<StudentAppCompositionResult> composeStudentDependencies(
      String currentUser) async {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies =
        await StudentDependenciesFactory(config, logger).create();
    logger.info('Student dependencies initialized');

    stopwatch.stop();
    final result = StudentAppCompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );

    return result;
  }
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
/// Factory that creates an instance of [AppDependenciesContainer].
/// {@endtemplate}
class AppDependenciesFactory extends AsyncFactory<AppDependenciesContainer> {
  /// {@macro dependencies_factory}
  AppDependenciesFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  @override
  Future<AppDependenciesContainer> create() async {
    // final sharedPreferences = SharedPreferencesAsync();

    final errorTrackingManager =
        await ErrorTrackingManagerFactory(config, logger).create();
    final userRepository = await FirebaseUserRepositoryFactory().create();

    return AppDependenciesContainer(
      userRepository: userRepository,
      errorTrackingManager: errorTrackingManager,
    );
  }
}

/// {@template firebase_user_repo_factory}
/// Factory that creates an instance of [FirebaseUserRepository].
/// {@endtemplate}
class FirebaseUserRepositoryFactory
    extends AsyncFactory<FirebaseUserRepository> {
  /// {@macro firebase_user_repo_factory}

  @override
  Future<FirebaseUserRepository> create() async {
    ///Auth Repo
    final userRepository = FirebaseUserRepository();
    await userRepository.user.first;
    return userRepository;
  }
}

/// {@template student_dependencies_factory}
/// Factory that creates an instance of [StudentDependenciesContainer].
/// {@endtemplate}
class StudentDependenciesFactory
    extends AsyncFactory<StudentDependenciesContainer> {
  /// {@macro student_dependencies_factory}
  StudentDependenciesFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  @override
  Future<StudentDependenciesContainer> create() async {
    final errorTrackingManager =
        await ErrorTrackingManagerFactory(config, logger).create();
    final firebaseEntryRepository = FirebaseEntryRepositoryFactory().create();
    final firebaseLectionRepository =
        FirebaseLectionRepositoryFactory().create();
    final deviceGeolocationRepository =
        DeviceGeolocationRepositoryFactory().create();
    final comparingLectionsAndEntriesService =
        ComparingLectionsAndEntriesServiceFactory().create();
    final statisticComputingServise =
        StatisticComputingServiseFactory().create();

    return StudentDependenciesContainer(
      errorTrackingManager: errorTrackingManager,
      firebaseEntryRepository: firebaseEntryRepository,
      firebaseLectionRepository: firebaseLectionRepository,
      deviceGeolocationRepository: deviceGeolocationRepository,
      comparingLectionsAndEntriesService: comparingLectionsAndEntriesService,
      statisticComputingServise: statisticComputingServise,
    );
  }
}

/// {@template firebase_lection_repo_factory}
/// Factory that creates an instance of [FirebaseLectionRepository].
/// {@endtemplate}
class FirebaseLectionRepositoryFactory
    extends Factory<FirebaseLectionRepository> {
  /// {@macro firebase_lection_repo_factory}

  @override
  FirebaseLectionRepository create() {
    return FirebaseLectionRepository();
  }
}

/// {@template firebase_entry_repo_factory}
/// Factory that creates an instance of [FirebaseEntryRepository].
/// {@endtemplate}
class FirebaseEntryRepositoryFactory extends Factory<FirebaseEntryRepository> {
  /// {@macro firebase_entry_repo_factory}

  @override
  FirebaseEntryRepository create() {
    return FirebaseEntryRepository();
  }
}

/// {@template device_geolocation_repo_factory}
/// Factory that creates an instance of [DeviceGeolocationRepository].
/// {@endtemplate}
class DeviceGeolocationRepositoryFactory
    extends Factory<DeviceGeolocationRepository> {
  /// {@macro fdevice_geolocation_repo_factory}

  @override
  DeviceGeolocationRepository create() {
    return DeviceGeolocationRepository();
  }
}

/// {@template comparing_service_factory}
/// Factory that creates an instance of [ComparingLectionsAndEntriesService].
/// {@endtemplate}
class ComparingLectionsAndEntriesServiceFactory
    extends Factory<ComparingLectionsAndEntriesService> {
  /// {@macro comparing_service_factory}

  @override
  ComparingLectionsAndEntriesService create() {
    return ComparingLectionsAndEntriesService();
  }
}

/// {@template statistic_computing_servise_factory}
/// Factory that creates an instance of [StatisticComputingServise].
/// {@endtemplate}
class StatisticComputingServiseFactory
    extends Factory<StatisticComputingServise> {
  /// {@macro statistic_computing_servise_factory}

  @override
  StatisticComputingServise create() {
    return StatisticComputingServise();
  }
}

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
final class AppCompositionResult {
  /// {@macro composition_result}
  const AppCompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies container
  final AppDependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$AppCompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class StudentAppCompositionResult {
  /// {@macro composition_result}
  const StudentAppCompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies container
  final StudentDependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$AppCompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
