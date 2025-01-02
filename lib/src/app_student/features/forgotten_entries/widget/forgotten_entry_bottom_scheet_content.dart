import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/ui_kit/styles/text_field_theme.dart';
import 'package:procrastinator/src/platform/app/di/app_scope.dart';
import 'package:procrastinator/src/app_student/di/student_app_scope.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/bloc/forgotten_entry_cubit/forgotten_entry_cubit.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/ui_kit/widget/my_circular_progress.dart';
import 'package:procrastinator/src/ui_kit/widget/user_image_widget.dart';

class ForgottenEntryBottomSheetContent extends StatelessWidget {
  final BuildContext parentContext;
  const ForgottenEntryBottomSheetContent(
      {super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yy');
    final bloc = BlocProvider.of<EntryAddingBloc>(parentContext);
    final forgottenEntryRepository =
        StudentAppScope.depConOf(parentContext).forgottenEntryRepository;
    final user = AppScope.userOf(parentContext);
    final forgottenState = ForgottenEntryState(
      date: bloc.state.date,
      userId: user.userId,
    );

    return BlocProvider(
      create: (context) => ForgottenEntryCubit(
          forgottenEntryRepository: forgottenEntryRepository,
          initialState: forgottenState),
      child: BlocListener<ForgottenEntryCubit, ForgottenEntryState>(
        listener: (context, state) {
          if (state.status == ForgottenEntryStateStatus.success) {
            Future<void>.delayed(const Duration(seconds: 3), () {
              Navigator.pop(context);
            });
          }
        },
        child: BlocBuilder<ForgottenEntryCubit, ForgottenEntryState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header
                Text(
                  Localization.of(context).schoolAttendanceRequest,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 32),
                // Content
                // User image
                UserImageWidget(
                  userImageUrl: user.photoURL,
                  size: 80,
                ),
                const SizedBox(height: 16),
                // User
                Text(
                  user.name ?? 'User Name',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Date
                Text(
                  '${Localization.of(context).dateText}: ${dateFormat.format(state.date)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const SizedBox(height: 16),
                // TextField
                const _CommentTextField(),
                const SizedBox(height: 16),
                const SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: _SendForgottenEntryRequestButton(),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SendForgottenEntryRequestButton extends StatelessWidget {
  const _SendForgottenEntryRequestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgottenEntryCubit, ForgottenEntryState>(
      builder: (context, state) {
        if (state.status == ForgottenEntryStateStatus.idle &&
            state.reason.isNotEmpty) {
          return ElevatedButton(
            child: Text(
              Localization.of(context).sendRequestButtonText,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
            onPressed: () {
              final cubit = context.read<ForgottenEntryCubit>();
              cubit.sendForgottenEntryRequest();
            },
          );
        } else if (state.status == ForgottenEntryStateStatus.inProgress) {
          return ElevatedButton(
            child: const MyCircularProgress(size: 20, color: Colors.white),
            onPressed: () {},
          );
        } else if (state.status == ForgottenEntryStateStatus.success) {
          return ElevatedButton(
            style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(MyAppColorScheme.sucsessColor)),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: AnimateIcon(
                      key: UniqueKey(),
                      onTap: () {},
                      iconType: IconType.continueAnimation,
                      height: 28,
                      width: 28,
                      color: Colors.white,
                      animateIcon: AnimateIcons.cloud),
                ),
                Text(Localization.of(context).requestSendedButtonText,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white)),
              ],
            ),
          );
        } else {
          return ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.grey)),
            onPressed: () {},
            child: Text(
              Localization.of(context).sendRequestButtonText,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          );
        }
      },
    );
  }
}

/// Comment text field
class _CommentTextField extends StatelessWidget {
  const _CommentTextField();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgottenEntryCubit, ForgottenEntryState>(
      builder: (context, state) {
        return ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 100),
          child: TextFormField(
            // key: const Key('loginForm_emailInput_textField'),
            onChanged: (reason) =>
                context.read<ForgottenEntryCubit>().reasonChanged(reason),
            autofocus: false,
            minLines: 1,
            maxLines: null,
            maxLength: 300,

            //KEYBOARD properties
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.done,

            //CURSOR
            cursorColor: MyAppColorScheme.primary,

            // CORRECTIONS
            autocorrect: false,
            enableSuggestions: false,
            textCapitalization: TextCapitalization.none,
            decoration: InputDecoration(
              focusedBorder: MyThemeTextField.focusedBorder,
              focusedErrorBorder: MyThemeTextField.errorBorder,
              errorBorder: MyThemeTextField.errorBorder,
              contentPadding: const EdgeInsets.all(14),
              border: MyThemeTextField.textFieldInputBorder,
              label: Text(
                Localization.of(context).reasonTextFieldLabel,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ),
        );
      },
    );
  }
}
