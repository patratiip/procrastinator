import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/text_field_theme.dart';
import 'package:procrastinator/src/features/app/di/app_scope.dart';
import 'package:procrastinator/src/features/student_app/di/student_app_scope.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/forgotten_entry_cubit/forgotten_entry_cubit.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

class ForgottenEntryBottomSheetContent extends StatelessWidget {
  final BuildContext parentContext;
  const ForgottenEntryBottomSheetContent(
      {super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EntryAddingBloc>(parentContext);
    final entryAddingRepository =
        StudentAppScope.depConOf(parentContext).entryAddingRepository;
    final user = AppScope.userOf(parentContext);
    final forgottenState = ForgottenEntryState(
      date: bloc.state.date,
      userId: user.userId,
    );

    return BlocProvider(
      create: (context) => ForgottenEntryCubit(
          entryAddingRepository: entryAddingRepository,
          initialState: forgottenState),
      child: BlocBuilder<ForgottenEntryCubit, ForgottenEntryState>(
        builder: (context, state) {
          return Column(
            children: [
              // Header
              Text(
                'School attendance request',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              // Content
              // Date
              Text(
                state.date.toString(),
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // User
              Text(
                user.name ?? 'User Name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 22),
              // TextField
              _CommentTextField(),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  child: Text(
                    'Send request',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onPressed: () {
                    final cubit = context.read<ForgottenEntryCubit>();
                    cubit.sendForgottenEntryRequest();
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

/// Comment text field
class _CommentTextField extends StatelessWidget {
  _CommentTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgottenEntryCubit, ForgottenEntryState>(
      // buildWhen: (previous, current) => previous.reason != current.reason,
      builder: (context, state) {
        return TextFormField(
          // key: const Key('loginForm_emailInput_textField'),
          onChanged: (reason) =>
              context.read<ForgottenEntryCubit>().reasonChanged(reason),
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

            // suffixIcon: (state.email.toString().isNotEmpty)
            //     ? InkWell(
            //         onTap: () {
            //           context.read<LoginCubit>().emailClear();
            //           controllerEmail.clear();
            //         },
            //         child: const Icon(
            //           Icons.clear,
            //           color: MyAppColorScheme.secondaryText,
            //           size: 16,
            //         ),
            //       )
            //     : null,
            focusedBorder: MyThemeTextField.focusedBorder,
            focusedErrorBorder: MyThemeTextField.errorBorder,
            errorBorder: MyThemeTextField.errorBorder,
            contentPadding: const EdgeInsets.all(14),
            border: MyThemeTextField.textFieldInputBorder,
            label: Text(
              'Reason',
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


// /// AuthBUTTON
// class _AuthButtonWidget extends StatelessWidget {
//   const _AuthButtonWidget();

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginCubit, LoginState>(
//       builder: (context, state) {
//         if (state.email.isNotEmpty &&
//             state.password.isNotEmpty &&
//             state.status != LoginStatus.failure) {
//           return ElevatedButton(
//             onPressed: () {
//               context.read<LoginCubit>().logInWithCredentials();
//             },
//             // state.isValid
//             //     ? () =>
//             //     context.read<LoginCubit>().logInWithCredentials()
//             //     : null,
//             child: Text(
//               Localization.of(context).logInButtonName,
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Colors.white,
//                     //fontWeight: FontWeight.w500
//                   ),
//             ),
//           );
//         } else if (state.status == LoginStatus.inProgress) {
//           return ElevatedButton(
//             onPressed: () {},
//             child: const CircularProgressIndicator(
//               color: Colors.white,
//             ),
//           );
//         } else {
//           return ElevatedButton(
//             onPressed: () {},
//             style: const ButtonStyle(
//                 backgroundColor: WidgetStatePropertyAll(Colors.grey)),
//             child: Text(
//               Localization.of(context).logInButtonName,
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     color: Colors.white,
//                     //fontWeight: FontWeight.w500
//                   ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }