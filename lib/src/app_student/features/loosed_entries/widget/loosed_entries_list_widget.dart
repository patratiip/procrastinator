import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/app_student/features/loosed_entries/widget/loosed_entry_widget.dart';
import 'package:procrastinator/src/app_student/features/loosed_entries/bloc/loosed_entries_bloc/loosed_entries_bloc.dart';
import 'package:procrastinator/src/ui_kit/widget/my_circular_progress.dart';

/// {@template loosed_entries_list_widget}
/// Widget that shows [LoosedEntriesListWidget].
/// {@endtemplate}
class LoosedEntriesListWidget extends StatelessWidget {
  /// {@macro loosed_entries_list_widget}
  const LoosedEntriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoosedEntriesBloc, LoosedEntriesState>(
      builder: (context, state) {
        if (state.lectionsWithoutEntryList.isNotEmpty) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        Localization.of(context).loosedEntriesWidgetHeader,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: state.lectionsWithoutEntryList.length < 3
                          ? state.lectionsWithoutEntryList.length
                          : 3,
                      itemBuilder: (BuildContext context, int index) {
                        return LoosedEntryWidget(
                          lection: state.lectionsWithoutEntryList[index],
                        );
                      }),
                ],
              ),
            ),
          );
        } else if (state.compairing) {
          return const MyCircularProgress(size: 40);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
