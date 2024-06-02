import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/auth/data/auth_model_peter.dart';
import '../../features/auth/presentation/auth_screen_peter.dart';
import '../../features/auth/presentation/register_screeen_peter.dart';
import '../../features/student_main/home_page_student/4_student_profile_page/profile_second_pages/profile_secondary_page.dart';
import '../../features/student_main/student_main_screen.dart';

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
          child: const SignInScreen(),
        ),
    MainNavigationRoutes.registration: (context) => PeterAuthProvider(
          model: PeterAuthModel(),
          child: const RegisterScreen(),
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
