import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_repository/group_repository.dart';

class FirebaseStudentGroupRepository implements IGroupRepository {
  final _groupCollection =
      FirebaseFirestore.instance.collection('group_flutter');

  @override
  Stream<Group>? getGroupData(String? groupID) {
    if (groupID != null) {
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
    } else {
      return null;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
