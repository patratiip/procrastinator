import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/student_app/di/student_app_scope.dart';
import 'package:procrastinator/src/features/student_app/features/forgotten_entries/bloc/forgotten_entry_bloc/forgotten_entries_bloc.dart';
import 'package:procrastinator/src/features/student_app/features/forgotten_entries/widget/forgotten_entries_list_widget.dart';
import 'package:procrastinator/src/ui_kit/widget/back_appbar_arrow.dart';
import 'package:procrastinator/src/ui_kit/widget/my_circular_progress.dart';

/// {@template forgotten_entries_request_screen}
/// Widget that shows [ForgottenEntriesRequestScreen]
/// {@endtemplate}
class ForgottenEntriesRequestScreen extends StatelessWidget {
  final BuildContext parentContext;

  const ForgottenEntriesRequestScreen({super.key, required this.parentContext});

  /// {@macro forgotten_entries_request_screen}

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ForgottenEntriesBloc>(parentContext);

    return Scaffold(
      appBar: AppBar(
        title: Text('Forgotten Entries Requests'),
        leading: const BackAppbarArrow(),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: true,
        child: BlocBuilder<ForgottenEntriesBloc, ForgottenEntriesState>(
          bloc: bloc,
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
    );
  }
}
