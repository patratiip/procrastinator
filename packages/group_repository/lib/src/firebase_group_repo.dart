import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_repository/group_repository.dart';

class FirebaseGroupRepository implements IGroupRepository {
  final _groupCollection =
      FirebaseFirestore.instance.collection('group_flutter');

  @override
  Future<void> addGroup(Group group) async {
    try {
      await _groupCollection
          .doc(group.groupID)
          .set(group.toEntity().toFirestore());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addStudentToGroup(String groupID, String uid) async {
    try {
      await _groupCollection.doc(groupID).update({
        'students': FieldValue.arrayUnion(
            [FirebaseFirestore.instance.doc('users_flutter/$uid')]),
      });
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
