import 'package:firebase_auth/firebase_auth.dart';

class ProcrastinatorModel {
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final user = FirebaseAuth.instance.currentUser;
    _isAuth = user != null;
    print(user);
  }
}
