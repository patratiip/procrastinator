import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProcrastinatorModel {
  var _isAuth = false;
  bool get isAuth => _isAuth;

  final currentUser = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;

  Future<void> checkAuth() async {
    final user = FirebaseAuth.instance.currentUser;
    _isAuth = user != null;
    print(user);
  }
}
