import 'package:group_repository/src/models/group.dart';

abstract class IGroupRepository {
  Stream<Group>? getGroupData(String? groupID);
  Future<void> addGroup(Group group);
  Future<void> addStudentToGroup(String groupID, String uid);
  Stream<List<Group>?> getAllGroups();
}
