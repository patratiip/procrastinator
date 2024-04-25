// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:procrastinator/Theme/app_theme_dark.dart';
// import 'package:procrastinator/Theme/app_theme_light.dart';
// import 'package:procrastinator/ui/widgets/auth/auth_model.dart';
// import 'package:procrastinator/ui/widgets/auth/auth_widget.dart';
// import 'package:procrastinator/ui/widgets/student_main/student_main_screen.dart';

// import 'firebase_options.dart';
// import 'firebase_service.dart';
// import 'ui/widgets/auth/firebase_auth/fire_from_lesson/auth_screen.dart';
// import 'ui/widgets/auth/firebase_auth/my_auth_fire_auth_screen/peter_auth_model.dart';
// import 'ui/widgets/auth/firebase_auth/fire_from_lesson/user_info_screen.dart';
// import 'ui/widgets/auth/firebase_auth/my_auth_fire_auth_screen/old/old_auth_screen.dart';
// import 'ui/widgets/auth/firebase_auth/my_auth_fire_auth_screen/peter_new_auth.dart';
// import 'ui/widgets/auth/firebase_auth/my_auth_fire_auth_screen/register_screeen.dart';
// import 'ui/widgets/student_main/home_page_student/4_student_profile_page/student_profile_page_widget.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   // final db = FirebaseFirestore.instance;

//   runApp(const Procrastinator());
// }

// final GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

// class Procrastinator extends StatefulWidget {
//   const Procrastinator({super.key});

//   @override
//   State<Procrastinator> createState() => _ProcrastinatorState();
// }

// class _ProcrastinatorState extends State<Procrastinator> {
//   @override
//   void initState() {
//     super.initState();
//     FirebaseService().onListenUser((user) {
//       if (user != null) {
//         Navigator.pushReplacement(kNavigatorKey.currentContext!,
//             MaterialPageRoute(builder: (_) => StudentMainScreenWidget()));
//       }
//       // else {
//       //   Navigator.pushReplacement(
//       //       kNavigatorKey.currentContext!,
//       //       MaterialPageRoute(
//       //         builder: (_) =>
//       //             // AuthScreen(),
//       //             PeterAuthProvider(
//       //           model: PeterAuthModel(),
//       //           child: SignInScreen(),
//       //         ),
//       //       ));
//       // }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Procrastinator',

//       //THEME
//       theme: MyAppThemeLight.themeLight,
//       darkTheme: MyAppThemeDark.darkTheme,

//       //HOME--withFirebaseAuth
//       navigatorKey: kNavigatorKey,
//       home: PeterAuthProvider(
//         model: PeterAuthModel(),
//         child: SignInScreen(),
//       ),

//       //ROUTING
//       // initialRoute:
//       //     FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/home',

//       routes: {
//         '/sign-in': (context) => PeterAuthProvider(
//               model: PeterAuthModel(),
//               child: SignInScreen(),
//             ),
//         '/register': (context) => PeterAuthProvider(
//               model: PeterAuthModel(),
//               child: RegisterScreen(),
//             ),
//         '/home': (context) => StudentMainScreenWidget(),
//         '/profile': (context) {
//           return StudentProfilePageWidget();
//         }
//       },
//     );
//   }
// }
