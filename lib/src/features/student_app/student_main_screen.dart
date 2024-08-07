import 'package:flutter/material.dart';
import 'home_page_student/1_anmeldung_page_home/anmeldung_page_widget.dart';
import 'home_page_student/2_statistic_page/statistic_diagramm_widget/view/statistic_sreen.dart';
import 'home_page_student/3_kursplan_page/view/kursplan_page_widget.dart';
import 'home_page_student/4_student_profile_page/student_profile_page_widget.dart';

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
  String _appBarText = 'Anmeldung';

  // static List<Widget> _widgetOptions = <Widget>[
  //   AnmeldungPageWidget(),
  //   StatisticPageWidget(),
  //   KursplanPageWidget(),
  //   StudentProfilePageWidget(),
  // ];

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
      if (_selectedTab == 0) {
        _appBarText = 'Anmeldung';
      } else if (_selectedTab == 1) {
        _appBarText = 'Statistik';
      } else if (_selectedTab == 2) {
        _appBarText = 'Kursplan';
      } else if (_selectedTab == 3) {
        _appBarText = 'Profile';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarText),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: const [
          AnmeldungPageWidget(),
          StatisticPageWidget(),
          KursplanPageWidget(),
          StudentProfilePageWidget(),
        ],
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
