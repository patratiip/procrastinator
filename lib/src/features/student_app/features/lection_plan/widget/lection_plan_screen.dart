import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/widget/lection_list_widget.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/widget/today_lection_widget.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/bloc/lection_plan_bloc/lection_plan_bloc.dart';

class LectionPlanScreen extends StatelessWidget {
  const LectionPlanScreen({super.key});

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
              // Actual lection or no lection widget
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
                    if (state.lectionsList.isNotEmpty) {
                      return LectionListWidget(lectionList: state.lectionsList);
                    } else if (state.loading) {
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
