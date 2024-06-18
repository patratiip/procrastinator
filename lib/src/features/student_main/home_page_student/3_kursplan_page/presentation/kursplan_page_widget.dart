import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/components/elements_components/lesson_card_component.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/today_lesson_widget/presentation/today_lesson_widget.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';

class KursplanPageWidget extends StatefulWidget {
  const KursplanPageWidget({super.key});

  @override
  State<KursplanPageWidget> createState() => _KursplanPageWidgetState();
}

class _KursplanPageWidgetState extends State<KursplanPageWidget> {
  var dateFormat = DateFormat('dd.MM.yy');
  final _lectionsListBloc =
      KursplanBloc(lectionsRepository: GetIt.I<FirebaseLectionRepository>());

  // final _lessons = fakeDataLessons;

  // var _filteredLessons = <KursplanEntry>[];

  // final _searchController = TextEditingController();

  // void _searchLessons() {
  //   final query = _searchController.text;
  //   if (query.isNotEmpty) {
  //     _filteredLessons = _lessons.where((KursplanEntry lesson) {
  //       return lesson.theme.toLowerCase().contains(query.toLowerCase());
  //     }).toList();
  //   } else {
  //     _filteredLessons = _lessons;
  //   }
  //   setState(() {});
  // }

  @override
  void initState() {
    // _lectionsListBloc.add(LoadLections());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 44),
                primary: true,
                child: Column(
                  children: [
                    //
                    const HeutigeUnterrichtWidget(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nächste',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        BlocBuilder<KursplanBloc, KursplanState>(
                            bloc: _lectionsListBloc,
                            builder: (context, state) {
                              if (state is LectionsListLoadedState) {
                                final filteredLections = state.lectionsList
                                    .where((lection) =>
                                        lection.date!.isAfter(DateTime.now()))
                                    .toList();
                                return ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    itemCount: filteredLections.length,
                                    //itemExtent: 68,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      // final lesson = _filteredLessons[index];
                                      return LessonCardComponent(
                                          entryData: filteredLections[index]);
                                    });
                              } else if (state is LectionsListLoadingState) {
                                return const Center(
                                    child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    color: MyAppColorScheme.primary,
                                  ),
                                ));
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: TextField(
            //     controller: _searchController,
            //     decoration: InputDecoration(
            //         labelText: 'Search',
            //         filled: true,
            //         fillColor: Theme.of(context).cardColor.withAlpha(230),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(12),
            //             borderSide:
            //                 const BorderSide(width: 1, color: Colors.white)),
            //         focusedBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(12),
            //           borderSide: const BorderSide(
            //               width: 1, color: MyAppColorScheme.primary),
            //         )),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
