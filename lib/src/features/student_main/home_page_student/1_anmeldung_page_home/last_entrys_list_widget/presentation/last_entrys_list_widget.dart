import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/domain/entry_repository.dart';

import '../../../../../components/elements_components/entrys_card_component.dart';

class LastEntrysListWidget extends StatefulWidget {
  LastEntrysListWidget({super.key});

  @override
  State<LastEntrysListWidget> createState() => _LastEntrysListWidgetState();
}

class _LastEntrysListWidgetState extends State<LastEntrysListWidget> {
  final _block = LastEntrysListBloc(GetIt.I<EntryFirestoreRepository>());

  @override
  void initState() {
    _block.add(LoadLastEntrys());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: BlocBuilder<LastEntrysListBloc, LastEntrysListState>(
            bloc: _block,
            builder: (context, state) {
              if (state is LastEntrysListLoaded) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Letzte 5 Anmeldungen',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: state.userVisits.length,
                          itemBuilder: (BuildContext context, int index) {
                            return EntrysCardComponent(
                              visitData: state.userVisits[index],
                            );
                          })
                    ],
                  ),
                );
              } else if (state is LastEntrysListLoading) {
                return const Center(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    color: MyAppColorScheme.primary,
                  ),
                ));
              } else {
                // return const Center(
                //     child: SizedBox(
                //   height: 100,
                //   width: 100,
                //   child: CircularProgressIndicator(),
                return Center(
                    child: Container(
                  height: 1000,
                  width: 100,
                  color: Colors.red,
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
