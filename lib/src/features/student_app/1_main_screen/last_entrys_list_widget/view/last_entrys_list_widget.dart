import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/entry_card_component.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';

class LastEntrysListWidget extends StatelessWidget {
  const LastEntrysListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntrysListBloc, EntriesListState>(
      builder: (context, state) {
        if (state is EntriesListLoadedState && state.userVisits!.isNotEmpty) {
          return Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 24),
                  child: Container(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Localization.of(context)
                                .lastFiveEntriesWidgetHeader,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
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
                        ],
                      )))));
        } else if (state is EntriesListLoadingState) {
          return const Center(
              child: SizedBox(
            height: 32,
            width: 32,
            child: CircularProgressIndicator(
              color: MyAppColorScheme.primary,
            ),
          ));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
