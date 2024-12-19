// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:procrastinator/src/features/student_app/features/entry_adding/model/forgotten_request.dart';

class ForgottenRequestStudentModel {
  final String requestId;
  final DateTime createdAt;
  final DateTime date;
  final String userId;
  final String reason;
  final bool approved;
  ForgottenRequestStudentModel({
    required this.requestId,
    required this.createdAt,
    required this.date,
    required this.userId,
    required this.reason,
    required this.approved,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'requestId': requestId,
      'createdAt': createdAt,
      'date': date,
      'userId': userId,
      'reason': reason,
      'approved': approved,
    };
  }

  static ForgottenRequestStudent fromFirestore(Map<String, dynamic> doc) {
    return ForgottenRequestStudent(
      requestId: doc['requestId'],
      createdAt: doc['createdAt'],
      date: doc['date'],
      userId: doc['userId'],
      reason: doc['reason'],
      approved: doc['approved'] ,
    );
  }
}
