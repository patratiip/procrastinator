import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/old_files/bloc_observer.dart';
import 'package:procrastinator/src/core/utils/refined_logger.dart';
import 'package:procrastinator/src/features/app/view/procrastinator.dart';
import 'package:procrastinator/src/core/di/service_locator.dart';
import 'package:procrastinator/src/features/initialization/logic/app_runner.dart';
import 'package:user_repository/user_repository.dart';
import 'firebase_options.dart';

// GetIt locator = GetIt.instance;

void main() => runZonedGuarded(
      () => const AppRunner().initializeAndRun(),
      logger.logZoneError,
    );

// void main() async {
//   //Init
//   WidgetsFlutterBinding.ensureInitialized();
//   //Firebase initialization
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   //Bloc Observer
//   Bloc.observer = const AppBlocObserver();
//   //Dependencies
//   initGetIt();
//   //Auth Repo
//   final userRepository = FirebaseUserRepository();
//   await userRepository.user.first;

//   runApp(ProcrastinatorApp(userRepository));
// }
