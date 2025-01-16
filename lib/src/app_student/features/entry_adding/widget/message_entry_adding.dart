import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/app_student/features/entries/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/widget/forgotten_entry_bottom_scheet_content.dart';
import 'package:procrastinator/src/core/utils/extensions/context_extension.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/ui_kit/widget/bottom_sheet_widget.dart';

/// {@template error_message_calendar_widget}
/// Widget that shows message in [CalendarEntryAddingWidget] if it's needed
/// {@endtemplate}
class MessageCalendarWidget extends StatelessWidget {
  /// {@macro error_message_calendar_widget}
  const MessageCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Feature Redux state
    final state = context.state.reduxEntryAddingState;

    if (!state.isValid) {
      return Container(
        child: switch (state.validationResponse!.stateValidityType) {
          StateValidityType.noEntryType => const SizedBox.shrink(),
          StateValidityType.futureError => _ValidityStateWidget(
              text: Localization.of(context).calendarStateErrorMessage_future),
          StateValidityType.schoolOnlyToday => _ValidityStateWidget(
              text: Localization.of(context)
                  .calendarStateErrorMessage_schoolTypeOnlyToday,
              actionButton: _ErrorActionButton(
                  text: Localization.of(context)
                      .calendarStateErrorMessage_buttonText_youAreForgot),
            ),
          StateValidityType.enrtyWithThisDateExists => _ValidityStateWidget(
              text: Localization.of(context)
                  .calendarStateErrorMessage_thisDateExists),
          StateValidityType.noLessonsToday => _ValidityStateWidget(
              text: Localization.of(context)
                  .calendarStateErrorMessage_noLessonsToday),
          StateValidityType.distanceToSchool => _ValidityStateWidget(
              text: Localization.of(context)
                  .calendarStateErrorMessage_distanceToSchool(
                      state.validationResponse!.value)),

          //TODO: handle cases down
          StateValidityType.errorOnGeopositionCheck =>
            const _ValidityStateWidget(text: ''),
          StateValidityType.unexpectedError =>
            const _ValidityStateWidget(text: 'Unexpected Error'),
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

/// {@template _validity_state_widget}
/// [_ValidityStateWidget] shows a invalidity message from [EntryAddingBloc].
/// {@endtemplate}
/// {@macro _validity_state_widget}
class _ValidityStateWidget extends StatelessWidget {
  final bool isSuccess;
  final String text;
  final Widget? actionButton;

  const _ValidityStateWidget({
    super.key,
    this.actionButton,
    required this.text,
    this.isSuccess = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      color: isSuccess
          ? MyAppColorScheme.sucsessColor
          : MyAppColorScheme.errorColor,
      child: Column(
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
          actionButton ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _ErrorActionButton extends StatelessWidget {
  final String text;
  const _ErrorActionButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white)),
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => SafeArea(
          child: BottomSheetWidget(
              child: ForgottenEntryBottomSheetContent(parentContext: context)),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: MyAppColorScheme.errorColor,
            ),
      ),
    );
  }
}
