import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:settings_repository/src/models/color_scheme_my.dart';
import 'package:procrastinator/src/shared/resources/resources.dart';

class LessonCardComponent extends StatefulWidget {
  final Lection entryData;
  const LessonCardComponent({super.key, required this.entryData});

  @override
  State<LessonCardComponent> createState() => _LessonCardComponentState();
}

class _LessonCardComponentState extends State<LessonCardComponent> {
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd.MM.yy');
    final entryData = widget.entryData;
    return Container(
      height: 74,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      constraints: const BoxConstraints(maxWidth: 600),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 137, 232, 135),
                      border: Border.all(
                          width: 1, color: MyAppColorScheme.secondary),
                      borderRadius: BorderRadius.circular(8)),
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        entryData.theme,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
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
            Expanded(
              flex: 2,
              child: Text(
                '${entryData.trainer.length > 10 ? entryData.trainer.substring(0, 10) + '...' : entryData.trainer}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
                '${dateFormat.format(entryData.date)},${entryData.dayOfWeek.length > 2 ? entryData.dayOfWeek.substring(0, 2) : entryData.dayOfWeek}'),
            // IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded))
          ]),
    );
  }
}
