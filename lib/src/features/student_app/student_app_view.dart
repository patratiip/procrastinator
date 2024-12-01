import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/di/scopes/settings_scope.dart';
import 'package:settings_repository/src/models/color_scheme_my.dart';
import 'package:procrastinator/src/features/settings/bloc/app_settings_bloc.dart';
import '1_student_main_screen/view/student_main_screen.dart';
import '2_statistic_screen/view/statistic_page.dart';
import '3_lection_plan_screen/view/lection_plan_page_widget.dart';
import '4_student_profile_screen/view/student_profile_screen.dart';

class StudentAppView extends StatefulWidget {
  const StudentAppView({
    super.key,
  });

  static Page<void> page() => const MaterialPage<void>(child: StudentAppView());

  @override
  State<StudentAppView> createState() => _StudentAppViewState();
}

class _StudentAppViewState extends State<StudentAppView> {
  int _currentIndex = 0;
  String _appBarText = '';

  void _onSelectedTab(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        _appBarText = Localization.of(context).anmeldungAppBarText;
      } else if (_currentIndex == 1) {
        _appBarText = Localization.of(context).statistikAppBarText;
      } else if (_currentIndex == 2) {
        _appBarText = Localization.of(context).lectionsPlanAppBarText;
      } else if (_currentIndex == 3) {
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
      body: <Widget>[
        const StudentMainScreen(),
        const StatisticPageWidget(),
        const KursplanPageWidget(),
        const StudentProfileScreen(),
      ][_currentIndex],
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: _onSelectedTab,
          indicatorColor: Colors.transparent,
          selectedIndex: _currentIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home_rounded,
                color: MyAppColorScheme.primary,
              ),
              icon: Icon(Icons.home_rounded),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.bar_chart_outlined,
                color: MyAppColorScheme.primary,
              ),
              icon: Icon(Icons.bar_chart_outlined),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.view_list_rounded,
                color: MyAppColorScheme.primary,
              ),
              icon: Icon(Icons.view_list_rounded),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person_rounded,
                color: MyAppColorScheme.primary,
              ),
              icon: Icon(Icons.person_rounded),
              label: '',
            ),
          ]),
    );
  }
}
