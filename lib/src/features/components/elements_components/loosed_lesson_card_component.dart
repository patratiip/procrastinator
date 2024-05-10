import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../../auth/domain/auth_firebase_service.dart';
import '../../../shared/resources/resources.dart';
import '../../../../old_files/fake_data/kursplan_fake_data/kursplan_fake.dart';
import '../../../core/styles/color_scheme_my.dart';

class LoosedLessonCardComponent extends StatefulWidget {
  final KursplanEntry lessonData;
  const LoosedLessonCardComponent({super.key, required this.lessonData});

  @override
  State<LoosedLessonCardComponent> createState() =>
      _LoosedLessonCardComponentState();
}

class _LoosedLessonCardComponentState extends State<LoosedLessonCardComponent> {
  var dateFormat = DateFormat('dd.MM.yy');

  get lessonData {
    return widget.lessonData;
  }

  void addEntry() {
    print('${lessonData.theme} Entry Added');
  }

  @override
  Widget build(BuildContext context) {
    var lessonData = widget.lessonData;
    return Container(
      ///////ON TAP???///////
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
                      lessonData.theme,
                      style: const TextStyle(color: Colors.white),
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
            Text(dateFormat.format(lessonData.date)),
            IconButton(
                onPressed: addEntry,
                icon: const Icon(
                  Icons.add_rounded,
                  size: 32,
                  color: MyAppColorScheme.primary,
                ))
          ]),
    );
  }
}
