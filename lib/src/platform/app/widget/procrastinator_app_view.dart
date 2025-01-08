import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:procrastinator/main.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';

import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/platform/auth/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/platform/app/widget/apps_manager.dart';
import 'package:procrastinator/src/platform/auth/login/widget/login_screen.dart';
import 'package:procrastinator/src/platform/initialization/model/app_theme.dart';
import 'package:procrastinator/src/platform/settings/di/settings_scope.dart';

class ProcrastinatorAppView extends StatelessWidget {
  const ProcrastinatorAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.settingsOf(context);

    return StoreProvider<ReduxAppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Procrastinator',

        // Locale from settins scope
        locale: settings.locale,
        localizationsDelegates: _localizationsDelegates,
        supportedLocales: Localization.delegate.supportedLocales,

        // Theme
        theme:
            settings.appTheme?.lightTheme ?? AppTheme.defaultTheme.lightTheme,
        darkTheme:
            settings.appTheme?.darkTheme ?? AppTheme.defaultTheme.darkTheme,
        themeMode: settings.appTheme?.themeMode ?? ThemeMode.system,

        // App
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: ((context, state) {
            // App Manager
            if (state.status == AuthenticationStatus.authenticated) {
              return const AppsManager();

              // Login screen
            } else {
              return const LoginScreen();
            }
          }),
        ),
      ),
    );
  }
}

const _localizationsDelegates = <LocalizationsDelegate<Object>>[
  Localization.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
