import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/di/logic/composition_root.dart';
import 'package:procrastinator/src/core/di/model/app_dependencies_container.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/features/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/features/app/view/procrastinator_app_view.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:user_repository/user_repository.dart';

class ProcrastinatorApp extends StatelessWidget {


  /// The result from the [CompositionRoot].
  final CompositionResult result;

  const ProcrastinatorApp(
    
    this.result, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: AppDependenciesScope(
          dependencies: result.dependencies,
          //TODO Implement SettingsScope
          child: RepositoryProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              authenticationRepository: AppDependenciesScope.of(context).userRepository,
            ),
            child: const ProcrastinatorAppView(),
          ),
        ),
      );

  // @override
  // Widget build(BuildContext context) {
  //   return RepositoryProvider<AuthenticationBloc>(
  //     create: (context) => AuthenticationBloc(
  //       authenticationRepository: authenticationRepository,
  //     ),
  //     child: const ProcrastinatorAppView(),
  //   );
  // }
}
