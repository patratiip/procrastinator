// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/app_student/features/forgotten_entries/model/forgotten_request.dart';

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
      'createdAt': Timestamp.fromDate(createdAt),
      'date': Timestamp.fromDate(date),
      'userId': userId,
      'reason': reason,
      'approved': approved,
    };
  }

  static ForgottenRequestStudentModel fromFirestore(Map<String, dynamic> doc) {
    return ForgottenRequestStudentModel(
      requestId: doc['requestId'],
      createdAt: (doc['createdAt'] as Timestamp).toDate(),
      date: (doc['date'] as Timestamp).toDate(),
      userId: doc['userId'],
      reason: doc['reason'],
      approved: doc['approved'],
    );
  }
}
