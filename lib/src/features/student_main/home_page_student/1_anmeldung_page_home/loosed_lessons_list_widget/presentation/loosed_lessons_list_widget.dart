import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/components/elements_components/lesson_card_component.dart';
import 'package:procrastinator/src/features/components/elements_components/loosed_lesson_card_component.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/domain/entry_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/bloc/loosed_entrys_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/loosed_lessons_list_widget/domain/comaring_loosed_lections_repository.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

import '../../../../../../core/data/functions/loosed_entrys_function.dart';
import '../../../../../../../old_files/fake_data/anmeldungen_fake_data/anmeldungen_fake.dart';
import '../../../../../../../old_files/fake_data/kursplan_fake_data/kursplan_fake.dart';

class LoosedEntrysListWidget extends StatefulWidget {
  const LoosedEntrysListWidget({super.key});

  @override
  State<LoosedEntrysListWidget> createState() => _LoosedEntrysListWidgetState();
}

class _LoosedEntrysListWidgetState extends State<LoosedEntrysListWidget> {
  final _loosedLectionsListBloc = LoosedEntrysBloc(
      GetIt.I<LectionFirestoreRepository>(),
      GetIt.I<EntryFirestoreRepository>(),
      GetIt.I<ComparingLectionsAndEntrysRepository>());

  final _kursplanQueryList = fakeDataLessons;
  final _studentLessonsList = fakePittyAnmeldungen;
  // List<KursplanEntry> _loosedLessonsList = [];
  var loosedEntrysFunction = LoosedEntrysFunction();

  @override
  void initState() {
    _loosedLectionsListBloc.add(ComairingLectionsAndVisits());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<LoosedEntrysBloc, LoosedEntrysState>(
        bloc: _loosedLectionsListBloc,
        builder: (context, state) {
          if (state is ComaredEntrysState) {
            return ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return LoosedLessonCardComponent(
                    lessonData: state.loosedLectionsList[index],
                  );
                });
          } else {
            return const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  color: MyAppColorScheme.primary,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
