import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/features/management_app/management_app.dart';
import 'package:procrastinator/src/features/management_app/management_scope.dart';
import 'package:procrastinator/src/features/student_app/student_app.dart';
import 'package:procrastinator/src/features/student_app/student_app_scope.dart';
import 'package:procrastinator/src/features/trainer_app/trainer_app.dart';
import 'package:procrastinator/src/features/trainer_app/trainer_app_scope.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/logout_button.dart';
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

          //Undefined User type
        } else if (state.user!.userType == UserType.undefined) {
          return const _UndefinedUserStatusScreen();

          //Default screen
        } else {
          return const _DefaultAppScreen();
        }
      }),
    );
  }
}

class _UndefinedUserStatusScreen extends StatelessWidget {
  const _UndefinedUserStatusScreen({super.key});

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
                Text(
                    'User email: ${state.user!.email}'),
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
  const _DefaultAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            color: MyAppColorScheme.primary,
          ),
        ),
      ),
    );
  }
}
