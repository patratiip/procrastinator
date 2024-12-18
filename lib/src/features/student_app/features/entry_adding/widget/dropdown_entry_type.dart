import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';

/// {@template entry_type_dropdown}
/// Widget that shows [EntryTypeDropdownWidget].
/// {@endtemplate}
class EntryTypeDropdownWidget extends StatelessWidget {
  /// {@macro entry_type_dropdown}
  const EntryTypeDropdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// Aviable [EntryType]'s
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
      child: BlocBuilder<EntryAddingBloc, EntryAddingState>(
        builder: (context, state) {
          final selectedItem = state.entryType != null
              ? dropDownCalendarOptions
                  .where((element) => element.value == state.entryType)
                  .first
                  .value
              : null;
          return DropdownMenu(
            enableSearch: false,
            expandedInsets: EdgeInsets.zero,
            hintText: Localization.of(context).entryTypeDropdownHintText,
            textStyle: Theme.of(context).textTheme.titleMedium,

            // Entries
            dropdownMenuEntries: dropDownCalendarOptions,
            initialSelection: selectedItem,

            // Input decoration
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
            ),

            // Menu style
            menuStyle: MenuStyle(
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surface),
                surfaceTintColor:
                    const WidgetStatePropertyAll(Colors.transparent),
                shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                shape: WidgetStatePropertyAll(OutlinedBorder.lerp(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    const RoundedRectangleBorder(),
                    0.1))),

            // Sending [entryType] to bloc
            onSelected: (entryType) {
              final bloc = BlocProvider.of<EntryAddingBloc>(context);
              bloc.add(EntryAddingEvent.stateDataChanged(entryType: entryType));
            },
          );
        },
      ),
    );
  }
}
