import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/core/app/view/procrastinator_app_view.dart';
import 'package:user_repository/user_repository.dart';

class ProcrastinatorApp extends StatelessWidget {
  final UserRepository authenticationRepository;

  const ProcrastinatorApp(this.authenticationRepository, {super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
        authenticationRepository: authenticationRepository,
      ),
      child: const ProcrastinatorAppView(),
    );
  }
}
