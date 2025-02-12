import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:procrastinator/src/core/di/composition_root.dart';
import 'package:procrastinator/src/platform/app/di/app_scope.dart';
import 'package:procrastinator/src/platform/settings/di/settings_scope.dart';
import 'package:procrastinator/src/platform/auth/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/platform/app/widget/procrastinator_app_view.dart';

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
            child: const SettingsScope(
              child: ProcrastinatorAppView(),
            ),
          ),
        ),
      );
}
