import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:procrastinator/ui/navigation/main_navigation.dart';

import 'package:procrastinator/ui/widgets/auth/old/auth_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../theme/color_scheme_my.dart';
import '../../../../theme/text_field_theme.dart';
import 'auth_model_peter.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Anmeldung'),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: _HeaderWidget(),
        ));
  }
}

///////////////

class _HeaderWidget extends StatelessWidget {
  _HeaderWidget({super.key});

  final lugImg = const AssetImage('assets/images/lug_logo.jpg');

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
                child: Image(
                  image: lugImg,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'Hast du noch kein Profil?',
                    style: TextStyle(fontSize: 16),
                  ),
                  _ChangeSignInModeButton(),
                ],
              ),
              const SizedBox(height: 25),
              const _AuthFormWidget()
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
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRoutes.registration);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _navigateTo,
      child: const Text(
        'Registrireren',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

////////////////
///
class _AuthFormWidget extends StatelessWidget {
  const _AuthFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 600),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _EmailTextField(),
          SizedBox(height: 16),
          _PasswordTextField(),
          _ErrorMessageWidget(),
          SizedBox(height: 32),
          Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 60,
                  ////BUTTON
                  child: _AuthButtonWidget()),
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
              _ResetPasswordButton(),
            ],
          ),
        ],
      ),
    );
  }
}

///EMAIL
class _EmailTextField extends StatefulWidget {
  const _EmailTextField({super.key});

  @override
  State<_EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<_EmailTextField> {
  @override
  Widget build(BuildContext context) {
    final model = PeterAuthProvider.watch(context)?.model;

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

////PASS
class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({super.key});

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _onTapPassVisibl = true;
  @override
  Widget build(BuildContext context) {
    final model = PeterAuthProvider.watch(context)?.model;

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

///AuthBUTTON
class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = PeterAuthProvider.watch(context)?.model;
    final onPressed =
        model?.canUserAuth == true ? () => model?.auth(context) : null;
    final buttonChild = model?.isAuthInProgress == true
        ? const CircularProgressIndicator(
            color: Colors.white,
          )
        : Text(
            'Anmelden',
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

///RESET Pass Button
class _ResetPasswordButton extends StatelessWidget {
  const _ResetPasswordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = PeterAuthProvider.watch(context)?.model;
    final onPressed =
        model?.canUserAuth == true ? () => model?.resetPassword(context) : null;
    final buttonChild = model?.isAuthInProgress == true
        ? const CircularProgressIndicator(
            color: Colors.white,
          )
        : Text(
            'Kennwort vergessen?',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: MyAppColorScheme.primary,
                  //fontWeight: FontWeight.w500
                ),
          );
    return TextButton(onPressed: onPressed, child: buttonChild);
  }
}

///ERROR Message
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
      child: SelectableText(
        errorMessage,
        style: const TextStyle(color: MyAppColorScheme.errorColor),
      ),
    );
  }
}
