import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_repository/group_repository.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/platform/app/di/app_scope.dart';
import 'package:procrastinator/src/core/styles/text_field_theme.dart';
import 'package:procrastinator/src/app_management/feature/main_screen/group_list/group_list.dart';
import 'package:procrastinator/src/app_management/di/management_scope.dart';
import 'package:procrastinator/src/platform/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:user_repository/user_repository.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  // static Page<void> page() => const MaterialPage<void>(child: SignUpScreen());

  // static Route<void> route() {
  //   return MaterialPageRoute<void>(builder: (_) => const SignUpScreen());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: const Text('Registration'),
        // ),
        body: SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: BlocProvider(
        create: (_) => SignUpCubit(AppScope.depConOf(context).userRepository,
            ManagementAppScope.depOf(context).firebaseGroupRepository),
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
              // const Row(children: [
              //   Text('Hast du shon ein Profil?',
              //       style: TextStyle(fontSize: 16)),
              //   _ChangeSignInModeButton()
              // ]),
              const SizedBox(height: 25),
              const _RegisterFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// class _ChangeSignInModeButton extends StatelessWidget {
//   const _ChangeSignInModeButton();

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         onPressed: () => Navigator.of(context).push(LoginScreen.route()),
//         child: const Text(
//           'Anmelden',
//           style: TextStyle(fontSize: 20, color: MyAppColorScheme.primary),
//         ));
//   }
// }

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          _NameTextField(),
          const SizedBox(height: 16),
          _EmailTextField(),
          const SizedBox(height: 16),
          const _PassValidationIndicatorWidget(),
          const _PasswordTextField(),
          const SizedBox(height: 16),
          const _UserTypeDropDown(),
          const SizedBox(height: 16),
          const _GroupDropDown(),
          const SizedBox(height: 16),
          const _SchoolLocationDropDown(),
          const SizedBox(height: 32),
          const _ErrorMessageWidget(),
          const Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 60,
                ////BUTTON
                child: _SignUpButtonWidget(),
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

///NAME
class _NameTextField extends StatelessWidget {
  _NameTextField();

  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpCubitState>(
      buildWhen: (previous, current) => previous.userName != current.userName,
      builder: (context, state) {
        // final _email = context.read<LoginCubit>().state.email.toString();
        return TextFormField(
          key: const Key('signUpForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<SignUpCubit>().userNameChanged(name),
          controller: controllerName,
          // focusNode: nodeEmail,
          autofocus: false,
          autofillHints: const [AutofillHints.username],

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
          decoration: InputDecoration(
            // helperText: 'paste',
            // helperMaxLines: 1,
            suffixIcon: (state.userName.toString().isNotEmpty)
                ? InkWell(
                    onTap: () {
                      context.read<SignUpCubit>().userNameClear();
                      controllerName.clear();
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
              Localization.of(context).name,
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

///EMAIL
class _EmailTextField extends StatelessWidget {
  _EmailTextField();

  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpCubitState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        // final _email = context.read<LoginCubit>().state.email.toString();
        return TextFormField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
                      context.read<SignUpCubit>().emailClear();
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

////PASS
class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField();

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _onTapPassVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpCubitState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            autofillHints: const [AutofillHints.password],
            keyboardType: TextInputType.visiblePassword,
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

/////DROP
class _GroupDropDown extends StatelessWidget {
  const _GroupDropDown();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpCubitState>(
      builder: (context, state) {
        if (state.userType == UserType.student) {
          return BlocBuilder<GroupListBloc, GroupListState>(
            builder: (context, state) {
              if (state is GroupListLoadedState) {
                return Container(
                  // margin: const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
                  child: DropdownMenu(
                    enableSearch: false,
                    expandedInsets: EdgeInsets.zero,
                    hintText: Localization.of(context).groupText,
                    dropdownMenuEntries:

                        // Group mapping
                        state.groupList!
                            .map<DropdownMenuEntry<Group>>((Group group) {
                      return DropdownMenuEntry<Group>(
                          value: group, label: group.groupName);
                    }).toList(),

                    //
                    textStyle: Theme.of(context).textTheme.titleMedium,

                    ///INPUT
                    inputDecorationTheme: InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).cardColor,
                    ),

                    ///MENU
                    menuStyle: MenuStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Theme.of(context).cardColor),
                        surfaceTintColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        shadowColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        // side: const WidgetStatePropertyAll(BorderSide()),
                        shape: WidgetStatePropertyAll(OutlinedBorder.lerp(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            const RoundedRectangleBorder(),
                            0.1))),
                    onSelected: (value) {
                      context.read<SignUpCubit>().groupChanged(value!);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      color: MyAppColorScheme.primary,
                    ),
                  ),
                );
              }
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

///// School Locations DropDown
class _SchoolLocationDropDown extends StatelessWidget {
  const _SchoolLocationDropDown();

  @override
  Widget build(BuildContext context) {
    final schoolLocations = [
      DropdownMenuEntry(
          label: 'Nürnberg',
          value:
              SchoolGeoPosition(latitude: 49.4492803, longitude: 11.0615792)),
      DropdownMenuEntry(
          label: 'Karlsruhe',
          value: SchoolGeoPosition(latitude: 49.0443115, longitude: 8.3922262)),
      DropdownMenuEntry(
          label: 'Stuttgart',
          value: SchoolGeoPosition(latitude: 48.6963833, longitude: 9.1629165)),
      DropdownMenuEntry(
          label: 'Heilbron',
          value: SchoolGeoPosition(latitude: 49.1466648, longitude: 9.1965098)),
    ];

    return BlocBuilder<SignUpCubit, SignUpCubitState>(
      builder: (context, state) {
        if (state.userType == UserType.student) {
          return Container(
            // margin: const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
            child: DropdownMenu(
              enableSearch: false,
              expandedInsets: EdgeInsets.zero,
              hintText: Localization.of(context).schoolLocationDropDownText,
              dropdownMenuEntries: schoolLocations,

              //
              textStyle: Theme.of(context).textTheme.titleMedium,

              ///INPUT
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),

              ///MENU
              menuStyle: MenuStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Theme.of(context).cardColor),
                  surfaceTintColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                  // side: const WidgetStatePropertyAll(BorderSide()),
                  shape: WidgetStatePropertyAll(OutlinedBorder.lerp(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      const RoundedRectangleBorder(),
                      0.1))),
              onSelected: (value) {
                context.read<SignUpCubit>().geopositionChanged(value!);
              },
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

///// User Type DropDown
class _UserTypeDropDown extends StatelessWidget {
  const _UserTypeDropDown();

  @override
  Widget build(BuildContext context) {
    final userTypes = [
      DropdownMenuEntry(
          label: Localization.of(context).studentLabel,
          value: UserType.student),
      DropdownMenuEntry(
          label: Localization.of(context).managerLabel,
          value: UserType.management),
      DropdownMenuEntry(
          label: Localization.of(context).trainerLabel, value: UserType.trainer)
    ];

    return Container(
      // margin: const EdgeInsets.only(top: 12, bottom: 12, left: 8, right: 8),
      child: DropdownMenu(
        enableSearch: false,
        expandedInsets: EdgeInsets.zero,
        hintText: Localization.of(context).selectAUserTypeText,
        dropdownMenuEntries: userTypes,

        //
        textStyle: Theme.of(context).textTheme.titleMedium,

        ///INPUT
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
        ),

        ///MENU
        menuStyle: MenuStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).cardColor),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            // side: const WidgetStatePropertyAll(BorderSide()),
            shape: WidgetStatePropertyAll(OutlinedBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                const RoundedRectangleBorder(),
                0.1))),
        onSelected: (value) {
          context.read<SignUpCubit>().userTypeChanged(value!);
        },
      ),
    );
  }
}

///AuthBUTTON
class _SignUpButtonWidget extends StatelessWidget {
  const _SignUpButtonWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpCubitState>(
      builder: (context, state) {
        if (state.email.isNotEmpty &&
            state.password.isNotEmpty &&
            state.userName.isNotEmpty &&
            // (state.userType == UserType.student && state.groupRef != null) &&
            // state.userType != UserType.undefined &&
            state.containsUpperCase &&
            state.containsLowerCase &&
            state.containsNumber &&
            state.containsSpecialChar &&
            state.contains8Length &&
            state.status != SignUpStatus.failure) {
          return ElevatedButton(
            onPressed: () {
              context.read<SignUpCubit>().signUpAndCreateUserCollection();
            },
            // state.isValid
            //     ? () =>
            //     context.read<LoginCubit>().logInWithCredentials()
            //     : null,
            child: Text(
              Localization.of(context).registrationButtonText,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                    //fontWeight: FontWeight.w500
                  ),
            ),
          );
        } else if (state.status == SignUpStatus.inProgress) {
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
              Localization.of(context).registrationButtonText,
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

///ERROR Message
class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpCubitState>(
        builder: (context, state) {
      if (state.status == SignUpStatus.failure &&
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

class _PassValidationIndicatorWidget extends StatelessWidget {
  const _PassValidationIndicatorWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpCubitState>(
        builder: (context, state) {
      if (state.password.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 32, bottom: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "⦿  1 uppercase",
                    style: TextStyle(
                        color: state.containsUpperCase
                            ? Colors.green
                            : Theme.of(context).colorScheme.onBackground),
                  ),
                  Text(
                    "⦿  1 lowercase",
                    style: TextStyle(
                        color: state.containsLowerCase
                            ? Colors.green
                            : Theme.of(context).colorScheme.onBackground),
                  ),
                  Text(
                    "⦿  1 number",
                    style: TextStyle(
                        color: state.containsNumber
                            ? Colors.green
                            : Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "⦿  1 special character",
                    style: TextStyle(
                        color: state.containsSpecialChar
                            ? Colors.green
                            : Theme.of(context).colorScheme.onBackground),
                  ),
                  Text(
                    "⦿  8 minimum character",
                    style: TextStyle(
                        color: state.contains8Length
                            ? Colors.green
                            : Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
