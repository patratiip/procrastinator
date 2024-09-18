import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/features/trainer_app/trainer_app_scope.dart';
import 'package:procrastinator/src/shared/view/components/logout_button.dart';

class TrainerApp extends StatelessWidget {
  const TrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainer App'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(AppDependenciesScope.of(context)
                .userRepository
                .currentUser
                .email),
            Text(AppDependenciesScope.of(context)
                .currentUser
                .userType
                .toString()),
            Text(TrainerAppScope.of(context)
                .trainerDependenciesContainer
                .firebaseLectionRepository
                .toString()),
            const LogOutButton(),
          ],
        ),
      ),
    );
  }
}
