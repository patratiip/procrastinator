import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/student_app/features/calendar_entry_adding/bloc/calendar_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';

/// DROP
class DropDownEntry extends StatelessWidget {
  const DropDownEntry({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry> dropDownCalendarOptions = [
      DropdownMenuEntry(
          label: Localization.of(context).schoolEntryType,
          value: EntryType.schoolVisit),
      DropdownMenuEntry(
          label: Localization.of(context).homeEntryType,
          value: EntryType.homeOffice),
      DropdownMenuEntry(
          label: Localization.of(context).sickEntryType, value: EntryType.sick),
      DropdownMenuEntry(
          label: Localization.of(context).looseEntryType,
          value: EntryType.loosed),
    ];
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 22, left: 8, right: 8),

      // width: double.infinity,
      child: DropdownMenu(
        enableSearch: false,
        expandedInsets: EdgeInsets.zero,
        // width: double.infinity,
        hintText: Localization.of(context).entryTypeDropdownHintText,
        dropdownMenuEntries: dropDownCalendarOptions,
        textStyle: Theme.of(context).textTheme.titleMedium,
        // controller: ,

        ///INPUT
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),

        ///MENU
        menuStyle: MenuStyle(
            backgroundColor:
                WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
            surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
            shadowColor: const WidgetStatePropertyAll(Colors.transparent),
            // side: MaterialStatePropertyAll(BorderSide()),
            shape: WidgetStatePropertyAll(OutlinedBorder.lerp(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                const RoundedRectangleBorder(),
                0.1))),
        onSelected: (entryType) {
          final bloc = BlocProvider.of<CalendarBloc>(context);

          bloc.add(CalendarEntryTypeChanged(entryType: entryType));
        },
      ),
    );
  }
}
