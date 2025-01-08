import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/business.dart';
import 'package:procrastinator/firebase_options.dart';
import 'package:procrastinator/main.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';
import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/di/composition_root.dart';
import 'package:procrastinator/src/core/utils/app_bloc_observer.dart';
import 'package:procrastinator/src/core/utils/logger.dart';
import 'package:procrastinator/src/platform/app/widget/procrastinator.dart';
import 'package:procrastinator/src/platform/initialization/widget/initialization_failed_app.dart';

/// {@template app_runner}
/// A class which is responsible for initialization and running the app.
/// {@endtemplate}
final class AppRunner {
  /// {@macro app_runner}

  const AppRunner();

  /// Start the initialization and in case of success run application
  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    // Preserve splash screen
    binding.deferFirstFrame();

    // Override logging
    FlutterError.onError = logger.logFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError =
        logger.logPlatformDispatcherError;

    // Setup bloc observer and transformer
    Bloc.observer = AppBlocObserver(logger);
    Bloc.transformer = bloc_concurrency.sequential();
    const config = Config();

    // Firebase initialization
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

////////////////////////////////////////////////////

// Moved to lib/business.dart
    // REDUX ASYNC: Creating initial App state
    // var store = Store<ReduxAppState>(
    //   initialState: ReduxAppState.initialState(),
    // );

    await Future.wait([
      Business.init(),
    ]);
    // Dependencies initializing
    // getIt.registerSingleton<AppModel>(AppModelImplementation());  // Example

////////////////////////////////////////////////////

    Future<void> initializeAndRun() async {
      try {
        final result =
            await CompositionRoot(config, logger).composeAppDependencies();

        // Attach this widget to the root of the tree.
        runApp(ProcrastinatorApp(result));
        //
      } catch (e, stackTrace) {
        logger.error('Initialization failed', error: e, stackTrace: stackTrace);
        runApp(
          InitializationFailedApp(
            error: e,
            stackTrace: stackTrace,
            retryInitialization: initializeAndRun,
          ),
        );
      } finally {
        // Allow rendering
        binding.allowFirstFrame();
      }
    }

    // Run the app
    await initializeAndRun();
  }
}
