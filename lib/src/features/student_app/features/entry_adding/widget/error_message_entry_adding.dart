import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';

/// {@template error_message_calendar_widget}
/// Widget that shows error message in [CalendarEntryAddingWidget]
/// {@endtemplate}
class ErrorMessageCalendarWidget extends StatelessWidget {
  /// {@macro error_message_calendar_widget}
  const ErrorMessageCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryAddingBloc, EntryAddingState>(
        builder: (context, state) {
      if (state.validationResponse != null &&
          state.validationResponse!.stateInvalidityType !=
              StateInvalidityType.noEntryType) {
        return Container(
          child: switch (state.validationResponse!.stateInvalidityType) {
            StateInvalidityType.noEntryType => const SizedBox.shrink(),
            StateInvalidityType.futureError => _ErrorTextWidget(
                text:
                    Localization.of(context).calendarStateErrorMessage_future),
            StateInvalidityType.schoolOnlyToday => _ErrorTextWidget(
                text: Localization.of(context)
                    .calendarStateErrorMessage_schoolTypeOnlyToday,
                // child: _ErrorActionButton(
                //     text: Localization.of(context)
                //         .calendarStateErrorMessage_buttonText_youAreForgot),
              ),
            StateInvalidityType.enrtyWithThisDateExists => _ErrorTextWidget(
                text: Localization.of(context)
                    .calendarStateErrorMessage_thisDateExists),
            StateInvalidityType.noLessonsToday => _ErrorTextWidget(
                text: Localization.of(context)
                    .calendarStateErrorMessage_noLessonsToday),
            StateInvalidityType.distanceToSchool => _ErrorTextWidget(
                text: Localization.of(context)
                    .calendarStateErrorMessage_distanceToSchool(
                        state.validationResponse!.value)),
            StateInvalidityType.errorOnGeopositionCheck =>
              const _ErrorTextWidget(text: ''),
            StateInvalidityType.unexpectedError =>
              const _ErrorTextWidget(text: 'Unexpected Error'),
          },
        );
      } else {
        return const SizedBox.shrink();
      }
    });
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
