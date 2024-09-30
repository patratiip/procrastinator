// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:group_repository/src/entities/group_entity.dart';

class Group extends Equatable {
  final String groupID;
  final String groupName;
  final int totalDays;
  final String? klassBook;
  final List<String>? listOfStudents;

  const Group({
    required this.groupID,
    required this.groupName,
    required this.totalDays,
    this.klassBook,
    this.listOfStudents,
  });

  GroupEntity toEntity() {
    return GroupEntity(
      groupID: groupID,
      groupName: groupName,
      totalDays: totalDays,
      klassBook: klassBook,
      listOfStudents: listOfStudents,
    );
  }

  static Group fromEntity(GroupEntity entity) {
    return Group(
      groupID: entity.groupID,
      groupName: entity.groupName,
      totalDays: entity.totalDays,
      klassBook: entity.klassBook,
      listOfStudents: entity.listOfStudents,
    );
  }

  @override
  List<Object?> get props =>
      [groupID, groupName, totalDays, klassBook, listOfStudents];
}
