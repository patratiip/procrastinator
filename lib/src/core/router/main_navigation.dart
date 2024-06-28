import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/src/features/auth/sign_up/view/sign_up_screen.dart';

import '../../features/auth/data/auth_model_peter.dart';
import '../../features/auth/login/view/login_screen.dart';
import '../../features/student_app/home_page_student/4_student_profile_page/profile_second_pages/profile_secondary_page.dart';
import '../../features/student_app/student_main_screen.dart';

abstract class MainNavigationRoutes {
  static const auth = 'auth';
  static const registration = 'register';

  static const mainScreen = '/';
  static const profileSecondary = '/';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      // (FirebaseAuth.instance.currentUser != null)
      ? MainNavigationRoutes.mainScreen
      : MainNavigationRoutes.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutes.auth: (context) => PeterAuthProvider(
          model: PeterAuthModel(),
          child: const LoginScreen(),
        ),
    MainNavigationRoutes.registration: (context) => PeterAuthProvider(
          model: PeterAuthModel(),
          child: const SignUpScreen(),
        ),
    MainNavigationRoutes.mainScreen: (context) => StudentMainScreenWidget()
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRoutes.profileSecondary:
        final arguments = settings.arguments;
        final pageID = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: ((context) => ProfileSecondaryPage(
                  pageID: pageID,
                )));

      default:
        const widget = Scaffold(body: Center(child: Text('error')));
        return MaterialPageRoute(builder: ((context) => widget));
    }
  }
}
