import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_button_bloc/entry_adding_button_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_error_message_bloc/entry_adding_error_message_bloc.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

/// {@template error_message_calendar_widget}
/// Widget that shows error message in [CalendarEntryAddingWidget]
/// {@endtemplate}
class ErrorMessageCalendarWidget extends StatelessWidget {
  /// {@macro error_message_calendar_widget}
  const ErrorMessageCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EntryAddingBloc, EntryAddingState>(
          listener: (context, state) {
            if (state.invalid) {
              context.read<EntryAddingErrorMessageBloc>().add(
                  (EnableCalendarErrorMessageEvent(
                      errorType:
                          state.validationResponse!.stateInvalidityType!)));
            } else {
              context
                  .read<EntryAddingErrorMessageBloc>()
                  .add((DisableCalendarErrorMessageEvent()));
            }
          },
        ),
        BlocListener<EntryAddingButtonBloc, EntryAddingButtonState>(
          listener: (context, state) {
            if (state is CalendarEntryAddingButtonError) {
              context.read<EntryAddingErrorMessageBloc>().add(
                  (EnableCalendarErrorMessageEvent(
                      errorType: state.errorType)));
            } else if (state is CalendarEntryAddingButtonDistanceError) {
              context.read<EntryAddingErrorMessageBloc>().add(
                  (EnableCalendarErrorMessageEvent(
                      value: state.distance, errorType: state.errorType)));
            }
          },
        ),
      ],
      child: BlocBuilder<EntryAddingErrorMessageBloc,
          EntryAddingErrorMessageState>(
        builder: (context, state) => switch (state) {
          CalendarErrorMessageDisabled() => const SizedBox.shrink(),
          CalendarErrorMessageFutureError() => _ErrorTextWidget(
              text: Localization.of(context).calendarStateErrorMessage_future),
          CalendarErrorMessageSchoolOnlyToday() => _ErrorTextWidget(
              text: Localization.of(context)
                  .calendarStateErrorMessage_schoolTypeOnlyToday,
              // child: _ErrorActionButton(
              //     text: Localization.of(context)
              //         .calendarStateErrorMessage_buttonText_youAreForgot),
            ),
          CalendarErrorMessageEnrtyWithThisDateExists() => _ErrorTextWidget(
              text: Localization.of(context)
                  .calendarStateErrorMessage_thisDateExists),
          CalendarErrorMessageNoLessonsToday() => _ErrorTextWidget(
              text: Localization.of(context)
                  .calendarStateErrorMessage_noLessonsToday),
          CalendarErrorMessageDistanceToSchool() => _ErrorTextWidget(
              text: Localization.of(context)
                  .calendarStateErrorMessage_distanceToSchool(state.distance)),
          // TODO Location settings premission message
          CalendarErrorMessageErrorOnGeopositionCheck() =>
            const SizedBox.shrink(),
        },
      ),
    );
  }
}

class _ErrorTextWidget extends StatelessWidget {
  final String text;
  final Widget? child;
  const _ErrorTextWidget({super.key, this.child, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      color: MyAppColorScheme.errorColor,
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
