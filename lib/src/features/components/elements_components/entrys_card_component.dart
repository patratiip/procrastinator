import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/data/last_entry_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/domain/entry_repository.dart';

import '../../../core/styles/color_scheme_my.dart';

class EntrysCardComponent extends StatelessWidget {
  final UserVisit visitData;
  EntrysCardComponent({super.key, required this.visitData});

  var dateFormat = DateFormat('dd.MM.yy');
  final _block = LastEntrysListBloc(GetIt.I<EntryFirestoreRepository>());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // height: 100,
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
                      color: Color.fromARGB(255, 150, 146, 249),
                      border:
                          Border.all(width: 1, color: MyAppColorScheme.primary),
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    if (visitData.schoolVisit == true)
                      const Icon(
                        FontAwesomeIcons.schoolFlag,
                        color: Colors.white,
                        size: 20,
                      ),
                    if (visitData.homeOffice == true)
                      const Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    if (visitData.krank == true)
                      const Icon(
                        Icons.sick_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    if (visitData.fehl == true)
                      const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28,
                      ),
                  ])),
              if (visitData.schoolVisit == true) Text('Schule'),
              if (visitData.homeOffice == true) Text('Heim'),
              if (visitData.krank == true) Text('Krank'),
              if (visitData.fehl == true) Text('Fehl'),
              Text(dateFormat.format(visitData.date!)),
              //Delete BUTTON
              IconButton(
                  onPressed: () {
                    _block.add(DeleteEntry(entryRef: visitData.visitID!));
                    // GetIt.I<EntryFirestoreRepository>().deleteVisit(visitData.visitID!);
                    // EntryFirestoreRepository().deleteVisit(visitData.visitID!);
                  },
                  icon: const Icon(Icons.delete_outline_outlined,
                      color: Colors.red)),
            ]),
      ),
    );
  }
}
