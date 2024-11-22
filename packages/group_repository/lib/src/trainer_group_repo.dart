import 'package:group_repository/src/models/group.dart';

abstract interface class ITrainerGroupRepository {
  Stream<Group> getGroupData(String groupID);
  Stream<List<Group>?> getAllGroups();
}
