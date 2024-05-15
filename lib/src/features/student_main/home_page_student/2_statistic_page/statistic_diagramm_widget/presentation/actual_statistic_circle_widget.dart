import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/2_statistic_page/statistic_diagramm_widget/bloc/statistic_diagramm_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/2_statistic_page/statistic_diagramm_widget/domain/statistic_repository.dart';

import '../../../../../../../old_files/fake_data/user_fake_data/user_fake_data.dart';
import '../../../../../../core/styles/color_scheme_my.dart';
import '../../../../../components/elements_components/statistic_progress_diagramm_component.dart';

class StatisticCircle extends StatefulWidget {
  const StatisticCircle({super.key});

  @override
  State<StatisticCircle> createState() => _StatisticCircleState();
}

class _StatisticCircleState extends State<StatisticCircle> {
  final _blocStatistic = StatisticDiagrammBloc(GetIt.I<StatisticRepository>());
  final user = userPitty;
  var percent = NumberFormat("##%");

  var totalVisits = userPitty.userGroup.daysQty;
  var userVisits = userPitty.userVisits;
  // var homeOffice = userPitty.userVisits;

  @override
  void initState() {
    _blocStatistic.add(LoadSchoolVisitsCount());
    super.initState();
  }

  int? schoolVisitsQty() {
    int qty = 0;
    for (var element in userVisits!) {
      if (element.type.contains('Schule')) {
        qty++;
      }
    }
    return qty;
  }

  int? homeOfficeQty() {
    int qty = 0;
    for (var element in userVisits!) {
      if (element.type.contains('Heim')) {
        qty++;
      }
    }
    return qty;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500,
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
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
                        '${user.userName} Anmeldungen',
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
                bloc: _blocStatistic,
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
                              totalVisits: user.userGroup.daysQty,
                              schoolVisits: state.schoolVisitsCount,
                              homeOffice: state.homeOfficeCount,
                            ),
                          ),
                        ),
                        Padding(
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
                                  Text('${state.schoolVisitsCount} Tage oder',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  Text(
                                    '${(percent.format(state.schoolVisitsCount! / user.userGroup.daysQty)).toString()} ',
                                    style: const TextStyle(
                                        color: MyAppColorScheme.primary,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700),

                                    //
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'im Schule',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    //
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${state.homeOfficeCount} Tage oder',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  Text(
                                    (percent.format(state.homeOfficeCount! /
                                            user.userGroup.daysQty))
                                        .toString(),
                                    style: const TextStyle(
                                        color: MyAppColorScheme.secondary,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700),
                                    //
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Zuhause',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    //
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ],
                          ),
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
