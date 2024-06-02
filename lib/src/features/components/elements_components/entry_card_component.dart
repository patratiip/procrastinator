import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/data/last_entry_model.dart';

import '../../../core/styles/color_scheme_my.dart';

class EntryCardComponent extends StatelessWidget {
  final Entry visitData;
  EntryCardComponent({super.key, required this.visitData});

  final dateFormat = DateFormat('dd.MM.yy');

  @override
  Widget build(BuildContext context) {
    final _block = BlocProvider.of<LastEntrysListBloc>(context);
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
              if (visitData.schoolVisit == true) const Text('Schule'),
              if (visitData.homeOffice == true) const Text('Heim'),
              if (visitData.krank == true) const Text('Krank'),
              if (visitData.fehl == true) const Text('Fehl'),
              Text(dateFormat.format(visitData.date!)),
              //Delete BUTTON
              IconButton(
                  onPressed: () {
                    _block.add(DeleteEntry(entryRef: visitData.visitID!));
                  },
                  icon: const Icon(Icons.delete_outline_outlined,
                      color: Colors.red)),
            ]),
      ),
    );
  }
}
