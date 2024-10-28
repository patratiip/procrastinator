import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/1_main_screen/calendar_entry_adding/entry_adding_calendar.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';

class LoosedLessonCardComponent extends StatelessWidget {
  final Lection lessonData;
  const LoosedLessonCardComponent({super.key, required this.lessonData});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yy');

    return Container(
      ///////ON TAP???///////
      height: 74,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      //height: 300,

      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12)),
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
                      color: Color.fromARGB(255, 255, 189, 124),
                      border: Border.all(
                          width: 1, color: MyAppColorScheme.warningColor),
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Text(
                      lessonData.theme!,
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
            Text(dateFormat.format(lessonData.date!)),
            IconButton(
              onPressed: () {
                final bloc = BlocProvider.of<CalendarBloc>(context);

                bloc.add(CalendarDateChanged(date: lessonData.date!));
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
