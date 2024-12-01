import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/di/scopes/settings_scope.dart';
import 'package:procrastinator/src/features/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/core/styles/theme/theme.dart';
import 'package:procrastinator/src/features/app/view/apps_manager.dart';
import 'package:procrastinator/src/features/auth/login/view/login_screen.dart';

class ProcrastinatorAppView extends StatelessWidget {
  const ProcrastinatorAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.settingsOf(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Procrastinator',
      localizationsDelegates: const [
        Localization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // Locale from settins scope
      locale: settings.locale,
      supportedLocales: Localization.delegate.supportedLocales,

      //THEME
      theme: MyAppThemeLight.themeLight,
      darkTheme: MyAppThemeDark.darkTheme,
      themeMode: settings.appTheme?.themeMode ?? ThemeMode.system,

      //
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: ((context, state) {
          //App Manager
          if (state.status == AuthenticationStatus.authenticated) {
            return const AppsManager();

            //Login
          } else {
            return const LoginScreen();
          }
        }),
      ),
    );
  }
}
