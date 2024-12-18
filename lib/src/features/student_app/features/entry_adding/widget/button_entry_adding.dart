import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';

/// {@template entry_adding_button}
/// Widget that shows [EntryAddingButton] in [CalendarEntryAddingWidget]
///{@endtemplate}
class EntryAddingButton extends StatelessWidget {
  /// {@macro entry_adding_button}
  const EntryAddingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryAddingBloc, EntryAddingState>(
      builder: (context, state) {
        // Button is enabled
        if (state.isValid) {
          return SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(MyAppColorScheme.primary),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))))),
                onPressed: () {
                  final bloc = BlocProvider.of<EntryAddingBloc>(context);
                  bloc.add(const EntryAddingEvent.add());
                },
                child: Text(
                  Localization.of(context).addEntryButtonText,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        //fontWeight: FontWeight.w500
                      ),
                )),
          );

          // Button is in Progress
        } else if (state.validating) {
          return SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(MyAppColorScheme.primary),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))))),
              onPressed: () {},
              child: const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );

          // Button is disabled
        } else {
          return SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.grey),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))))),
                onPressed: () {},
                child: Text(
                  Localization.of(context).addEntryButtonText,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        //fontWeight: FontWeight.w500
                      ),
                )),
          );
        }
      },
    );
  }
}
