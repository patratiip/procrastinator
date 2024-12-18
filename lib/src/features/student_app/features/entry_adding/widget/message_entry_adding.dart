import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

/// {@template error_message_calendar_widget}
/// Widget that shows message in [CalendarEntryAddingWidget] if it's needed
/// {@endtemplate}
class MessageCalendarWidget extends StatelessWidget {
  /// {@macro error_message_calendar_widget}
  const MessageCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryAddingBloc, EntryAddingState>(
        builder: (context, state) {
      if (!state.isValid) {
        return Container(
          child: switch (state.validationResponse!.stateValidityType) {
            StateValidityType.noEntryType => const SizedBox.shrink(),
            StateValidityType.futureError => _ValidityStateTextWidget(
                text:
                    Localization.of(context).calendarStateErrorMessage_future),
            StateValidityType.schoolOnlyToday => _ValidityStateTextWidget(
                text: Localization.of(context)
                    .calendarStateErrorMessage_schoolTypeOnlyToday,
                // child: _ErrorActionButton(
                //     text: Localization.of(context)
                //         .calendarStateErrorMessage_buttonText_youAreForgot),
              ),
            StateValidityType.enrtyWithThisDateExists =>
              _ValidityStateTextWidget(
                  text: Localization.of(context)
                      .calendarStateErrorMessage_thisDateExists),
            StateValidityType.noLessonsToday => _ValidityStateTextWidget(
                text: Localization.of(context)
                    .calendarStateErrorMessage_noLessonsToday),
            StateValidityType.distanceToSchool => _ValidityStateTextWidget(
                text: Localization.of(context)
                    .calendarStateErrorMessage_distanceToSchool(
                        state.validationResponse!.value)),

            //TODO: handle cases down
            StateValidityType.errorOnGeopositionCheck =>
              const _ValidityStateTextWidget(text: ''),
            StateValidityType.unexpectedError =>
              const _ValidityStateTextWidget(text: 'Unexpected Error'),
          },
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}

/// {@template _error_text_widget}
/// [_ValidityStateTextWidget] shows a invalidity message from [EntryAddingBloc].
/// {@endtemplate}
/// {@macro _error_text_widget}
class _ValidityStateTextWidget extends StatelessWidget {
  final bool isSuccess;
  final String text;
  final Widget? child;
  const _ValidityStateTextWidget({
    super.key,
    this.child,
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
          child ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}

// class _ErrorActionButton extends StatelessWidget {
//   final String text;
//   const _ErrorActionButton({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: const ButtonStyle(
//           backgroundColor: WidgetStatePropertyAll(Colors.white)),
//       onPressed: () => showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return _BottomSheetContent();
//         },
//       ),
//       // {

//       //   // TODO: Add a bottom sheet with ...
//       //   final date = context.read<CalendarBloc>().state.date!;
//       //   final entryType = context.read<CalendarBloc>().state.entryType!;
//       //   context
//       //       .read<CalendarEntryAddingButtonBloc>()
//       //       .add(CalendarButtonAddEntryEvent(date, entryType));
//       // },
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: Theme.of(context).textTheme.labelLarge!.copyWith(
//               color: MyAppColorScheme.errorColor,
//             ),
//       ),
//     );
//   }
// }

// class _BottomSheetContent extends StatelessWidget {
//   const _BottomSheetContent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Column(
//           children: [
//             Text(Localization.of(context)
//                 .calendarStateErrorMessage_buttonText_youAreForgot)
//           ],
//         ),
//       ),
//     );
//   }
// }
