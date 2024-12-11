import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:procrastinator/src/features/student_app/features/calendar_entry_adding/entry_adding_calendar.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/features/student_app/features/student_main_screen/widget/scroll_controller_provider.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/ui_kit/widget/card_widget.dart';

/// {@template loosed_lection_widget}
///  [LoosedLectionWidget] shows [Lection] without an [Entry] .
/// {@endtemplate}
/// {@macro loosed_lection_widget}
class LoosedLectionWidget extends StatelessWidget {
  final Lection lection;
  const LoosedLectionWidget({super.key, required this.lection});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yy');

    return CardWidget(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 189, 124),
                      border: Border.all(
                          width: 1, color: MyAppColorScheme.warningColor),
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Text(
                      lection.theme,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    )
                  ])),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: 44,
                  height: 44,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                    image: DecorationImage(
                      image: AssetImage(Images.lutzLogotypePng),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Text(dateFormat.format(lection.date)),
            IconButton(
              onPressed: () {
                final bloc = BlocProvider.of<CalendarBloc>(context);
                bloc.add(CalendarDateChanged(date: lection.date));
                ScrollControllerProvider.of(context).animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: const Icon(
                Icons.add_rounded,
                size: 32,
                color: MyAppColorScheme.primary,
              ),
            )
            // IconButton(
            //   onPressed: () {
            //     print('${lessonData.theme} Entry Added');

            //     showCupertinoModalBottomSheet(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return Container(
            //             decoration:
            //                 BoxDecoration(color: Theme.of(context).cardColor),
            //             height: 300,
            //             child: Center(
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     dateFormat.format(lessonData.date!),
            //                     style: Theme.of(context).textTheme.displayLarge,
            //                   ),
            //                   ElevatedButton(
            //                       onPressed: () {
            //                         Navigator.pop(context);
            //                       },
            //                       child: const Text('Close!'))
            //                 ],
            //               ),
            //             ),
            //           );
            //         });
            //   },
            //   icon: const Icon(
            //     Icons.add_rounded,
            //     size: 32,
            //     color: MyAppColorScheme.primary,
            //   ),
            // ),
          ]),
    );
  }
}
