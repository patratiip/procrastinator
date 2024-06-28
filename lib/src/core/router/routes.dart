import 'package:flutter/widgets.dart';
import 'package:procrastinator/src/core/app/app.dart';
import 'package:procrastinator/src/features/auth/login/view/login_screen.dart';
import 'package:procrastinator/src/features/student_app/student_main_screen.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AuthStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AuthStatus.authenticated:
      return [StudentMainScreenWidget.page()];
    case AuthStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
