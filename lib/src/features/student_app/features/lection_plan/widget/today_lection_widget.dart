import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/widget/no_lection_widget.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/widget/today_lection_card.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/bloc/today_lection_bloc/today_lection_bloc.dart';

class TodayLectionWidget extends StatelessWidget {
  const TodayLectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayLectionBloc, TodayLectionState>(
        builder: (context, state) {
      if (state.lection != null) {
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
                  TodayLectionCard(
                    lection: state.lection!,
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (state.isLoading) {
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
                child: const Center(
                  child: NoLectionWidget(),
                )),
          ],
        );
      }
    });
  }
}
