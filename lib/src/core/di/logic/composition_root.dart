import 'package:clock/clock.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:group_repository/group_repository.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/di/dependenies_containers/app_dependencies_container.dart';
import 'package:procrastinator/src/core/di/dependenies_containers/management_dependencies_container.dart';
import 'package:procrastinator/src/core/di/dependenies_containers/student_dependencies_container.dart';
import 'package:procrastinator/src/core/di/dependenies_containers/trainer_dependencies_container.dart';
import 'package:procrastinator/src/core/utils/refined_logger.dart';
import 'package:procrastinator/src/features/initialization/logic/error_tracking_manager.dart';
import 'package:procrastinator/src/features/student_app/2_statistic_screen/service/statistic_computing_service.dart';
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
  StudentAppCompositionResult composeStudentDependencies(MyUser currentUser) {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing Student dependencies...');
    // initialize dependencies
    final dependencies =
        StudentDependenciesFactory(config, logger, currentUser).create();
    logger.info('Student dependencies initialized');

    stopwatch.stop();
    final result = StudentAppCompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );

    return result;
  }

  /// Composes dependencies for Management App and returns result of composition.
  ManagementAppCompositionResult composeManagementDependencies(
      MyUser currentUser) {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing Management dependencies...');
    // initialize dependencies
    final dependencies =
        ManagementDependenciesFactory(config, logger, currentUser).create();
    logger.info('Management dependencies initialized');

    stopwatch.stop();
    final result = ManagementAppCompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );

    return result;
  }

  /// Composes dependencies for Trainer App and returns result of composition.
  TrainerAppCompositionResult composeTrainerDependencies(MyUser currentUser) {
    final stopwatch = clock.stopwatch()..start();

    logger.info('Initializing Trainer dependencies...');
    // initialize dependencies
    final dependencies =
        TrainerDependenciesFactory(config, logger, currentUser).create();
    logger.info('Trainer dependencies initialized');

    stopwatch.stop();
    final result = TrainerAppCompositionResult(
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

  /// Creates an instance of [T].
  // T createWithParam(dynamic parameter);
}

/// {@template async_factory}
/// Factory that creates an instance of [T] asynchronously.
/// {@endtemplate}
abstract class AsyncFactory<T> {
  /// Creates an instance of [T].
  Future<T> create();

  /// Creates an instance of [T].
  // Future<T> createWithParam(dynamic parameter);
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
    final errorTrackingManager =
        await ErrorTrackingManagerFactory(config, logger).create();
    final userRepository = FirebaseUserRepositoryFactory().create();
    // final authenticationbloc =
    //     AuthenticationBlocFactory(userRepository).create();

    return AppDependenciesContainer(
      userRepository: userRepository,
      // authenticationbloc: authenticationbloc,
      errorTrackingManager: errorTrackingManager,
    );
  }
}

/// {@template firebase_user_repo_factory}
/// Factory that creates an instance of [FirebaseUserRepository].
/// {@endtemplate}
class FirebaseUserRepositoryFactory extends Factory<FirebaseUserRepository> {
  /// {@macro firebase_user_repo_factory}

  @override
  FirebaseUserRepository create() {
    ///Auth Repo
    final userRepository = FirebaseUserRepository();
    return userRepository;
  }
}

// /// {@template authentication_bloc_factory}
// /// Factory that creates an instance of [FirebaseUserRepository].
// /// {@endtemplate}
// class AuthenticationBlocFactory extends Factory<AuthenticationBloc> {
//   /// {@macro authentication_bloc_factory}
//   AuthenticationBlocFactory(this.userRepository);

//   ///Auth Repo
//   final FirebaseUserRepository userRepository;

//   @override
//   AuthenticationBloc create() {
//     ///Auth Bloc
//     final authBloc =
//         AuthenticationBloc(authenticationRepository: userRepository);
//     return authBloc;
//   }
// }

//////////////////////////STUDENT APP////////////////////////////////////////

/// {@template student_dependencies_factory}
/// Factory that creates an instance of [StudentDependenciesContainer].
/// {@endtemplate}
class StudentDependenciesFactory extends Factory<StudentDependenciesContainer> {
  /// {@macro student_dependencies_factory}
  StudentDependenciesFactory(this.config, this.logger, this.currentUser);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  final MyUser currentUser;

  @override
  StudentDependenciesContainer create() {
    final firebaseEntryRepository =
        FirebaseEntryRepositoryFactory(currentUser.userId).create();
    final firebaseLectionRepository =
        FirebaseLectionRepositoryFactory().create();
    final firebaseGroupRepository = FirebaseGroupRepositoryFactory(
            currentUser.userType,
            groupId: currentUser.group)
        .create();
    final deviceGeolocationRepository =
        DeviceGeolocationRepositoryFactory().create();

    final statisticComputingServise =
        StatisticComputingServiseFactory().create();

    return StudentDependenciesContainer(
      firebaseEntryRepository: firebaseEntryRepository,
      firebaseLectionRepository: firebaseLectionRepository,
      firebaseGroupRepository: firebaseGroupRepository,
      deviceGeolocationRepository: deviceGeolocationRepository,
      statisticComputingServise: statisticComputingServise,
    );
  }
}

//////////////////////////Trainer APP////////////////////////////////////////

/// {@template Trainer_dependencies_factory}
/// Factory that creates an instance of [TrainerDependenciesContainer].
/// {@endtemplate}
class TrainerDependenciesFactory extends Factory<TrainerDependenciesContainer> {
  /// {@macro Trainer_dependencies_factory}
  TrainerDependenciesFactory(this.config, this.logger, this.currentUser);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  final MyUser currentUser;

  @override
  TrainerDependenciesContainer create() {
    final firebaseLectionRepository =
        FirebaseLectionRepositoryFactory().create();
    final firebaseGroupRepository =
        FirebaseGroupRepositoryFactory(currentUser.userType).create();

    return TrainerDependenciesContainer(
      firebaseLectionRepository: firebaseLectionRepository,
      firebaseGroupRepository: firebaseGroupRepository,
    );
  }
}

//////////////////////////Management APP////////////////////////////////////////

/// {@template management_dependencies_factory}
/// Factory that creates an instance of [ManagementDependenciesContainer].
/// {@endtemplate}
class ManagementDependenciesFactory
    extends Factory<ManagementDependenciesContainer> {
  /// {@macro management_dependencies_factory}
  ManagementDependenciesFactory(this.config, this.logger, this.currentUser);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final RefinedLogger logger;

  final MyUser currentUser;

  @override
  ManagementDependenciesContainer create() {
    final firebaseEntryRepository =
        FirebaseEntryRepositoryFactory(currentUser.userId).create();
    final firebaseLectionRepository =
        FirebaseLectionRepositoryFactory().create();
    final statisticComputingServise =
        StatisticComputingServiseFactory().create();
    final firebaseGroupRepository =
        FirebaseGroupRepositoryFactory(currentUser.userType).create();

    return ManagementDependenciesContainer(
      firebaseEntryRepository: firebaseEntryRepository,
      firebaseLectionRepository: firebaseLectionRepository,
      statisticComputingServise: statisticComputingServise,
      firebaseGroupRepository: firebaseGroupRepository,
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
  FirebaseEntryRepositoryFactory(this.currentUser);
  final String currentUser;

  @override
  FirebaseEntryRepository create() {
    return FirebaseEntryRepository(currentUser: currentUser);
  }
}

/// {@template firebase_group_repo_factory}
/// Factory that creates an instance of [FirebaseManagementGroupRepository].
/// {@endtemplate}
class FirebaseGroupRepositoryFactory extends Factory<IGroupRepository> {
  /// {@macro firebase_group_repo_factory}
  FirebaseGroupRepositoryFactory(this.userType, {this.groupId});

  UserType userType;

  String? groupId;

  @override
  IGroupRepository create() {
    if (userType == UserType.management) {
      return FirebaseManagementGroupRepository();
    } else if (userType == UserType.trainer) {
      return FirebaseTrainerGroupRepository();
    } else {
      return FirebaseStudentGroupRepository(groupID: groupId!);
    }
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

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class ManagementAppCompositionResult {
  /// {@macro composition_result}
  const ManagementAppCompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies container
  final ManagementDependenciesContainer dependencies;

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
final class TrainerAppCompositionResult {
  /// {@macro composition_result}
  const TrainerAppCompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies container
  final TrainerDependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$AppCompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
