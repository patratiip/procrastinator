import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/management_app/main_screen/group_list/group_list.dart';
import 'package:procrastinator/src/features/management_app/management_app_view.dart';
import 'package:procrastinator/src/core/di/scopes/management_scope.dart';

class ManagementApp extends StatelessWidget {
  const ManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupListBloc>(
      create: (context) => GroupListBloc(
          groupRepository:
              ManagementAppScope.depOf(context).firebaseGroupRepository),
      child: const ManagementAppView(),
    );
  }
}
