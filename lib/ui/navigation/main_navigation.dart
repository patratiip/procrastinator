import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/domain/api_client/firebase_service.dart';

import '../widgets/auth/firebase_auth/fire_auth_screen/auth_model_peter.dart';
import '../widgets/auth/firebase_auth/fire_auth_screen/auth_screen_peter.dart';
import '../widgets/auth/firebase_auth/fire_auth_screen/register_screeen_peter.dart';
import '../widgets/student_main/home_page_student/4_student_profile_page/profile_second_pages/profile_secondary_page.dart';
import '../widgets/student_main/home_page_student/4_student_profile_page/student_profile_page_widget.dart';
import '../widgets/student_main/student_main_screen.dart';

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
          child: SignInScreen(),
        ),
    MainNavigationRoutes.registration: (context) => PeterAuthProvider(
          model: PeterAuthModel(),
          child: RegisterScreen(),
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
