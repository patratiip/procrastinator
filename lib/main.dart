import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:procrastinator/ui/widgets/app/procrastinator.dart';
import 'package:procrastinator/ui/widgets/app/procrastinator_model.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final model = ProcrastinatorModel();
  await model.checkAuth();
  final db = FirebaseFirestore.instance;

  runApp(Procrastinator(model: model));
}
