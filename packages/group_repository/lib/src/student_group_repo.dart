import 'package:group_repository/src/models/group.dart';

abstract interface class IStudentGroupRepository {
  Stream<Group> getGroupData(String groupID);
  Stream<Group> myGroupStream();

}
