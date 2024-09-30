import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/features/management_app/management_scope.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/logout_button.dart';

class ManagementApp extends StatelessWidget {
  const ManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppScope.userOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Management App'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('User email: ${user.email}'),
            Text('User name: ${user.name}'),
            Text(user.userType.toString()),
            Text(ManagementAppScope.of(context)
                .managementDependenciesContainer
                .firebaseEntryRepository
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
