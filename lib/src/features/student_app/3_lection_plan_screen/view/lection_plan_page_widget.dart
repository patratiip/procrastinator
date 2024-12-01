import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:settings_repository/src/models/color_scheme_my.dart';
import 'package:procrastinator/src/shared/view/widgets/lesson_card_component.dart';
import 'package:procrastinator/src/features/student_app/1_student_main_screen/today_lection_widget/view/today_lection_widget.dart';
import 'package:procrastinator/src/features/student_app/3_lection_plan_screen/bloc/lection_plan_bloc.dart';

class KursplanPageWidget extends StatelessWidget {
  const KursplanPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          // keyboardDismissBehavior:
          //     ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.only(right: 16, left: 16, bottom: 44),
          primary: true,
          child: Column(
            children: [
              //
              const TodayLectionWidget(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Localization.of(context).lectionsListWidgetHeader,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  BlocBuilder<LectionPlanBloc, LectionPlanState>(
                      builder: (context, state) {
                    if (state is LectionPlanLoadedState) {
                      final filteredLections = state.lectionsList
                          .where(
                              (lection) => lection.date.isAfter(DateTime.now()))
                          .toList();
                      return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: filteredLections.length,
                          //itemExtent: 68,
                          itemBuilder: (BuildContext context, int index) {
                            // final lesson = _filteredLessons[index];
                            return LessonCardComponent(
                                entryData: filteredLections[index]);
                          });
                    } else if (state is LectionPlanLoadingState) {
                      return const Center(
                          child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          color: MyAppColorScheme.primary,
                        ),
                      ));
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
