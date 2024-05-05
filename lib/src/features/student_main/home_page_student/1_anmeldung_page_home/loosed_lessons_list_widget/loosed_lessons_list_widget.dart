import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/data/functions/loosed_entrys_function.dart';
import '../../../../../../old_files/fake_data/anmeldungen_fake_data/anmeldungen_fake.dart';
import '../../../../../../old_files/fake_data/kursplan_fake_data/kursplan_fake.dart';
import '../../../../components/elements_components/loosed_lesson_card_component.dart';

class LoosedEntrysListWidget extends StatefulWidget {
  const LoosedEntrysListWidget({super.key});

  @override
  State<LoosedEntrysListWidget> createState() => _LoosedEntrysListWidgetState();
}

class _LoosedEntrysListWidgetState extends State<LoosedEntrysListWidget> {
  final _kursplanQueryList = fakeDataLessons;
  final _studentLessonsList = fakePittyAnmeldungen;
  // List<KursplanEntry> _loosedLessonsList = [];
  var loosedEntrysFunction = LoosedEntrysFunction();

  @override
  void initState() {
    // TODO: implement initState
    // _loosedLessonsList = LoosedEntrysFunction.result(studentsEntrys: _loosedLessonsList, kursplanLessons: _kursplanQueryList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<KursplanEntry>? loosedLessonsList = [];
    loosedLessonsList =
        loosedEntrysFunction.result(_studentLessonsList, _kursplanQueryList);

    final List<LoosedLessonCardComponent> _cards = loosedLessonsList!
        .map((anmeldung) => LoosedLessonCardComponent(lessonData: anmeldung))
        .toList();

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fehlende Anmeldungen',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Column(
            children: _cards,
          )
        ],
      ),
    );
  }
}
