import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_repository/group_repository.dart';

class FirebaseTrainerGroupRepository implements ITrainerGroupRepository {
  final _groupCollection =
      FirebaseFirestore.instance.collection('group_flutter');

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

  @override
  Stream<List<Group>?> getAllGroups() {
    try {
      return _groupCollection
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((group) =>
                  Group.fromEntity(GroupEntity.fromFirestore(group.data())))
              .toList())
          .asBroadcastStream();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}
