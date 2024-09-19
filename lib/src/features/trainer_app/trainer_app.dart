import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/features/trainer_app/trainer_app_scope.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/logout_button.dart';

class TrainerApp extends StatelessWidget {
  const TrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppScopeScope.userOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainer App'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('User email: ${AppScopeScope.userOf(context).email}'),
            Text('User name: ${AppScopeScope.userOf(context).name}'),
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
