import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/src/features/auth/domain/firebase_service.dart';
import 'package:procrastinator/src/core/router/main_navigation.dart';
import 'package:procrastinator/src/features/app/data/procrastinator_model.dart';



import '../../../core/styles/app_theme_dark.dart';
import '../../../core/styles/app_theme_light.dart';

class Procrastinator extends StatelessWidget {
  final ProcrastinatorModel model;
  static final mainNavigation = MainNavigation();

  const Procrastinator({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Procrastinator',

      //THEME
      theme: MyAppThemeLight.themeLight,
      darkTheme: MyAppThemeDark.darkTheme,

      //ROUTING
      initialRoute: mainNavigation.initialRoute(model.isAuth),
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
