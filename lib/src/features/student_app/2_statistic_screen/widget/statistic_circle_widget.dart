import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/app/di/app_scope.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/shared/view/widgets/statistic_progress_diagramm_component.dart';
import 'package:procrastinator/src/features/student_app/2_statistic_screen/bloc/statistic_diagramm_bloc.dart';

class StatisticCircle extends StatelessWidget {
  const StatisticCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final userDisplayname = AppScope.userOf(context).name;

    return Center(
      child: Container(
        // height: 500,
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Localization.of(context)
                            .userNameAndEntriesHeader(userDisplayname!),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    BlocBuilder<StatisticDiagrammBloc, StatisticDiagrammState>(
                      builder: (context, state) {
                        if (state is LoadedEntriesCountState) {
                          return IconButton(

                              //TODO Add statistic download as CSV feature
                              onPressed: () {},
                              icon: const Icon(Icons.cloud_download_rounded));
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    )
                  ],
                ),
              ),
              BlocBuilder<StatisticDiagrammBloc, StatisticDiagrammState>(
                builder: (context, state) {
                  if (state is LoadedEntriesCountState) {
                    final sickDays = state.sickCount ?? 0;
                    final loosedDays = state.looseCount ?? 0;
                    final possibleLooseDays =
                        // (state.totalDays ~/ 10) - sickDays - loosedDays;
                        state.totalDays ~/ 10;

                    return Column(
                      children: [
                        /// DIAGRAMM Widget
                        state.schoolVisitsCount == null &&
                                state.homeOfficeCount == null
                            ? const SizedBox.shrink()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(top: 44, bottom: 32),
                                child: SizedBox(
                                  height: 220,
                                  width: 220,
                                  child: StatisticProgressDiagrammComponent(
                                    totalVisits: state.totalDays,
                                    schoolVisits: state.schoolVisitsCount,
                                    homeOffice: state.homeOfficeCount,
                                  ),
                                ),
                              ),

                        /// Percents
                        NumbersWidget(
                          schoolQty: state.schoolVisitsCount,
                          homeQty: state.homeOfficeCount,
                          totalVisits: state.totalDays,
                        ),

                        /// Total Days
                        state.schoolVisitsCount == null &&
                                state.homeOfficeCount == null
                            ? const SizedBox.shrink()
                            : TotalDaysIndicator(
                                schoolQty: state.schoolVisitsCount,
                                homeQty: state.homeOfficeCount,
                                totalVisits: state.totalDays,
                              ),

                        // /// Sick Days
                        // sickDays != 0
                        //     ? SickDaysIndicator(sickDays, possibleLooseDays)
                        //     : const SizedBox.shrink(),

                        /// Loosed Days
                        loosedDays != 0
                            ? LoosedDaysIndicator(
                                loosedDays + sickDays, possibleLooseDays)
                            : const SizedBox.shrink(),
                      ],
                    );
                  } else if (state is LoadingEntriesCountState) {
                    return const Center(
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          color: MyAppColorScheme.primary,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child:
                          Text(Localization.of(context).youHaveNoOneEntryAdded),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumbersWidget extends StatelessWidget {
  final int? schoolQty;
  final int? homeQty;
  final int totalVisits;
  const NumbersWidget(
      {super.key, this.schoolQty, this.homeQty, required this.totalVisits});

  @override
  Widget build(BuildContext context) {
    final percent = NumberFormat("##%");

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          /// School percent
          schoolQty != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        Localization.of(context)
                            .statisticWidgetNDays(schoolQty!),
                        style: Theme.of(context).textTheme.bodyLarge),
                    Text(
                      '${(percent.format(schoolQty! / totalVisits)).toString()} ',
                      style: const TextStyle(
                          color: MyAppColorScheme.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      Localization.of(context).inSchool,
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : const SizedBox.shrink(),

          /// Home percent
          homeQty != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      Localization.of(context).statisticWidgetNDays(homeQty!),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      (percent.format(homeQty! / totalVisits)).toString(),
                      style: const TextStyle(
                          color: MyAppColorScheme.secondary,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      Localization.of(context).atHomeStatisticWidget,
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

class TotalDaysIndicator extends StatelessWidget {
  final int? schoolQty;
  final int? homeQty;
  final int totalVisits;
  const TotalDaysIndicator(
      {super.key, this.schoolQty, this.homeQty, required this.totalVisits});

  @override
  Widget build(BuildContext context) {
    final schoolVisits = schoolQty ?? 0;
    final homeOffice = homeQty ?? 0;
    final entiesQty = schoolVisits + homeOffice;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 12,
          right: 16,
          left: 16,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            LinearProgressIndicator(
              value: entiesQty / totalVisits,
              color: MyAppColorScheme.secondary,
              backgroundColor: const Color.fromARGB(33, 125, 125, 125),
              minHeight: 40,
              borderRadius: BorderRadius.circular(12),
            ),
            Text(
                Localization.of(context)
                    .totalEntiesTotalVisitsDaysStatisticWidget(
                        entiesQty, totalVisits),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class LoosedDaysIndicator extends StatelessWidget {
  final int loosedQty;
  final int possibleLooseDays;
  const LoosedDaysIndicator(this.loosedQty, this.possibleLooseDays,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          bottom: 24,
          right: 16,
          left: 16,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            LinearProgressIndicator(
              value: loosedQty / possibleLooseDays,
              color: MyAppColorScheme.errorColor,
              backgroundColor: const Color.fromARGB(33, 125, 125, 125),
              minHeight: 24,
              borderRadius: BorderRadius.circular(8),
            ),
            Text(
                Localization.of(context)
                    .loosedFromPossibleDays(loosedQty, possibleLooseDays),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

// class SickDaysIndicator extends StatelessWidget {
//   final int sickQty;
//   final int possibleLooseDays;
//   const SickDaysIndicator(this.sickQty, this.possibleLooseDays, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.only(
//           top: 12,
//           bottom: 12,
//           right: 16,
//           left: 16,
//         ),
//         child: Stack(
//           alignment: AlignmentDirectional.center,
//           children: [
//             LinearProgressIndicator(
//               value: sickQty / possibleLooseDays,
//               color: MyAppColorScheme.warningColor,
//               backgroundColor: const Color.fromARGB(33, 125, 125, 125),
//               minHeight: 24,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             Text(
//                 Localization.of(context)
//                     .sickDaysFromPossible(sickQty, possibleLooseDays),
//                 textAlign: TextAlign.center),
//           ],
//         ),
//       ),
//     );
//   }
// }


