import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/features/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/features/management_app/management_app.dart';
import 'package:procrastinator/src/features/management_app/management_scope.dart';
import 'package:procrastinator/src/features/student_app/student_app.dart';
import 'package:procrastinator/src/features/student_app/student_app_scope.dart';
import 'package:procrastinator/src/features/trainer_app/trainer_app.dart';
import 'package:procrastinator/src/features/trainer_app/trainer_app_scope.dart';
import 'package:procrastinator/src/shared/view/components/logout_button.dart';
import 'package:user_repository/user_repository.dart';

class AppsManager extends StatelessWidget {
  const AppsManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: ((context, state) {
        //Student App
        if (state.user!.userType == UserType.student) {
          return const StudentAppScope(child: StudentApp());

          //Managemet App
        } else if (state.user!.userType == UserType.management) {
          return const ManagementAppScope(child: ManagementApp());

          //Trainer App
        } else if (state.user!.userType == UserType.trainer) {
          return const TrainerAppScope(child: TrainerApp());

          //Login
        } else {
          return const _UndefinedUserStatusScreen();
        }
      }),
    );
  }
}

class _UndefinedUserStatusScreen extends StatelessWidget {
  const _UndefinedUserStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            Localization.of(context).authenticationUserTypeErrorScreeenText),
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
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(Localization.of(context).userTypeLoginError),
            ),
            const SizedBox(height: 100),
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
