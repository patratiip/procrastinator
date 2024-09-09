import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'home_page_student/1_anmeldung_page/view/anmeldung_page.dart';
import 'home_page_student/2_statistic_page/view/statistic_page.dart';
import 'home_page_student/3_kursplan_page/view/kursplan_page_widget.dart';
import 'home_page_student/4_student_profile_page/view/student_profile_page_widget.dart';

class StudentMainScreen extends StatefulWidget {
  const StudentMainScreen({
    super.key,
  });

  static Page<void> page() =>
      const MaterialPage<void>(child: StudentMainScreen());

  @override
  State<StudentMainScreen> createState() => _StudentMainScreenState();
}

class _StudentMainScreenState extends State<StudentMainScreen> {
  int _selectedTab = 0;
  //TODO Initial value
  String _appBarText = '';

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
      if (_selectedTab == 0) {
        _appBarText = Localization.of(context).anmeldungAppBarText;
      } else if (_selectedTab == 1) {
        _appBarText = Localization.of(context).statistikAppBarText;
      } else if (_selectedTab == 2) {
        _appBarText = Localization.of(context).lectionsPlanAppBarText;
      } else if (_selectedTab == 3) {
        _appBarText = Localization.of(context).profileAppBarText;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarText.isEmpty
            ? Localization.of(context).anmeldungAppBarText
            : _appBarText),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: IndexedStack(
            index: _selectedTab,
            children: const [
              AnmeldungPageWidget(),
              StatisticPageWidget(),
              KursplanPageWidget(),
              StudentProfilePageWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // useLegacyColorScheme: true,
        // backgroundColor: Theme.of(context).colorScheme.background,
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_list_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: '')
        ],
        onTap: onSelectedTab,

        //styling
        selectedIconTheme: const IconThemeData(size: 32),
      ),
    );
  }
}
