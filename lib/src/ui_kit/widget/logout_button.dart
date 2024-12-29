import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/platform/auth/bloc/authentication_bloc.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

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
