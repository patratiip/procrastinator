// import 'package:flutter/material.dart';

// class AuthModel extends ChangeNotifier {
//   final emailTextController = TextEditingController();
//   final passTextController = TextEditingController();


//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

// bool _isAuthInProgress = false;
// bool get canUserAuth =>!_isAuthInProgress;


//   Future<void> auth(BuildContext context) async {
    
//   }
// }

// class MyAuthProvider extends InheritedNotifier {
//   final AuthModel model;

//   const MyAuthProvider({
//     super.key,
//     required this.model,
//     required super.child,
//   }) : super(notifier: model);

//   static MyAuthProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<MyAuthProvider>();
//   }

//   static MyAuthProvider? read(BuildContext context) {
//     final widget = context
//         .getElementForInheritedWidgetOfExactType<MyAuthProvider>()
//         ?.widget;
//     return widget is MyAuthProvider ? widget : null;
//   }
// }
