import 'package:flutter/material.dart';
import 'package:procrastinator/src/platform/app/di/app_scope.dart';
import 'package:procrastinator/src/app_trainer/di/trainer_app_scope.dart';
import 'package:procrastinator/src/ui_kit/widget/logout_button.dart';

class TrainerApp extends StatelessWidget {
  const TrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppScope.userOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainer App'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('User email: ${AppScope.userOf(context).email}'),
            Text('User name: ${AppScope.userOf(context).name}'),
            Text(user.userType.toString()),
            Text(TrainerAppScope.of(context)
                .trainerDependenciesContainer
                .firebaseLectionRepository
                .toString()),
            const Padding(
              padding: EdgeInsets.all(16),
              child: LogOutButton(),
            ),
          ],
        ),
      ),
    );
  }
}
