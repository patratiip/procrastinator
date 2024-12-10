import 'package:entry_repository/entry_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/features/entries/bloc/last_entries_list_bloc/last_entries_list_bloc.dart';

class EntryCardComponent extends StatelessWidget {
  final Entry visitData;
  EntryCardComponent({super.key, required this.visitData});

  final dateFormat = DateFormat('dd.MM.yy');

  @override
  Widget build(BuildContext context) {
    final block = BlocProvider.of<EntriesListBloc>(context);
    return Center(
      child: Container(
        height: 74,
        // width: 600,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                  width: 44,
                  height: 44,
                  constraints: const BoxConstraints(maxWidth: 600),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 150, 146, 249),
                      border:
                          Border.all(width: 1, color: MyAppColorScheme.primary),
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    if (visitData.entryType == EntryType.schoolVisit)
                      const Icon(
                        FontAwesomeIcons.schoolFlag,
                        color: Colors.white,
                        size: 20,
                      ),
                    if (visitData.entryType == EntryType.homeOffice)
                      const Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    if (visitData.entryType == EntryType.sick)
                      const Icon(
                        Icons.sick_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    if (visitData.entryType == EntryType.loosed)
                      const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                  ])),
              if (visitData.entryType == EntryType.schoolVisit)
                Text(Localization.of(context).schoolEntryType),
              if (visitData.entryType == EntryType.homeOffice)
                Text(Localization.of(context).homeEntryType),
              if (visitData.entryType == EntryType.sick)
                Text(Localization.of(context).sickEntryType),
              if (visitData.entryType == EntryType.loosed)
                Text(Localization.of(context).looseEntryType),
              Text(dateFormat.format(visitData.date)),
              //Delete BUTTON
              IconButton(
                  onPressed: () {
                    //TODO Add confirmation dialog with my design
                    showCupertinoDialog<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                        title: Text(
                            Localization.of(context).deleteEntryDialogHeader),
                        content: Text(Localization.of(context)
                            .deleteEntryShureTextDialog),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(Localization.of(context).noButtonText),
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: () {
                              block.add(DeleteEntryEvent(
                                  entryRef: visitData.visitID));
                              Navigator.pop(context);
                            },
                            child: Text(Localization.of(context).yesButtonText),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete_outline_outlined,
                      color: Colors.red)),
            ]),
      ),
    );
  }
}
