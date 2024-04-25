// import 'package:flutter/material.dart';

// import '../../../../../firebase_service.dart';
// import 'auth_form_widget.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   bool haveAccount = true;
//   final FirebaseService firebaseService = FirebaseService();

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const lugImg = AssetImage('assets/images/lug_logo.jpg');

//     final onAuth = haveAccount
//         ? () => firebaseService.onLogin(
//               email: emailController.text,
//               password: passwordController.text,
//             )
//         : () => firebaseService.onRegister(
//               email: emailController.text,
//               password: passwordController.text,
//               displayName: 'Test Name'
//             );
//     final buttonText = haveAccount ? 'Sing In' : 'Register';
//     final modeChangeButtonText = haveAccount ? 'Register' : 'Sing In';

//     return Scaffold(
//         // resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text(buttonText),
//         ),
//         body: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 const SizedBox(
//                   height: 25,
//                   width: double.infinity, // WARNING
//                 ),
//                 Container(
//                   width: 180,
//                   height: 180,
//                   clipBehavior: Clip.antiAlias,
//                   decoration: const BoxDecoration(shape: BoxShape.circle),
//                   child: const Image(
//                     image: lugImg,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 const SizedBox(height: 25),
//                 Row(
//                   children: [
//                     const Text(
//                       'Hast du schon einen Account?',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                     TextButton(
//                         onPressed: () {
//                           setState(() {
//                             haveAccount = !haveAccount;
//                           });
//                         },
//                         child: Text(modeChangeButtonText,
//                             style: const TextStyle(fontSize: 20))),
//                   ],
//                 ),
//                 const SizedBox(height: 25),
//                 AuthFormWidget(
//                   authButtonText: buttonText,
//                   onAuth: onAuth,
//                   emailController: emailController,
//                   passwordController: passwordController,
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
