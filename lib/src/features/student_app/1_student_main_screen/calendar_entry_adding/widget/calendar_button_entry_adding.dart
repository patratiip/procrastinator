import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/calendar_entry_adding/bloc/calendar_bloc.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/loosed_entries_list_widget/bloc/loosed_entries_bloc.dart';



/// BUTTON
class EntryAddingButton extends StatelessWidget {
  const EntryAddingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoosedEntriesBloc, LoosedEntriesState>(
      listener: (context, state) {
        if (state is CopmaredAllClear) {
          //TODO add Something to add Event
          // context.read<CalendarBloc>().add(CalendarNothingToAddEvent());
        }
      },
      child: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state.status == CalendarStateStatus.readyToAdding) {
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
                    final bloc = BlocProvider.of<CalendarBloc>(context);

                    bloc.add(CalendarAddEntry());
                  },
                  child: Text(
                    Localization.of(context).addEntryButtonText,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          //fontWeight: FontWeight.w500
                        ),
                  )),
            );
          } else if (state.status == CalendarStateStatus.inProgress) {
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

            ////unactive
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
      ),
    );
  }
}