import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/di/logic/composition_root.dart';
import 'package:procrastinator/src/core/di/scopes/app_dependencies_scope.dart';
import 'package:procrastinator/src/features/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/features/app/view/procrastinator_app_view.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ProcrastinatorApp extends StatelessWidget {
  /// The result from the [CompositionRoot].
  final AppCompositionResult result;

  const ProcrastinatorApp(
    this.result, {
    super.key,
  });

  @override
  Widget build(BuildContext context) => DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: BlocProvider(
          create: (context) => AuthenticationBloc(
              authenticationRepository: result.dependencies.userRepository),
          child: AppScope(
            dependencies: result.dependencies,
            //TODO Implement SettingsScope
            child: const ProcrastinatorAppView(),
          ),
        ),
      );
}
