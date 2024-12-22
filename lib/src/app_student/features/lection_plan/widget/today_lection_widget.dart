import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/widget/lection_bottom_sheet_content.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/widget/lection_widget.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/bloc/today_lection_bloc/today_lection_bloc.dart';
import 'package:procrastinator/src/ui_kit/widget/bottom_sheet_widget.dart';
import 'package:procrastinator/src/ui_kit/widget/card_widget.dart';
import 'package:procrastinator/src/ui_kit/widget/my_circular_progress.dart';

/// {@template today_lection_widget}
/// Shows [TodayLectionWidget].
/// {@endtemplate}

class TodayLectionWidget extends StatelessWidget {
  /// {@macro today_lection_widget}
  const TodayLectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const double height = 100;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              Localization.of(context).todayLectionWidgetHeader,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            BlocBuilder<TodayLectionBloc, TodayLectionState>(
                builder: (context, state) {
              if (state.lection != null) {
                // Lection for today
                return LectionWidget(
                  tappable: true,
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheetWidget(
                          child: LectionBottomSheetContent(
                              lection: state.lection!));
                    },
                  ),
                  lection: state.lection!,
                );
                // Is loading
              } else if (state.isLoading) {
                return const CardWidget(
                  height: height,
                  child: MyCircularProgress(),
                );
                // No lections today
              } else {
                return CardWidget(
                  height: height,
                  child: Center(
                      child: Text(Localization.of(context).noLessonsToday)),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
