import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:procrastinator/src/features/app/data/procrastinator.dart';
import 'package:procrastinator/src/features/app/data/procrastinator_model.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final model = ProcrastinatorModel();
  await model.checkAuth();

  runApp(Procrastinator(model: model));
}
