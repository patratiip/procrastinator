import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/bloc/forgotten_entry_bloc/forgotten_entries_bloc.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/widget/forgotten_entries_list_widget.dart';
import 'package:procrastinator/src/ui_kit/widget/back_appbar_arrow.dart';
import 'package:procrastinator/src/ui_kit/widget/my_circular_progress.dart';

/// {@template forgotten_entries_request_screen}
/// Widget that shows [ForgottenEntriesRequestScreen]
/// {@endtemplate}
class ForgottenEntriesRequestScreen extends StatelessWidget {
  final ForgottenEntriesBloc forgottenEntriesBloc;

  const ForgottenEntriesRequestScreen(
      {super.key, required this.forgottenEntriesBloc});

  /// {@macro forgotten_entries_request_screen}

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: forgottenEntriesBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Forgotten Entries Requests'),
          leading: const BackAppbarArrow(),
        ),
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
          primary: true,
          child: BlocBuilder<ForgottenEntriesBloc, ForgottenEntriesState>(
            builder: (context, state) {
              if (state.requestsList.isNotEmpty) {
                return ForgottenEntriesListWidget(
                    requestList: state.requestsList);
              } else if (state.loading) {
                return const MyCircularProgress(size: 40);
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
