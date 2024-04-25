// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:procrastinator/Theme/color_scheme_my.dart';
// import 'package:procrastinator/Theme/text_field_theme.dart';
// import 'package:procrastinator/widgets/auth/auth_model.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// class AuthWidget extends StatefulWidget {
//   const AuthWidget({super.key});

//   @override
//   State<AuthWidget> createState() => _AuthWidgetState();
// }

// class _AuthWidgetState extends State<AuthWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: const Text('Authentification'),
//         ),
//         body: SingleChildScrollView(
//           child: _HeaderWidget(),
//         ));
//   }
// }

// class _HeaderWidget extends StatelessWidget {
//   const _HeaderWidget({super.key});

//   final lugImg = const AssetImage('assets/images/lug_logo.jpg');

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           const SizedBox(
//             height: 25,
//             width: double.infinity, // WARNING
//           ),
//           Container(
//             width: 180,
//             height: 180,
//             clipBehavior: Clip.antiAlias,
//             decoration: BoxDecoration(shape: BoxShape.circle),
//             child: Image(
//               image: lugImg,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(height: 25),
//           const Text(
//             'Authentification on L&G',
//             style: TextStyle(fontSize: 16),
//           ),
//           const SizedBox(height: 25),
//           _AuthFormWidget()
//         ],
//       ),
//     );
//   }
// }

// class _AuthFormWidget extends StatelessWidget {
//   const _AuthFormWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final model = MyAuthProvider.read(context)?.model;

//     return Container(
//       width: 600,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           TextField(
//               // onChanged: _onChanged,
//               // focusNode: nodeEmail,
//               autofocus: false,
//               // autofillHints: username,

//               //FORMATORS
//               inputFormatters: const [
//                 //allowing ---- !!!Look info about Regular Expressions!!!
//                 //FilteringTextInputFormatter.allow(RegExp(r'[/d]+'))
//               ],

//               //KEYBOARD properties
//               keyboardType: TextInputType.emailAddress,
//               textInputAction: TextInputAction.next,
//               // keyboardAppearance: Brightness.dark,

//               //CURSOR
//               cursorColor: MyAppColorScheme.primary,

//               // CORRECTIONS
//               autocorrect: false,
//               enableSuggestions: false,
//               textCapitalization: TextCapitalization.none,
//               controller: model?.emailTextController,
//               decoration: const InputDecoration(
//                 // helperText: 'paste',
//                 // helperMaxLines: 1,
//                 // suffixIcon: model!.mailTextController.text.isNotEmpty
//                 //     ? InkWell(
//                 //         onTap: () {
//                 //           model.mailTextController.clear();
//                 //           setState(() {});
//                 //         },
//                 //         child: const Icon(
//                 //           Icons.clear,
//                 //           color: MyAppColorScheme.secondaryText,
//                 //           size: 16,
//                 //         ),
//                 //       )
//                 //     : null,
//                 focusedBorder: MyThemeTextField.focusedBorder,
//                 contentPadding: EdgeInsets.all(14),
//                 border: MyThemeTextField.textFieldInputBorder,
//                 label: Text(
//                   'E-mail',
//                   style: TextStyle(fontSize: 16, color: Colors.grey),
//                 ),
//               )),
//           const SizedBox(
//             height: 25,
//           ),
//           //

//           //Pass Field
//           TextField(
//               textInputAction: TextInputAction.done,
//               // focusNode: nodePass,
//               maxLength: 10,
//               maxLengthEnforcement: MaxLengthEnforcement.enforced,
//               controller: model?.passTextController,
//               // obscureText: _onTapPassVisibl,
//               obscureText: true,
//               decoration: const InputDecoration(
//                   // suffixIcon: InkWell(
//                   //   onTap: () => setState(
//                   //     () => _onTapPassVisibl = !_onTapPassVisibl,
//                   //   ),
//                   //   child: Icon(
//                   //     _onTapPassVisibl
//                   //         ? Icons.visibility_off_outlined
//                   //         : Icons.visibility_outlined,
//                   //     color: MyAppColorScheme.secondaryText,
//                   //     size: 20,
//                   //   ),
//                   // ),
//                   focusedBorder: MyThemeTextField.focusedBorder,
//                   contentPadding: EdgeInsets.all(14),
//                   border: MyThemeTextField.textFieldInputBorder,
//                   label: Text(
//                     'Password',
//                     style: TextStyle(fontSize: 16, color: Colors.grey),
//                   ),
//                   helperMaxLines: 1)),

//           //
//           const SizedBox(height: 32),
//           const _ErrorMessageWidget(),

//           Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 60,
//                 child: _AuthButtonWidget(),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               // SignInWithAppleButton(
//               //   onPressed: () async {
//               //     final credential = await SignInWithApple.getAppleIDCredential(
//               //       scopes: [
//               //         AppleIDAuthorizationScopes.email,
//               //         AppleIDAuthorizationScopes.fullName,
//               //       ],
//               //     );

//               //     print(credential);

//               //     // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
//               //     // after they have been validated with Apple (see `Integration` section for more information on how to do this)
//               //   },
//               // ),
//               TextButton(
//                   onPressed: () {}, child: const Text('Kennwort vergessen?')),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _AuthButtonWidget extends StatelessWidget {
//   const _AuthButtonWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final model = MyAuthProvider.watch(context)?.model;
//     final onPressed =
//         model?.canUserAuth == true ? () => model?.auth(context) : null;
//     return ElevatedButton(
//         onPressed: onPressed,
//         child: Text(
//           'Anmelden',
//           style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                 color: Colors.white,
//                 //fontWeight: FontWeight.w500
//               ),
//         ));
//   }
// }

// class _ErrorMessageWidget extends StatelessWidget {
//   const _ErrorMessageWidget();

//   @override
//   Widget build(BuildContext context) {
//     final errorMessage = MyAuthProvider.watch(context)?.model.errorMessage;
//     if (errorMessage == null) {
//       return const SizedBox.shrink();
//     }
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20),
//       child: Text(errorMessage),
//     );
//   }
// }


// // class _AuthFormWidget extends StatefulWidget {
// //   const _AuthFormWidget({super.key});

// //   @override
// //   State<_AuthFormWidget> createState() => _AuthFormWidgetState();
// // }

// // class _AuthFormWidgetState extends State<_AuthFormWidget> {
// //   var _mailTextController = TextEditingController(text: 'admin');
// //   final _passTextController = TextEditingController(text: '0000');
// //   String? errorText = null;

// // //Autofill
// //   static const String username = 'username';

// //   bool _onTapPassVisibl = true;

// //   final nodeEmail = FocusNode();
// //   final nodePass = FocusNode();

// //   void _auth() {
// //     final email = _mailTextController.text;
// //     final password = _passTextController.text;
// //     if (email == 'admin' && password == '0000') {
// //       //this.errorText = null;
// //       // Navigator.of(context).pushReplacementNamed('/main_screen');
// //       Navigator.of(context).pushReplacementNamed('/main_screen');
// //     } else {
// //       errorText = 'E-mail oder Kennwort passt nicht';
// //     }
// //     setState(() {});
// //   }

// //   void _resetEmail() {
// //     _mailTextController.clear();
// //   }

// //   void _resetPassword() {
// //     print('Reset password');
// //   }

// // //TRAINING Methods
// //   void _onListnen() {
// //     _mailTextController.text;
// //   }

// //   void _onChanged(String text) {
// //     _mailTextController.addListener(_onListnen);
// //     setState(() {});
// //   }

// //   void _onEditingComplete() {
// //     print('_onEditingComplete');
// //   }

// //   void _onSubmitted(String text) {
// //     print('_onSubmitted: $text');
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     const textStyle = TextStyle(fontSize: 16, color: Colors.grey);
// //     final String? errorText = this.errorText;
// //     return Container(
// //       width: 600,
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         mainAxisSize: MainAxisSize.max,
// //         children: [
// //           TextField(
// //               onChanged: _onChanged,
// //               focusNode: nodeEmail,
// //               autofocus: false,
// //               autofillHints: const [username],

// //               //FORMATORS
// //               inputFormatters: const [
// //                 //allowing ---- !!!Look info about Regular Expressions!!!
// //                 //FilteringTextInputFormatter.allow(RegExp(r'[/d]+'))
// //               ],

// //               //KEYBOARD properties
// //               keyboardType: TextInputType.emailAddress,
// //               textInputAction: TextInputAction.next,
// //               // keyboardAppearance: Brightness.dark,

// //               //CURSOR
// //               cursorColor: MyAppColorScheme.primary,

// //               // CORRECTIONS
// //               autocorrect: false,
// //               enableSuggestions: false,
// //               textCapitalization: TextCapitalization.none,
// //               controller: _mailTextController,
// //               decoration: InputDecoration(
// //                 // helperText: 'paste',
// //                 // helperMaxLines: 1,
// //                 suffixIcon: _mailTextController.text.isNotEmpty
// //                     ? InkWell(
// //                         onTap: () {
// //                           _mailTextController.clear();
// //                           setState(() {});
// //                         },
// //                         child: const Icon(
// //                           Icons.clear,
// //                           color: MyAppColorScheme.secondaryText,
// //                           size: 16,
// //                         ),
// //                       )
// //                     : null,
// //                 focusedBorder: MyThemeTextField.focusedBorder,
// //                 contentPadding: const EdgeInsets.all(14),
// //                 border: MyThemeTextField.textFieldInputBorder,
// //                 label: const Text(
// //                   'E-mail',
// //                   style: textStyle,
// //                 ),
// //               )),
// //           const SizedBox(
// //             height: 25,
// //           ),
// //           //

// //           //Pass Field
// //           TextField(
// //               textInputAction: TextInputAction.done,
// //               focusNode: nodePass,
// //               maxLength: 10,
// //               maxLengthEnforcement: MaxLengthEnforcement.enforced,
// //               controller: _passTextController,
// //               obscureText: _onTapPassVisibl,
// //               decoration: InputDecoration(
// //                   suffixIcon: InkWell(
// //                     onTap: () => setState(
// //                       () => _onTapPassVisibl = !_onTapPassVisibl,
// //                     ),
// //                     child: Icon(
// //                       _onTapPassVisibl
// //                           ? Icons.visibility_off_outlined
// //                           : Icons.visibility_outlined,
// //                       color: MyAppColorScheme.secondaryText,
// //                       size: 20,
// //                     ),
// //                   ),
// //                   focusedBorder: MyThemeTextField.focusedBorder,
// //                   contentPadding: const EdgeInsets.all(14),
// //                   border: MyThemeTextField.textFieldInputBorder,
// //                   label: const Text(
// //                     'Password',
// //                     style: textStyle,
// //                   ),
// //                   helperMaxLines: 1)),

// //           //
// //           const SizedBox(height: 32),
// //           if (errorText != null) ...[
// //             Container(
// //               height: 30,
// //               color: Colors.red,
// //               width: double.infinity,
// //               child: Center(
// //                 child: Text(
// //                   errorText,
// //                   style: const TextStyle(color: Colors.white),
// //                 ),
// //               ),
// //             )
// //           ],
// //           Column(
// //             children: [
// //               SizedBox(
// //                 width: double.infinity,
// //                 height: 60,
// //                 child: ElevatedButton(
// //                     onPressed: _auth,
// //                     child: Text(
// //                       'Anmelden',
// //                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
// //                             color: Colors.white,
// //                             //fontWeight: FontWeight.w500
// //                           ),
// //                     )),
// //               ),
// //               SizedBox(
// //                 height: 16,
// //               ),
// //               SignInWithAppleButton(
// //                 onPressed: () async {
// //                   final credential = await SignInWithApple.getAppleIDCredential(
// //                     scopes: [
// //                       AppleIDAuthorizationScopes.email,
// //                       AppleIDAuthorizationScopes.fullName,
// //                     ],
// //                   );

// //                   print(credential);

// //                   // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
// //                   // after they have been validated with Apple (see `Integration` section for more information on how to do this)
// //                 },
// //               ),
// //               TextButton(
// //                   onPressed: _resetPassword,
// //                   child: const Text('Kennwort vergessen?')),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
