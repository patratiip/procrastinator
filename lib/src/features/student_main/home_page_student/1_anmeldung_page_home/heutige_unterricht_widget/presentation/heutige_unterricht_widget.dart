import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/components/elements_components/today_lesson_card_component.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/heutige_unterricht_widget/bloc/today_lesson_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/heutige_unterricht_widget/domain/today_lection_repository.dart';

class HeutigeUnterrichtWidget extends StatefulWidget {
  HeutigeUnterrichtWidget({super.key});

  @override
  State<HeutigeUnterrichtWidget> createState() =>
      _HeutigeUnterrichtWidgetState();
}

class _HeutigeUnterrichtWidgetState extends State<HeutigeUnterrichtWidget> {
  final _todayLessonBlock =
      TodayLessonBloc(GetIt.I<TodayLectionFirestoreRepository>());

  @override
  void initState() {
    // TODO: implement initState
    _todayLessonBlock.add(LoadTodayLection());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayLessonBloc, TodayLessonState>(
      bloc: _todayLessonBlock,
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
        } else {
          return const Center(
              child: SizedBox(
            height: 40,
            width: 40,
            child: CircularProgressIndicator(
              color: MyAppColorScheme.primary,
            ),
          ));
        }
      },
    );
  }
}
