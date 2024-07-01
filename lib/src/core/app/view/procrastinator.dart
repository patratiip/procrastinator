import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/app/app.dart';
import 'package:procrastinator/src/core/styles/theme/theme.dart';

class Procrastinator extends StatelessWidget {
  const Procrastinator({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const ProcrastinatorView(),
      ),
    );
  }
}

class ProcrastinatorView extends StatelessWidget {
  const ProcrastinatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Procrastinator',

      //THEME
      theme: MyAppThemeLight.themeLight,
      darkTheme: MyAppThemeDark.darkTheme,
      home: FlowBuilder<AuthStatus>(
        state: context.select((AuthBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}







// class Procrastinator extends StatelessWidget {
//   final ProcrastinatorModel model;
//   static final mainNavigation = MainNavigation();

//   const Procrastinator({super.key, required this.model});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
      // debugShowCheckedModeBanner: false,
      // title: 'Procrastinator',

      // //THEME
      // theme: MyAppThemeLight.themeLight,
      // darkTheme: MyAppThemeDark.darkTheme,

//       //ROUTING
//       initialRoute: mainNavigation.initialRoute(model.isAuth),
//       routes: mainNavigation.routes,
//       onGenerateRoute: mainNavigation.onGenerateRoute,
//     );
//   }
// }
