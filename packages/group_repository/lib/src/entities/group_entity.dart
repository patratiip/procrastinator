// ignore_for_file: public_member_api_docs, sort_constructors_first
class GroupEntity {
  final String groupID;
  final String groupName;
  final int totalDays;
  final String? klassBook;
  final List<String>? listOfStudents;

  GroupEntity({
    required this.groupID,
    required this.groupName,
    required this.totalDays,
    this.klassBook,
    this.listOfStudents,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'groupID': groupID,
      'group_name': groupName,
      'totalDays': totalDays,
      if (klassBook != null) 'groupKlassbuch': klassBook,
      if (listOfStudents != null) 'students': listOfStudents
    };
  }

  static GroupEntity fromFirestore(Map<String, dynamic> doc) {
    return GroupEntity(
      groupID: doc['group_ID'],
      groupName: doc['group_name'],
      totalDays: doc['totalDays'],
      klassBook: doc['groupKlassbuch'],
      listOfStudents:
          (doc['students'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }
}
