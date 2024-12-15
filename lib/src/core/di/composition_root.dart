// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clock/clock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:group_repository/group_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:procrastinator/src/features/initialization/model/environment.dart';
import 'package:procrastinator/src/features/student_app/features/entries/data/entry_repository.dart';
import 'package:procrastinator/src/features/student_app/features/entries/data/firebase_entry_data_provider.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/data/entry_adding_data_provider.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/data/entry_adding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/constant/firebase_collections_constants.dart';
import 'package:procrastinator/src/core/utils/error_tracking_manager/error_tracking_manager.dart';
import 'package:procrastinator/src/core/utils/logger.dart';
import 'package:procrastinator/src/features/app/di/app_dependencies_container.dart';
import 'package:procrastinator/src/features/management_app/di/management_dependencies_container.dart';
import 'package:procrastinator/src/features/settings/bloc/app_settings_bloc.dart';
import 'package:procrastinator/src/features/settings/data/app_settings_datasource.dart';
import 'package:procrastinator/src/features/settings/data/settings_repository.dart';
import 'package:procrastinator/src/features/student_app/features/statistic/service/statistic_computing_service.dart';
import 'package:procrastinator/src/features/student_app/di/student_dependencies_container.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/data/firebase_lection_data_provider.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/data/lection_repository.dart';
import 'package:procrastinator/src/features/trainer_app/di/trainer_dependencies_container.dart';

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
  final Logger logger;

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
        StudentDependenciesFactory(config, currentUser).create();
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
        ManagementDependenciesFactory(config, currentUser).create();
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
        TrainerDependenciesFactory(config, currentUser).create();
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
  final Logger logger;

  @override
  Future<AppDependenciesContainer> create() async {
    final sharedPreferences = SharedPreferencesAsync();

    final packageInfo = await PackageInfo.fromPlatform();
    final errorTrackingManager =
        await ErrorTrackingManagerFactory(config, logger).create();
    final userRepository = FirebaseUserRepositoryFactory().create();

    final settingsBloc = await SettingsBlocFactory(sharedPreferences).create();

    return AppDependenciesContainer(
        logger: logger,
        config: config,
        userRepository: userRepository,
        appSettingsBloc: settingsBloc,
        errorTrackingManager: errorTrackingManager,
        packageInfo: packageInfo);
  }
}

/// {@template settings_bloc_factory}
/// Factory that creates an instance of [AppSettingsBloc].
/// {@endtemplate}
class SettingsBlocFactory extends AsyncFactory<AppSettingsBloc> {
  /// {@macro settings_bloc_factory}
  SettingsBlocFactory(this.sharedPreferences);

  /// Shared preferences instance
  final SharedPreferencesAsync sharedPreferences;

  @override
  Future<AppSettingsBloc> create() async {
    final appSettingsRepository = AppSettingsRepositoryImpl(
      datasource:
          AppSettingsDatasourceImpl(sharedPreferences: sharedPreferences),
    );

    final appSettings = await appSettingsRepository.getAppSettings();
    final initialState = AppSettingsState.idle(appSettings: appSettings);

    return AppSettingsBloc(
      appSettingsRepository: appSettingsRepository,
      initialState: initialState,
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
    return FirebaseUserRepository();
  }
}

//////////////////////////STUDENT APP////////////////////////////////////////

/// {@template student_dependencies_factory}
/// Factory that creates an instance of [StudentDependenciesContainer].
/// {@endtemplate}
class StudentDependenciesFactory extends Factory<StudentDependenciesContainer> {
  /// {@macro student_dependencies_factory}
  StudentDependenciesFactory(this.config, this.currentUser);

  /// Application configuration
  final Config config;

  /// Current authenticated user
  final MyUser currentUser;

  @override
  StudentDependenciesContainer create() {
    final entryRepository =
        EntryRepositoryFactory(currentUser.userId, config).create();
    final lectionRepository = LectionRepositoryFactory(config).create();
    final entryAddingRepository =
        EntryAddingRepositoryFactory(currentUser.userId, config).create();
    final firebaseGroupRepository =
        FirebaseGroupRepositoryFactory(groupId: currentUser.group).create();
    final deviceGeolocationRepository =
        DeviceGeolocationRepositoryFactory().create();

    final statisticComputingServise =
        StatisticComputingServiseFactory().create();

    return StudentDependenciesContainer(
      entryRepository: entryRepository,
      lectionRepository: lectionRepository,
      entryAddingRepository: entryAddingRepository,
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
  TrainerDependenciesFactory(this.config, this.currentUser);

  /// Application configuration
  final Config config;

  /// Current authenticated user
  final MyUser currentUser;

  @override
  TrainerDependenciesContainer create() {
    final firebaseLectionRepository = LectionRepositoryFactory(config).create();
    final firebaseGroupRepository =
        FirebaseTrainerGroupRepositoryFactory().create();

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
  ManagementDependenciesFactory(this.config, this.currentUser);

  /// Application configuration
  final Config config;

  /// Current authenticated user
  final MyUser currentUser;

  @override
  ManagementDependenciesContainer create() {
    //TODO: Change repo for managers,
    //he mut to take a students collections
    //references to read entries data
    final firebaseEntryRepository =
        EntryRepositoryFactory(currentUser.userId, config).create();
    final firebaseLectionRepository = LectionRepositoryFactory(config).create();
    final statisticComputingServise =
        StatisticComputingServiseFactory().create();
    final firebaseGroupRepository =
        FirebaseManagementGroupRepositoryFactory().create();

    return ManagementDependenciesContainer(
      firebaseEntryRepository: firebaseEntryRepository,
      firebaseLectionRepository: firebaseLectionRepository,
      statisticComputingServise: statisticComputingServise,
      firebaseGroupRepository: firebaseGroupRepository,
    );
  }
}

/// {@template lection_repo_factory}
/// Factory that creates an instance of [LectionRepositoryImpl].
/// {@endtemplate}
class LectionRepositoryFactory extends Factory<LectionRepositoryImpl> {
  /// {@macro lection_repo_factory}
  LectionRepositoryFactory(this.config);

  /// Application configuration
  final Config config;

  @override
  LectionRepositoryImpl create() {
    /// Getting lections collection name depend on enviroment
    final String collectionName = switch (config.environment) {
      Environment.dev => DevFirebaseCollectionsConstants.lections,
      Environment.staging => StagingFirebaseCollectionsConstants.lections,
      Environment.prod => ProdFirebaseCollectionsConstants.lections,
    };

    /// Making [CollectionReference] for [LectionFirebaseDataProviderImpl]
    /// depend on app flavour
    final lectionsCollectionRef =
        FirebaseFirestore.instance.collection(collectionName);

    return LectionRepositoryImpl(
        lectionDataProvider: LectionFirebaseDataProviderImpl(
            collectionRef: lectionsCollectionRef));
  }
}

/// {@template firebase_entry_repo_factory}
/// Factory that creates an instance of [EntryRepositoryImpl].
/// {@endtemplate}
class EntryRepositoryFactory extends Factory<EntryRepositoryImpl> {
  /// {@macro firebase_entry_repo_factory}
  EntryRepositoryFactory(this.currentUser, this.config);

  /// Current user collection reference
  final String currentUser;

  /// Application configuration
  final Config config;

  @override
  EntryRepositoryImpl create() {
    /// Getting users collection name depend on enviroment
    final String usersCollectionName = switch (config.environment) {
      Environment.dev => DevFirebaseCollectionsConstants.users,
      Environment.staging => StagingFirebaseCollectionsConstants.users,
      Environment.prod => ProdFirebaseCollectionsConstants.users,
    };

    /// Getting entries collection name depend on enviroment
    final String entriesCollectionName = switch (config.environment) {
      Environment.dev => DevFirebaseCollectionsConstants.userEntries,
      Environment.staging => StagingFirebaseCollectionsConstants.userEntries,
      Environment.prod => ProdFirebaseCollectionsConstants.userEntries,
    };

    /// Making [CollectionReference] for [EntryFirebaseDataProviderImpl]
    /// depend on app flavour and current user

    final entriesCollectionRef = FirebaseFirestore.instance
        .collection(usersCollectionName)
        .doc(currentUser)
        .collection(entriesCollectionName);

    return EntryRepositoryImpl(
        entryDataProvider:
            EntryFirebaseDataProviderImpl(collectionRef: entriesCollectionRef));
  }
}

/// {@template firebase_entry_adding_repo_factory}
/// Factory that creates an instance of [EntryAddingRepositoryImpl].
/// {@endtemplate}
class EntryAddingRepositoryFactory extends Factory<EntryAddingRepositoryImpl> {
  /// {@macro firebase_entry_adding_repo_factory}
  EntryAddingRepositoryFactory(this.currentUser, this.config);

  /// Current user collection reference
  final String currentUser;

  /// Application configuration
  final Config config;

  @override
  EntryAddingRepositoryImpl create() {
    /// Getting lections collection name depend on enviroment
    final String collectionName = switch (config.environment) {
      Environment.dev => DevFirebaseCollectionsConstants.lections,
      Environment.staging => StagingFirebaseCollectionsConstants.lections,
      Environment.prod => ProdFirebaseCollectionsConstants.lections,
    };

    /// Getting users collection name depend on enviroment
    final String usersCollectionName = switch (config.environment) {
      Environment.dev => DevFirebaseCollectionsConstants.users,
      Environment.staging => StagingFirebaseCollectionsConstants.users,
      Environment.prod => ProdFirebaseCollectionsConstants.users,
    };

    /// Getting entries collection name depend on enviroment
    final String entriesCollectionName = switch (config.environment) {
      Environment.dev => DevFirebaseCollectionsConstants.userEntries,
      Environment.staging => StagingFirebaseCollectionsConstants.userEntries,
      Environment.prod => ProdFirebaseCollectionsConstants.userEntries,
    };

    /// Making [CollectionReference] for [LectionFirebaseDataProviderImpl]
    /// depend on app flavour
    final lectionsCollectionRef =
        FirebaseFirestore.instance.collection(collectionName);

    /// Making [CollectionReference] for [EntryFirebaseDataProviderImpl]
    /// depend on app flavour and current user

    final entriesCollectionRef = FirebaseFirestore.instance
        .collection(usersCollectionName)
        .doc(currentUser)
        .collection(entriesCollectionName);

    return EntryAddingRepositoryImpl(
        entryAddingDataProvider: EntryAddingFirebaseDataProviderImpl(
      lectionsCollectionRef: lectionsCollectionRef,
      entriesCollectionRef: entriesCollectionRef,
    ));
  }
}

/// {@template firebase_student_group_repo_factory}
/// Factory that creates an instance of [FirebaseStudentGroupRepository].
/// {@endtemplate}
class FirebaseGroupRepositoryFactory extends Factory<IStudentGroupRepository> {
  /// {@macro firebase_student_group_repo_factory}
  FirebaseGroupRepositoryFactory({this.groupId});

  String? groupId;

  @override
  IStudentGroupRepository create() {
    return FirebaseStudentGroupRepository(groupID: groupId!);
  }
}

/// {@template firebase_management_group_repo_factory}
/// Factory that creates an instance of [FirebaseManagementGroupRepository].
/// {@endtemplate}
class FirebaseManagementGroupRepositoryFactory
    extends Factory<IManagementGroupRepository> {
  /// {@macro firebase_management_group_repo_factory}
  FirebaseManagementGroupRepositoryFactory();

  @override
  IManagementGroupRepository create() {
    return FirebaseManagementGroupRepository();
  }
}

/// {@template firebase_trainer_group_repo_factory}
/// Factory that creates an instance of [FirebaseTrainerGroupRepository].
/// {@endtemplate}
class FirebaseTrainerGroupRepositoryFactory
    extends Factory<ITrainerGroupRepository> {
  /// {@macro firebase_trainer_group_repo_factory}
  FirebaseTrainerGroupRepositoryFactory();

  @override
  ITrainerGroupRepository create() {
    return FirebaseTrainerGroupRepository();
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
  final Logger logger;

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
