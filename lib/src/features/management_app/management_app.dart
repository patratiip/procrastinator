import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/di/widget/management_dependencies_scope.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/app/app.dart';
import 'package:procrastinator/src/shared/view/components/logout_button.dart';

class ManagementApp extends StatelessWidget {
  const ManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Management App'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(ManagementDependenciesScope.of(context)
                .firebaseEntryRepository
                .currentUser),
            const LogOutButton(),
          ],
        ),
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            context
                .read<AuthenticationBloc>()
                .add(const AuthenticationLogOut());
          },
          style: const ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(MyAppColorScheme.errorColor)),
          child: Text(
            Localization.of(context).logOutButtonText,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  //fontWeight: FontWeight.w500
                ),
          )),
    );
  }
}
