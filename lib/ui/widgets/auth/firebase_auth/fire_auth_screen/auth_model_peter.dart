import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/ui/navigation/main_navigation.dart';

import '../../../../../domain/api_client/firebase_service.dart';

class PeterAuthModel extends ChangeNotifier {
  final _firebaseClient = FirebaseService();
  final emailTextController = TextEditingController();
  final passTextController = TextEditingController();
  final nameTextController = TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isAuthInProgress = false;
  bool get canUserAuth => !_isAuthInProgress;
  bool get isAuthInProgress => _isAuthInProgress;

  Future<void> auth(BuildContext context) async {
    final email = emailTextController.text;
    final password = passTextController.text;

    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Fill all fields';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthInProgress = true;
    notifyListeners();
    final sucsess = await _firebaseClient.onLogin(email: email, password: password);

    notifyListeners();
    Future.delayed(Duration(seconds: 1), () {
      _errorMessage = _firebaseClient.error?.message;
      if (_errorMessage == null) {
        Navigator.of(context).pushReplacementNamed(MainNavigationRoutes.mainScreen);
      } else {
        _isAuthInProgress = false;
        notifyListeners();
      }
    });
  }

  Future<void> register(BuildContext context) async {
    final email = emailTextController.text;
    final password = passTextController.text;
    final name = nameTextController.text;

    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      _errorMessage = 'Fill all fields';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthInProgress = true;
    notifyListeners();
    final sucsess = await _firebaseClient.onRegister(
        email: email, password: password, displayName: name);

    notifyListeners();

    Future.delayed(Duration(seconds: 1), () {
      _errorMessage = _firebaseClient.error?.message;
      if (_errorMessage == null) {
        Navigator.of(context).pushReplacementNamed(MainNavigationRoutes.mainScreen);
      } else {
        _isAuthInProgress = false;
        notifyListeners();
      }
    });
  }

  Future<void> resetPassword(BuildContext context) async {
    final email = emailTextController.text;

    if (email.isEmpty) {
      _errorMessage = 'Fill email field';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _isAuthInProgress = true;
    notifyListeners();
    await _firebaseClient.onPasswordReseting(email: email);
    Future.delayed(Duration(seconds: 1), () {
      _errorMessage = _firebaseClient.error?.message;
      _isAuthInProgress = false;
      notifyListeners();
    });
  }
}

class PeterAuthProvider extends InheritedNotifier {
  final PeterAuthModel model;

  const PeterAuthProvider({
    super.key,
    required this.model,
    required super.child,
  }) : super(notifier: model);

  static PeterAuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PeterAuthProvider>();
  }

  static PeterAuthProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<PeterAuthProvider>()
        ?.widget;
    return widget is PeterAuthProvider ? widget : null;
  }
}
