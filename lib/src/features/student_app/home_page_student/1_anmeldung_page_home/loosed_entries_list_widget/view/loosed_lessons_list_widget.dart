import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/loosed_lesson_card_component.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_entries_list_widget/bloc/loosed_entries_bloc.dart';

class LoosedEntrysListWidget extends StatelessWidget {
  const LoosedEntrysListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('loosed');
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: BlocBuilder<LoosedEntriesBloc, LoosedEntriesState>(
          builder: (context, state) {
            if (state is ComaredEntrysState &&
                state.loosedLectionsList!.isNotEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Fehlende Anmeldungen',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     _loosedLectionsListBloc
                        //         .add(ComairingLectionsAndVisitsEvent());
                        //   },
                        //   child: Text('refresh'),
                        // )
                      ],
                    ),
                    ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: state.loosedLectionsList!.length < 3
                            ? state.loosedLectionsList!.length
                            : 3,
                        itemBuilder: (BuildContext context, int index) {
                          return LoosedLessonCardComponent(
                            lessonData: state.loosedLectionsList![index],
                          );
                        }),
                  ],
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
        ),
      ),
    );
  }
}
