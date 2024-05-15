import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/heutige_unterricht_widget/presentation/heutige_unterricht_widget.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/bloc/kursplan_bloc.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

import '../../../../../core/styles/color_scheme_my.dart';
import '../../../../components/elements_components/lesson_card_component.dart';

class KursplanPageWidget extends StatefulWidget {
  KursplanPageWidget({super.key});

  @override
  State<KursplanPageWidget> createState() => _KursplanPageWidgetState();
}

class _KursplanPageWidgetState extends State<KursplanPageWidget> {
  var dateFormat = DateFormat('dd.MM.yy');
  final _lectionsListBloc = KursplanBloc(GetIt.I<LectionFirestoreRepository>());

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
    // TODO: implement initState
    _lectionsListBloc.add(LoadLections());
    super.initState();
    // _filteredLessons = _lessons;
    // _searchController.addListener((_searchLessons));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Stack(
          children: [
            Center(
              child: ListView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.only(right: 16, left: 16, bottom: 44),
                primary: true,
                children: [
                  HeutigeUnterrichtWidget(),
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
                            if (state is LectionsListLoaded) {
                              return ListView.builder(
                                  primary: false,
                                  shrinkWrap: true,
                                  itemCount: state.lectionsList.length,
                                  //itemExtent: 68,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // final lesson = _filteredLessons[index];
                                    return LessonCardComponent(
                                        entryData: state.lectionsList[index]);
                                  });
                            } else if (state is LectionsListLoading) {
                              return const Center(
                                  child: SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                  color: MyAppColorScheme.primary,
                                ),
                              ));
                            } else {
                              // return const Center(
                              //     child: SizedBox(
                              //   height: 100,
                              //   width: 100,
                              //   child: CircularProgressIndicator(),
                              return Center(
                                  child: Container(
                                height: 1000,
                                width: 100,
                                color: Colors.red,
                              ));
                            }
                          }),
                    ],
                  ),
                ],
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
