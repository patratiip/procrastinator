import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/shared/view/widgets/loosed_lesson_card_component.dart';
import 'package:procrastinator/src/features/student_app/features/entries/bloc/loosed_entries_bloc/loosed_entries_bloc.dart';

class LoosedEntriesListWidget extends StatelessWidget {
  const LoosedEntriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoosedEntriesBloc, LoosedEntriesState>(
      builder: (context, state) {
        if (state is ComparedEntrysState) {
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
                      itemCount: state.loosedLectionsList.length < 3
                          ? state.loosedLectionsList.length
                          : 3,
                      itemBuilder: (BuildContext context, int index) {
                        return LoosedLessonCardComponent(
                          lection: state.loosedLectionsList[index],
                        );
                      }),
                ],
              ),
            ),
          );
        } else if (state is CompairingEntrysState) {
          return const Center(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                color: MyAppColorScheme.primary,
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
