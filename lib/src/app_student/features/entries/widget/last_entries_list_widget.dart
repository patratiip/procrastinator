import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/app_student/features/entries/widget/entry_widget.dart';
import 'package:procrastinator/src/app_student/features/entries/bloc/last_entries_list_bloc/last_entries_list_bloc.dart';
import 'package:procrastinator/src/ui_kit/widget/my_circular_progress.dart';

/// {@template last_entries_list_widget}
/// Shows [LastEntriesListWidget].
/// {@endtemplate}

class LastEntriesListWidget extends StatelessWidget {
  /// {@macro last_entries_list_widget}
  const LastEntriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Change displaing logic to show progress indicator
    return BlocBuilder<EntriesListBloc, LastEntriesListState>(
      builder: (context, state) {
        if (state.entriesList.isNotEmpty) {
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
                        Localization.of(context).lastFiveEntriesWidgetHeader,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      BlocBuilder<EntriesListBloc, LastEntriesListState>(
                          builder: (context, state) {
                        if (state.entriesList.isNotEmpty) {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: state.entriesList.length < 5
                                ? state.entriesList.length
                                : 5,
                            itemBuilder: (BuildContext context, int index) {
                              return EntryWidget(
                                entryData: state.entriesList[index],
                              );
                            },
                          );
                        } else if (state.loading) {
                          return const MyCircularProgress(size: 40);
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
