import 'package:entry_repository/entry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/loosed_lesson_card_component.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/bloc/loosed_entrys_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';

class LoosedEntrysListWidget extends StatelessWidget {
  const LoosedEntrysListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('loosed');
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: BlocProvider(
          create: (context) => LoosedEntrysBloc(
            EntrysListBloc(
                entrysRepository: GetIt.I<FirebaseEntryRepository>()),
            KursplanBloc(
                lectionsRepository: GetIt.I<FirebaseLectionRepository>()),
            comaringRepository: GetIt.I<ComparingLectionsAndEntriesService>(),
          ),
          child: BlocBuilder<LoosedEntrysBloc, LoosedEntrysState>(
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
      ),
    );
  }
}
