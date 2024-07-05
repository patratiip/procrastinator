import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/entry_card_component.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';

class LastEntrysListWidget extends StatelessWidget {
  const LastEntrysListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('last');
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: BlocBuilder<EntrysListBloc, EntrysListState>(
            // buildWhen: (previous, current) {
            //   if (previous != current) {
            //     return true;
            //   }
            //   return false;
            // },
            builder: (context, state) {
              if (state is EntrysListLoadedState) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Letzte 5 Anmeldungen',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      // StreamBuilder(
                      //     stream: state.userVisits,
                      //     builder: (context, snapshot) {
                      //       if (!snapshot.hasData) return Container();
                      // return
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: state.userVisits!.length < 5
                              ? state.userVisits!.length
                              : 5,
                          itemBuilder: (BuildContext context, int index) {
                            return EntryCardComponent(
                              visitData: state.userVisits![index],
                            );
                          })
                      // }),
                    ],
                  ),
                );
              } else if (state is EntrysListLoadingState) {
                return const Center(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    color: MyAppColorScheme.primary,
                  ),
                ));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
