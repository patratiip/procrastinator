import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../old_files/fake_data/user_fake_data/user_fake_data.dart';
import '../../../../core/styles/color_scheme_my.dart';
import '../../../components/elements_components/statistic_progress_diagramm_component.dart';

class StatisticCircleNewB extends StatefulWidget {
  const StatisticCircleNewB({super.key});

  @override
  State<StatisticCircleNewB> createState() => _StatisticCircleNewBState();
}

class _StatisticCircleNewBState extends State<StatisticCircleNewB> {
  final user = userPitty;
  var percent = NumberFormat("##%");

  var totalVisits = userPitty.userGroup.daysQty;
  var userVisits = userPitty.userVisits;
  // var homeOffice = userPitty.userVisits;

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
              Padding(
                padding: const EdgeInsets.only(top: 44, bottom: 32),
                child: SizedBox(
                    height: 220,
                    width: 220,
                    child: StatisticProgressDiagrammComponent(
                      totalVisits: user.userGroup.daysQty,
                      schoolVisits: schoolVisitsQty(),
                      homeOffice: homeOfficeQty(),
                    )),
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
                        Text('${schoolVisitsQty()!.toInt()} Tage oder',
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text(
                          '${(percent.format(schoolVisitsQty()!.toInt() / user.userGroup.daysQty)).toString()} ',
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
                          '${homeOfficeQty()!.toInt()} Tage oder',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '${(percent.format(homeOfficeQty()!.toInt() / user.userGroup.daysQty)).toString()}',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
