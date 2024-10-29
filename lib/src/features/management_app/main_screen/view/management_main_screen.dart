import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:group_repository/group_repository.dart';
import 'package:procrastinator/src/features/management_app/main_screen/group_list/group_list.dart';
import 'package:user_repository/user_repository.dart';

class ManagementMainScreen extends StatelessWidget {
  const ManagementMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GroupAddingWidget();
  }
}

class GroupAddingWidget extends StatefulWidget {
  const GroupAddingWidget({super.key});

  @override
  State<GroupAddingWidget> createState() => _GroupAddingWidgetState();
}

class _GroupAddingWidgetState extends State<GroupAddingWidget> {
  final FirebaseManagementGroupRepository repo =
      FirebaseManagementGroupRepository();
  final FirebaseUserRepository userRepository = FirebaseUserRepository();

  final String uid = '4S8aSHqLrbWZn6Gu2FWkbpCX1UK2';
  final String uid2 = 'zDJhLt8ZQXNN2HjZVR9F3kOxfbG2';

  final Group group = const Group(
      groupID: 'imKMe382090j2323n23eu',
      groupName: 'TEST GrouP',
      totalDays: 256);

  final Group group2 = const Group(
      groupID: '345341imKMe382090j2323n23eu',
      groupName: 'TEST GrouP2',
      totalDays: 266);

  void addNewGroup() {
    repo.addGroup(group2);
  }

  void addUserToGroup() {
    repo.addStudentToGroup(group2.groupID, uid2);
    log('Student was added');
  }

  void addGroupToUser() {
    userRepository.addGroupToUserCollection(group.groupID);
    // final MyUser? user = userRepository.currentUser;
    log('');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: addNewGroup,
            child: const Text('Add Group to Firebase'),
          ),
          ElevatedButton(
            onPressed: addUserToGroup,
            child: const Text('Add User to Group'),
          ),
          ElevatedButton(
            onPressed: addGroupToUser,
            child: const Text('Add Group to User'),
          ),
          const GroupList(),
        ],
      ),
    );
  }
}
