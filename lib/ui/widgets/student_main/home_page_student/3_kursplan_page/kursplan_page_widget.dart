import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../../theme/color_scheme_my.dart';
import '../../../components/elements_components/lesson_card_component.dart';
import '../../../../../fake_data/kursplan_fake_data/kursplan_fake.dart';

class KursplanPageWidget extends StatefulWidget {
  KursplanPageWidget({super.key});

  @override
  State<KursplanPageWidget> createState() => _KursplanPageWidgetState();
}

class _KursplanPageWidgetState extends State<KursplanPageWidget> {
  var dateFormat = DateFormat('dd.MM.yy');

  final _lessons = fakeDataLessons;

  var _filteredLessons = <KursplanEntry>[];

  final _searchController = TextEditingController();

  void _searchLessons() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredLessons = _lessons.where((KursplanEntry lesson) {
        return lesson.theme.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredLessons = _lessons;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _filteredLessons = _lessons;
    _searchController.addListener((_searchLessons));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            padding: EdgeInsets.only(top: 70, left: 16, right: 16, bottom: 40),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: _filteredLessons.length,
            //itemExtent: 68,
            itemBuilder: (BuildContext context, int index) {
              final lesson = _filteredLessons[index];
              return LessonCardComponent(entryData: lesson);
            }),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                labelText: 'Search',
                filled: true,
                fillColor: Theme.of(context).cardColor.withAlpha(230),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      width: 1, color: MyAppColorScheme.primary),
                )),
          ),
        ),
      ],
    );
  }
}
