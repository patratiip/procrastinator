// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_repository/group_repository.dart';

class FirebaseStudentGroupRepository implements IStudentGroupRepository {
  final String groupID;
  FirebaseStudentGroupRepository({
    required this.groupID,
  });

  final _groupCollection =
      FirebaseFirestore.instance.collection('group_flutter');

  @override
  Stream<Group> myGroupStream() {
    log(groupID);
    try {
      return _groupCollection
          .doc(groupID)
          .snapshots()
          .map((group) =>
              Group.fromEntity(GroupEntity.fromFirestore(group.data()!)))
          .asBroadcastStream();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<Group> getGroupData(String groupID) {
    try {
      return _groupCollection
          .doc(groupID)
          .snapshots()
          .map((group) =>
              Group.fromEntity(GroupEntity.fromFirestore(group.data()!)))
          .asBroadcastStream();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


}
