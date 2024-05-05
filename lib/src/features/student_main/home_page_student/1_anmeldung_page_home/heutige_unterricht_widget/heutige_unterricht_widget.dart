import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:procrastinator/src/features/components/elements_components/lesson_card_component.dart';

import '../../../../../../old_files/fake_data/kursplan_fake_data/kursplan_fake.dart';

class HeutigeUnterrichtWidget extends StatelessWidget {
  HeutigeUnterrichtWidget({super.key});

  final _lesson = fakeDataLessons[0];

  @override
  Widget build(BuildContext context) {
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
              LessonCardComponent(
                entryData: _lesson,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
