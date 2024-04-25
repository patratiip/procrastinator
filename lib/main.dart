import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:procrastinator/ui/widgets/app/procrastinator.dart';
import 'package:procrastinator/ui/widgets/app/procrastinator_model.dart';

import 'domain/api_client/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final db = FirebaseFirestore.instance;

  final model = ProcrastinatorModel();
  await model.checkAuth();

  runApp(Procrastinator(model: model));
}
