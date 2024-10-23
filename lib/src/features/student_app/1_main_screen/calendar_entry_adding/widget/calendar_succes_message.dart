import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/calendar_entry_adding/bloc/calendar_bloc.dart';



/// Succes Message
class SuccesMessageCalendarWidget extends StatelessWidget {
  const SuccesMessageCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
      if (state.status == CalendarStateStatus.allDone) {
        return Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            color: MyAppColorScheme.sucsessColor,
            child: Text(
              Localization.of(context).allEntriesAddedSuccessMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    //fontWeight: FontWeight.w500
                  ),
            ));
      } else {
        return const SizedBox(
            // height: 24
            );
      }
    });
  }
}