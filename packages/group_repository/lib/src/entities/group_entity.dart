// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

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
      'groupName': groupName,
      'totalDays': totalDays,
      // if (klassBook != null)
      //   'klassBook': FirebaseFirestore.instance.doc('klassbook_flutter/$klassBook'),
      // if (listOfStudents != null)
      //   'students': listOfStudents!
      //       .map((uid) => FirebaseFirestore.instance.doc('users_flutter/$uid'))
      //       .toList(),
    };
  }

  static GroupEntity fromFirestore(Map<String, dynamic> doc) {
    return GroupEntity(
        groupID: doc['groupID'],
        groupName: doc['groupName'],
        totalDays: doc['totalDays'],
        klassBook: doc['klassBook'] != null
            ? (doc['klassBook'] as DocumentReference).id
            : null,
        listOfStudents:
            // (doc['students'] as List<dynamic>?)
            //     ?.map((e) => e.toString() as String)
            //     .toList());
            (doc['students'] as List<dynamic>?)
                ?.map((ref) => (ref as DocumentReference).id)
                .toList());
  }
}
