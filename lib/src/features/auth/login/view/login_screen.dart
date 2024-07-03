import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/core/styles/styles.dart';
import 'package:procrastinator/src/features/auth/login/login.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';
import 'package:user_repository/user_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginScreen());

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Anmeldung'),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: BlocProvider(
            create: (_) => LoginCubit(GetIt.I<FirebaseUserRepository>()),
            child: const Column(
              children: [
                _HeaderWidget(),
              ],
            ),
          ),
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
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: const Image(
                  image: AssetImage(Images.lutzLogotypePng),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 25),

              //
              const SizedBox(height: 44),

              // const Row(
              //   children: [
              //     Text(
              //       'Hast du noch kein Profil?',
              //       style: TextStyle(fontSize: 16),
              //     ),
              //     _ChangeSignInModeButton(),
              //   ],
              // ),
              const SizedBox(height: 25),
              const _AuthFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// ///Navigate to Sign In Screen
// class _ChangeSignInModeButton extends StatelessWidget {
//   const _ChangeSignInModeButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () => Navigator.of(context).push<void>(SignUpScreen.route()),
//       child: const Text(
//         'Registrireren',
//         style: TextStyle(fontSize: 20),
//       ),
//     );
//   }
// }

//////////////// AUTH Form
///
class _AuthFormWidget extends StatelessWidget {
  const _AuthFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _EmailTextField(),
          const SizedBox(height: 16),
          const _PasswordTextField(),
          // _ErrorMessageWidget(),
          const SizedBox(height: 32),
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

              // _ResetPasswordButton(),
            ],
          ),
        ],
      ),
    );
  }
}

///EMAIL
class _EmailTextField extends StatelessWidget {
  _EmailTextField({super.key});

  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        // final _email = context.read<LoginCubit>().state.email.toString();
        return TextFormField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          controller: controllerEmail,
          // focusNode: nodeEmail,
          autofocus: false,
          autofillHints: const [AutofillHints.username],

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
          // controller: model?.emailTextController,
          decoration: InputDecoration(
            // helperText: 'paste',
            // helperMaxLines: 1,
            suffixIcon: (state.email.toString().isNotEmpty)
                ? InkWell(
                    onTap: () {
                      context.read<LoginCubit>().emailClear();
                      controllerEmail.clear();
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
            // helperText: '',
            // errorText:
            //     state.email.displayError != null ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

////PASS
class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({super.key});

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _onTapPassVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            autofillHints: const [AutofillHints.password],
            textInputAction: TextInputAction.done,
            // focusNode: nodePass,
            maxLength: 10,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            obscureText: _onTapPassVisible,
            decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () => setState(
                    () => _onTapPassVisible = !_onTapPassVisible,
                  ),
                  child: Icon(
                    _onTapPassVisible
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
      },
    );
  }
}

///AuthBUTTON
class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.status == LoginStatus.initial) {
          return ElevatedButton(
            onPressed: () {
              context.read<LoginCubit>().logInWithCredentials();
            },
            // state.isValid
            //     ? () =>
            //     context.read<LoginCubit>().logInWithCredentials()
            //     : null,
            child: Text(
              'Anmelden',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    //fontWeight: FontWeight.w500
                  ),
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: () {},
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }
}

// ///RESET Pass Button
// class _ResetPasswordButton extends StatelessWidget {
//   const _ResetPasswordButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final model = PeterAuthProvider.watch(context)?.model;
//     final onPressed =
//         model?.canUserAuth == true ? () => model?.resetPassword(context) : null;
//     final buttonChild = model?.isAuthInProgress == true
//         ? const SizedBox()
//         // const CircularProgressIndicator(color: Colors.white)
//         : Text(
//             'Kennwort vergessen?',
//             style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                   color: MyAppColorScheme.primary,
//                   //fontWeight: FontWeight.w500
//                 ),
//           );
//     return TextButton(onPressed: onPressed, child: buttonChild);
//   }
// }

// ///ERROR Message
// class _ErrorMessageWidget extends StatelessWidget {
//   const _ErrorMessageWidget();

//   @override
//   Widget build(BuildContext context) {
//     final errorMessage = PeterAuthProvider.watch(context)?.model.errorMessage;
//     if (errorMessage == null) {
//       return const SizedBox.shrink();
//     }
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 20),
//       child: SelectableText(
//         errorMessage,
//         style: const TextStyle(color: MyAppColorScheme.errorColor),
//       ),
//     );
//   }
// }
