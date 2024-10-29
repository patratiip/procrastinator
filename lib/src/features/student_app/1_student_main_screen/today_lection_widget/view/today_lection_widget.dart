import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/shared/view/components/no_lessons_component.dart';
import 'package:procrastinator/src/shared/view/components/today_lesson_card_component.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/today_lection_widget/bloc/today_lection_bloc.dart';

class TodayLectionWidget extends StatelessWidget {
  const TodayLectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayLectionBloc, TodayLectionState>(
      builder: (context, state) {
        if (state is TodayLectionLoaded) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Localization.of(context).todayLectionWidgetHeader,
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
                Localization.of(context).todayLectionWidgetHeader,
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
                Localization.of(context).todayLectionWidgetHeader,
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
    );
  }
}
