import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/bloc_observer.dart';
import 'package:procrastinator/src/core/app/view/procrastinator.dart';
import 'package:procrastinator/src/core/di/di_container.dart';
import 'package:user_repository/user_repository.dart';
import 'firebase_options.dart';

GetIt locator = GetIt.instance;

Future<void> main() async {
  //Init
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Bloc Observer
  Bloc.observer = const AppBlocObserver();
  //Dependencies
  initGetIt();
  //Auth Repo
  final userRepository = FirebaseUserRepository();
  await userRepository.user.first;

  runApp(ProcrastinatorApp(userRepository));
}
