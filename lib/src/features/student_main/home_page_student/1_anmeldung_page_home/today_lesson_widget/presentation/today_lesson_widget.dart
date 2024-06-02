import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/components/elements_components/no_lessons_component.dart';
import 'package:procrastinator/src/features/components/elements_components/today_lesson_card_component.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/today_lesson_widget/bloc/today_lesson_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/today_lesson_widget/domain/today_lection_repository.dart';

class HeutigeUnterrichtWidget extends StatelessWidget {
  const HeutigeUnterrichtWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('heut');
    return BlocProvider(
      create: (context) => TodayLessonBloc(lectionsRepository: GetIt.I<TodayLectionFirestoreRepository>())..add(LoadTodayLection()),
      child: BlocBuilder<TodayLessonBloc, TodayLessonState>(
        builder: (context, state) {
          if (state is TodayLectionLoaded) {
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Heutige Lektion',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TodayLessonCardComponent(
                        entryData: state.todayLection!,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is TodayLectionLoading) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heutige Lektion',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    constraints: const BoxConstraints(maxWidth: 600),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          color: MyAppColorScheme.primary,
                        ),
                      ),
                    )),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heutige Lektion',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    constraints: const BoxConstraints(maxWidth: 600),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Center(child: NoLessonCardComponent())),
              ],
            );
          }
        },
      ),
    );
  }
}
