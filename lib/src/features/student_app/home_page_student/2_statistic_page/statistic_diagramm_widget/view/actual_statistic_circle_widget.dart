import 'package:entry_repository/entry_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/statistic_progress_diagramm_component.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/bloc/last_entrys_list_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/statistic_diagramm_widget/bloc/statistic_diagramm_bloc.dart';
import 'package:procrastinator/src/features/student_app/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_computing_service.dart';

class StatisticCircle extends StatelessWidget {
  const StatisticCircle({super.key});

  @override
  Widget build(BuildContext context) {
    ////TODO Get Total visits qty from firebase, user - group
    var totalVisits = 256;
    final user = FirebaseAuth.instance.currentUser;
    String? userDisplayname = user?.displayName;

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
                        '$userDisplayname Anmeldungen',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.cloud_download_rounded))
                  ],
                ),
              ),
              BlocBuilder<StatisticDiagrammBloc, StatisticDiagrammState>(
                                builder: (context, state) {
              if (state is LoadedEntrysCountState) {
                /////////DIAGRAMM Widget
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 44, bottom: 32),
                      child: SizedBox(
                        height: 220,
                        width: 220,
                        child: StatisticProgressDiagrammComponent(
                          totalVisits: totalVisits,
                          schoolVisits: state.schoolVisitsCount,
                          homeOffice: state.homeOfficeCount,
                        ),
                      ),
                    ),
                    NumbersWidget(
                      schoolQty: state.schoolVisitsCount,
                      homeQty: state.homeOfficeCount,
                      totalVisits: totalVisits,
                    ),
                    TotalDaysIndicator(
                      schoolQty: state.schoolVisitsCount,
                      homeQty: state.homeOfficeCount,
                      totalVisits: totalVisits,
                    ),
                  ],
                );
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
    var percent = NumberFormat("##%");
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (user.userVisits!.length  >= 0){
              //   return
              // }
              Text('$schoolQty Tage oder',
                  style: Theme.of(context).textTheme.bodyLarge),
              Text(
                '${(percent.format(schoolQty! / totalVisits)).toString()} ',
                style: const TextStyle(
                    color: MyAppColorScheme.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),

                //
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'im Schule',
                style: Theme.of(context).textTheme.bodyLarge,
                //
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$homeQty Tage oder',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                (percent.format(homeQty! / totalVisits)).toString(),
                style: const TextStyle(
                    color: MyAppColorScheme.secondary,
                    fontSize: 32,
                    fontWeight: FontWeight.w700),
                //
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Zuhause',
                style: Theme.of(context).textTheme.bodyLarge,
                //
                overflow: TextOverflow.ellipsis,
              ),
            ],
          )
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
    final entiesQty = schoolQty! + homeQty!;
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
              value: entiesQty / totalVisits,
              color: MyAppColorScheme.primary,
              minHeight: 40,
              borderRadius: BorderRadius.circular(12),
            ),
            Text('Insgesamt $entiesQty von $totalVisits Tage',
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
