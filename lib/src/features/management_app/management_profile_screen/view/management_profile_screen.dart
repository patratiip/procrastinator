import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/di/scopes/app_dependencies_scope.dart';
import 'package:procrastinator/src/core/di/scopes/management_scope.dart';
import 'package:procrastinator/src/shared/view/components/logout_button.dart';

class ManagementProfileScreen extends StatelessWidget {
  const ManagementProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AppScope.userOf(context);

    return Center(
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
    );
  }
}
