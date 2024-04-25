import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../domain/api_client/firebase_service.dart';
import '../../../../theme/color_scheme_my.dart';
import '../../../../theme/text_field_theme.dart';
import '../../firebase_auth/fire_auth_screen/auth_model_peter.dart';

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({
    super.key,
    required this.onAuth,
    required this.authButtonText,
    required this.emailController,
    required this.passwordController,
  });

  final VoidCallback onAuth;
  final String authButtonText;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final FirebaseService firebaseService = FirebaseService();

  // final nodeEmail = FocusNode();
  // final nodePass = FocusNode();

  bool _onTapPassVisibl = true;
  FirebaseAuthException? error = null;

  void _catchError(FirebaseAuthException exception) {
    error = exception;
    setState(() {});
  }

  void _onChanged(String text) {
    widget.emailController.addListener(_onListnen);
    setState(() {});
  }

  void _onListnen() {
    widget.emailController.text;
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = firebaseService.error?.message;
    return Container(
      width: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          TextFormField(
              onChanged: _onChanged,
              // focusNode: nodeEmail,
              autofocus: false,
              autofillHints: const [
                AutofillHints.username,
                AutofillHints.password,
                // AutofillHints.email,
                // AutofillHints.name,
              ],

              //FORMATORS
              // inputFormatters: const [
              //   allowing ---- !!!Look info about Regular Expressions!!!
              //   FilteringTextInputFormatter.allow(RegExp(r'[/d]+'))
              // ],

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
              controller: widget.emailController,
              decoration: InputDecoration(
                // helperText: 'paste',
                // helperMaxLines: 1,
                suffixIcon: widget.emailController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          widget.emailController.clear();
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.clear,
                          color: MyAppColorScheme.secondaryText,
                          size: 16,
                        ),
                      )
                    : null,
                focusedBorder: MyThemeTextField.focusedBorder,
                contentPadding: EdgeInsets.all(14),
                border: MyThemeTextField.textFieldInputBorder,
                label: const Text(
                  'E-mail',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )),
          const SizedBox(
            height: 25,
          ),
          //

          //Pass Field
          TextFormField(
              textInputAction: TextInputAction.done,
              // focusNode: nodePass,
              autofillHints: const [AutofillHints.password],
              maxLength: 10,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: widget.passwordController,
              obscureText: _onTapPassVisibl,
              // obscureText: true,
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
                  contentPadding: EdgeInsets.all(14),
                  border: MyThemeTextField.textFieldInputBorder,
                  label: const Text(
                    'Password',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  helperMaxLines: 1)),

          //
          const SizedBox(height: 32),
          (errorMessage == null)
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: MyAppColorScheme.errorColor),
                  ),
                ),

          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                    onPressed: widget.onAuth,
                    child: Text(
                      widget.authButtonText,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                            //fontWeight: FontWeight.w500
                          ),
                    )),
              ),
              const SizedBox(
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
              TextButton(
                  onPressed: () {}, child: const Text('Kennwort vergessen?')),
            ],
          ),
        ],
      ),
    );
  }
}

// class _AuthButtonWidget extends StatelessWidget {
//   const _AuthButtonWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // final model = MyAuthProvider.watch(context)?.model;
//     // final onPressed (=
//     //     model?.canUserAuth == true ? () => model?.auth(context) : null;)
//     return ElevatedButton(
//         onPressed: onAuth,
//         child: Text(
//           'Anmelden',
//           style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                 color: Colors.white,
//                 //fontWeight: FontWeight.w500
//               ),
//         ));
//   }
// }

