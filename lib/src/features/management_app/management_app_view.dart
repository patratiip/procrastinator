import 'package:flutter/material.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/management_app/main_screen/management_main_screen.dart';
import 'package:procrastinator/src/features/management_app/management_profile_screen/management_profile_screen.dart';
import 'package:procrastinator/src/features/management_app/users_screen/view/users_screen.dart';

class ManagementAppView extends StatefulWidget {
  const ManagementAppView({super.key});

  @override
  State<ManagementAppView> createState() => _ManagementAppViewState();
}

class _ManagementAppViewState extends State<ManagementAppView> {
  int currentPageIndex = 0;

  void onSelectedTab(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Management App')),
      body: <Widget>[
        const ManagementMainScreen(),
        const UsersScreen(),
        const ManagementProfileScreen(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
          // height: 60,
          // backgroundColor: Colors.amber,
          onDestinationSelected: onSelectedTab,
          indicatorColor: MyAppColorScheme.primary,
          selectedIndex: currentPageIndex,
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
