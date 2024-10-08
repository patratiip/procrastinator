import 'package:group_repository/src/models/group.dart';

abstract class IGroupRepository {
  Stream<Group> getGroupData(String groupID);
  Stream<Group> myGroupStream();
  Future<void> addGroup(Group group);
  Future<void> addStudentToGroup(String groupID, String uid);
  Stream<List<Group>?> getAllGroups();
}
