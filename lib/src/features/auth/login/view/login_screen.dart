import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/text_field_theme.dart';
import 'package:procrastinator/src/features/auth/login/login.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';
import 'package:procrastinator/src/features/app/bloc/authentication_bloc.dart';
import 'package:settings_repository/settings_repository.dart';

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
          title: Text(Localization.of(context).anmeldungLogInScreenName),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: BlocProvider(
            create: (context) => LoginCubit(
                context.read<AuthenticationBloc>().authenticationRepository),
            child: const _HeaderWidget(),
          ),
        ));
  }
}

///////////////

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 25,
                width: double.infinity,
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
              const SizedBox(height: 60),
              const _AuthFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

/// AUTH Form

class _AuthFormWidget extends StatelessWidget {
  const _AuthFormWidget();

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
          const _ErrorMessageWidget(),
          const SizedBox(height: 32),
          const Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 60,
                  ////BUTTON
                  child: _AuthButtonWidget()),
              SizedBox(
                height: 16,
              ),
              _ResetPasswordButton(),
            ],
          ),
        ],
      ),
    );
  }
}

/// EMAIL
class _EmailTextField extends StatelessWidget {
  _EmailTextField();

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
            focusedErrorBorder: MyThemeTextField.errorBorder,
            errorBorder: MyThemeTextField.errorBorder,
            contentPadding: const EdgeInsets.all(14),
            border: MyThemeTextField.textFieldInputBorder,
            label: Text(
              Localization.of(context).emailTextFieldLabel,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            // helperText: '',
            // errorText: state.emailIsValid == false ? '' : null,
          ),
        );
      },
    );
  }
}

/// PASS
class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField();

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
            maxLength: 16,
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
                label: Text(
                  Localization.of(context).passwordTextFieldLabel,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                helperMaxLines: 1));
      },
    );
  }
}

/// AuthBUTTON
class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.email.isNotEmpty &&
            state.password.isNotEmpty &&
            state.status != LoginStatus.failure) {
          return ElevatedButton(
            onPressed: () {
              context.read<LoginCubit>().logInWithCredentials();
            },
            // state.isValid
            //     ? () =>
            //     context.read<LoginCubit>().logInWithCredentials()
            //     : null,
            child: Text(
              Localization.of(context).logInButtonName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    //fontWeight: FontWeight.w500
                  ),
            ),
          );
        } else if (state.status == LoginStatus.inProgress) {
          return ElevatedButton(
            onPressed: () {},
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        } else {
          return ElevatedButton(
            onPressed: () {},
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey)),
            child: Text(
              Localization.of(context).logInButtonName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    //fontWeight: FontWeight.w500
                  ),
            ),
          );
        }
      },
    );
  }
}

/// RESET Pass Button
class _ResetPasswordButton extends StatelessWidget {
  const _ResetPasswordButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.email.isNotEmpty) {
          return TextButton(
            onPressed: context.read<LoginCubit>().resetPassword,
            child: Text(
              Localization.of(context).forgotPassButtonName,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: MyAppColorScheme.primary,
                    //fontWeight: FontWeight.w500
                  ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

/// ERROR Message
class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state.status == LoginStatus.failure &&
          state.errorMessage!.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SelectableText(
            state.errorMessage!,
            style: const TextStyle(color: MyAppColorScheme.errorColor),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
