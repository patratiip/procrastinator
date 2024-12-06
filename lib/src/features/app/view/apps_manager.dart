import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:user_repository/user_repository.dart';

import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/management_app/di/management_scope.dart';
import 'package:procrastinator/src/features/student_app/di/student_app_scope.dart';
import 'package:procrastinator/src/features/trainer_app/di/trainer_app_scope.dart';
import 'package:procrastinator/src/features/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/features/management_app/management_app.dart';
import 'package:procrastinator/src/features/student_app/student_app.dart';
import 'package:procrastinator/src/features/trainer_app/trainer_app.dart';
import 'package:procrastinator/src/shared/view/widgets/logout_button.dart';

class AppsManager extends StatelessWidget {
  const AppsManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: ((context, state) => switch (state.user!.userType) {
            // Student App
            UserType.student => const StudentAppScope(child: StudentApp()),
            // Managemet App
            UserType.management =>
              const ManagementAppScope(child: ManagementApp()),
            //Trainer App
            UserType.trainer => const TrainerAppScope(child: TrainerApp()),
            // Undefined User type
            UserType.undefined => const _UndefinedUserStatusScreen(),
            // Default screen
            UserType.initial => const _DefaultAppScreen()
          }),
    );
  }
}

class _UndefinedUserStatusScreen extends StatelessWidget {
  const _UndefinedUserStatusScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Localization.of(context)
                .authenticationUserTypeErrorScreeenText),
          ),
          body: Center(
            child: Column(
              children: [
                Text('User email: ${state.user!.email}'),
                Text(state.user!.userType.toString()),
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
      },
    );
  }
}

class _DefaultAppScreen extends StatelessWidget {
  const _DefaultAppScreen();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).canvasColor,
        child: const Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: MyAppColorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
