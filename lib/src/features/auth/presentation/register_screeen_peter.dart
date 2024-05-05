import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';
import 'package:procrastinator/src/core/router/main_navigation.dart';

import 'package:procrastinator/old_files/old/auth_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core/styles/color_scheme_my.dart';
import '../../../core/styles/text_field_theme.dart';
import '../data/auth_model_peter.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Registration'),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: _HeaderWidget(),
        ));
  }
}

///////////////

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Container(
          alignment: Alignment.topCenter,
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 25,
                width: double.infinity, // WARNING
              ),
              Container(
                width: 180,
                height: 180,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: const Image(
                  image: AssetImage(Images.lutzLogotypePng),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'Hast du shon ein Profil?',
                    style: TextStyle(fontSize: 16),
                  ),
                  _ChangeSignInModeButton()
                ],
              ),
              const SizedBox(height: 25),
              _RegisterFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChangeSignInModeButton extends StatefulWidget {
  const _ChangeSignInModeButton({super.key});

  @override
  State<_ChangeSignInModeButton> createState() =>
      _ChangeSignInModeButtonState();
}

class _ChangeSignInModeButtonState extends State<_ChangeSignInModeButton> {
  void _navigateTo() {
    Navigator.of(context).pushReplacementNamed(MainNavigationRoutes.auth);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _navigateTo,
      child: const Text(
        'Anmelden',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

////////////////
///
///
///
///

class _RegisterFormWidget extends StatelessWidget {
  const _RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _NameTextField(),
          SizedBox(height: 16),
          _EmailTextField(),
          SizedBox(height: 16),
          _PasswordTextField(),

          //
          SizedBox(height: 32),
          _ErrorMessageWidget(),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 60,
                ////BUTTON
                child: _AuthButtonWidget(),
              ),
              SizedBox(
                height: 16,
              ),
              // SignInWithAppleButton(
              //   onPressed: () async {
              //     final credential = await SignInWithApple.getAppleIDCredential(
              //       scopes: [
              //         AppleIDAuthorizationScopes.email,
              //         AppleIDAuthorizationScopes.fullName,
              //       ],
              //     );

              //     print(credential);

              //     // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
              //     // after they have been validated with Apple (see `Integration` section for more information on how to do this)
              //   },
              // ),
              // TextButton(
              //     onPressed: () {}, child: const Text('Kennwort vergessen?')),
            ],
          ),
        ],
      ),
    );
  }
}

//NAME
class _NameTextField extends StatefulWidget {
  const _NameTextField({super.key});

  @override
  State<_NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<_NameTextField> {
  @override
  Widget build(BuildContext context) {
    final model = PeterAuthProvider.read(context)?.model;
    return TextFormField(
        onChanged: (String text) {
          model?.nameTextController;
          setState(() {});
        },
        // focusNode: nodeEmail,
        autofocus: false,
        autofillHints: [AutofillHints.name],

        //FORMATORS
        inputFormatters: const [
          //allowing ---- !!!Look info about Regular Expressions!!!
          //FilteringTextInputFormatter.allow(RegExp(r'[/d]+'))
        ],

        //KEYBOARD properties
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        // keyboardAppearance: Brightness.dark,

        //CURSOR
        cursorColor: MyAppColorScheme.primary,

        // CORRECTIONS
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        controller: model?.nameTextController,
        decoration: InputDecoration(
          // helperText: 'paste',
          // helperMaxLines: 1,
          suffixIcon:
              (model != null && model.nameTextController.text.isNotEmpty)
                  ? InkWell(
                      onTap: () {
                        model.nameTextController.clear();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: MyAppColorScheme.secondaryText,
                        size: 16,
                      ),
                    )
                  : null,
          focusedBorder: MyThemeTextField.focusedBorder,
          contentPadding: const EdgeInsets.all(14),
          border: MyThemeTextField.textFieldInputBorder,
          label: const Text(
            'Name',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ));
  }
}

class _EmailTextField extends StatefulWidget {
  const _EmailTextField({super.key});

  @override
  State<_EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<_EmailTextField> {
  @override
  Widget build(BuildContext context) {
    final model = PeterAuthProvider.read(context)?.model;

    return TextFormField(
        onChanged: (String text) {
          model?.emailTextController;
          setState(() {});
        },
        // focusNode: nodeEmail,
        autofocus: false,
        autofillHints: [AutofillHints.username],

        //FORMATORS
        inputFormatters: const [
          //allowing ---- !!!Look info about Regular Expressions!!!
          //FilteringTextInputFormatter.allow(RegExp(r'[/d]+'))
        ],

        //KEYBOARD properties
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        // keyboardAppearance: Brightness.dark,

        //CURSOR
        cursorColor: MyAppColorScheme.primary,

        // CORRECTIONS
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        controller: model?.emailTextController,
        decoration: InputDecoration(
          // helperText: 'paste',
          // helperMaxLines: 1,
          suffixIcon:
              (model != null && model.emailTextController.text.isNotEmpty)
                  ? InkWell(
                      onTap: () {
                        model.emailTextController.clear();
                      },
                      child: const Icon(
                        Icons.clear,
                        color: MyAppColorScheme.secondaryText,
                        size: 16,
                      ),
                    )
                  : null,
          focusedBorder: MyThemeTextField.focusedBorder,
          contentPadding: const EdgeInsets.all(14),
          border: MyThemeTextField.textFieldInputBorder,
          label: const Text(
            'E-mail',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ));
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({super.key});

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _onTapPassVisibl = true;
  @override
  Widget build(BuildContext context) {
    final model = PeterAuthProvider.read(context)?.model;

    return

        //Pass Field
        TextFormField(
            autofillHints: [AutofillHints.password],
            textInputAction: TextInputAction.done,
            // focusNode: nodePass,
            maxLength: 10,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            controller: model?.passTextController,
            obscureText: _onTapPassVisibl,
            decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () => setState(
                    () => _onTapPassVisibl = !_onTapPassVisibl,
                  ),
                  child: Icon(
                    _onTapPassVisibl
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: MyAppColorScheme.secondaryText,
                    size: 20,
                  ),
                ),
                focusedBorder: MyThemeTextField.focusedBorder,
                contentPadding: const EdgeInsets.all(14),
                border: MyThemeTextField.textFieldInputBorder,
                label: const Text(
                  'Password',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                helperMaxLines: 1));
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = PeterAuthProvider.watch(context)?.model;
    final onPressed =
        model?.canUserAuth == true ? () => model?.register(context) : null;
    final buttonChild = model?.isAuthInProgress == true
        ? CircularProgressIndicator(
            color: Colors.white,
          )
        : Text(
            'Registrieren',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  //fontWeight: FontWeight.w500
                ),
          );
    return ElevatedButton(
      onPressed: onPressed,
      child: buttonChild,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    final errorMessage = PeterAuthProvider.watch(context)?.model.errorMessage;
    if (errorMessage == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        errorMessage,
        style: TextStyle(color: MyAppColorScheme.errorColor),
      ),
    );
  }
}

// class _AuthFormWidget extends StatefulWidget {
//   const _AuthFormWidget({super.key});

//   @override
//   State<_AuthFormWidget> createState() => _AuthFormWidgetState();
// }

// class _AuthFormWidgetState extends State<_AuthFormWidget> {
//   bool _onTapPassVisibl = true;

//   @override
//   Widget build(BuildContext context) {
//     final model = PeterAuthProvider.watch(context)?.model;

//     const textStyle = TextStyle(fontSize: 16, color: Colors.grey);

//     return Container(
//       width: 600,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           TextField(
//               onChanged: (String text) {
//                 model?.emailTextController;
//                 setState(() {});
//               },
//               // focusNode: nodeEmail,
//               autofocus: false,
//               autofillHints: [AutofillHints.username],

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
//               decoration: InputDecoration(
//                 // helperText: 'paste',
//                 // helperMaxLines: 1,
//                 suffixIcon:
//                     (model != null && model.emailTextController.text.isNotEmpty)
//                         ? InkWell(
//                             onTap: () {
//                               model.emailTextController.clear();
//                               setState(() {});
//                             },
//                             child: const Icon(
//                               Icons.clear,
//                               color: MyAppColorScheme.secondaryText,
//                               size: 16,
//                             ),
//                           )
//                         : null,
//                 focusedBorder: MyThemeTextField.focusedBorder,
//                 contentPadding: const EdgeInsets.all(14),
//                 border: MyThemeTextField.textFieldInputBorder,
//                 label: const Text(
//                   'E-mail',
//                   style: textStyle,
//                 ),
//               )),
//           const SizedBox(
//             height: 25,
//           ),
//           //

//           //Pass Field
//           TextField(
//               autofillHints: [AutofillHints.password],
//               textInputAction: TextInputAction.done,
//               // focusNode: nodePass,
//               maxLength: 10,
//               maxLengthEnforcement: MaxLengthEnforcement.enforced,
//               controller: model?.passTextController,
//               obscureText: _onTapPassVisibl,
//               decoration: InputDecoration(
//                   suffixIcon: InkWell(
//                     onTap: () => setState(
//                       () => _onTapPassVisibl = !_onTapPassVisibl,
//                     ),
//                     child: Icon(
//                       _onTapPassVisibl
//                           ? Icons.visibility_off_outlined
//                           : Icons.visibility_outlined,
//                       color: MyAppColorScheme.secondaryText,
//                       size: 20,
//                     ),
//                   ),
//                   focusedBorder: MyThemeTextField.focusedBorder,
//                   contentPadding: const EdgeInsets.all(14),
//                   border: MyThemeTextField.textFieldInputBorder,
//                   label: const Text(
//                     'Password',
//                     style: textStyle,
//                   ),
//                   helperMaxLines: 1)),

//           //
//           const SizedBox(height: 32),
//           _ErrorMessageWidget(),
//           Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 60,
//                 ////BUTTON
//                 child: ElevatedButton(
//                     onPressed: () => model?.auth(context),
//                     child: Text(
//                       'Anmelden',
//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                             color: Colors.white,
//                             //fontWeight: FontWeight.w500
//                           ),
//                     )),
//               ),
//               SizedBox(
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


