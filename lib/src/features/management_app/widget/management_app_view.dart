import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/features/management_app/feature/main_screen/management_main_screen.dart';
import 'package:procrastinator/src/features/management_app/feature/management_profile_screen/management_profile_screen.dart';
import 'package:procrastinator/src/features/management_app/feature/users_screen/widget/users_screen.dart';

class ManagementAppView extends StatefulWidget {
  const ManagementAppView({super.key});

  @override
  State<ManagementAppView> createState() => _ManagementAppViewState();
}

class _ManagementAppViewState extends State<ManagementAppView> {
  int _currentIndex = 0;
  String _appBarText = '';

  void _onSelectedTab(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        _appBarText = Localization.of(context).dashboardAppBarText;
      } else if (_currentIndex == 1) {
        _appBarText = Localization.of(context).usersAppBarText;
      } else if (_currentIndex == 2) {
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
              : _appBarText)),
      body: <Widget>[
        const ManagementMainScreen(),
        const UsersScreen(),
        const ManagementProfileScreen(),
      ][_currentIndex],
      bottomNavigationBar: NavigationBar(
          // height: 60,
          // backgroundColor: Colors.amber,
          onDestinationSelected: _onSelectedTab,
          indicatorColor: MyAppColorScheme.primary,
          selectedIndex: _currentIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person_add,
                color: Colors.white,
              ),
              icon: Icon(Icons.person_add),
              label: 'Users',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ]),
    );
  }
}
