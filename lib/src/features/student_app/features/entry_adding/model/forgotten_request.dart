// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:procrastinator/src/features/student_app/features/entry_adding/model/forgotten_request_model.dart';

class ForgottenRequestStudent {
  final String requestId;
  final DateTime createdAt;
  final DateTime date;
  final String userId;
  final String reason;
  final bool approved;
  ForgottenRequestStudent({
    required this.requestId,
    required this.createdAt,
    required this.date,
    required this.userId,
    required this.reason,
    required this.approved,
  });
  ForgottenRequestStudentModel toModel() {
    return ForgottenRequestStudentModel(
      requestId: requestId,
      createdAt: createdAt,
      date: date,
      userId: userId,
      reason: reason,
      approved: approved,
    );
  }

  static ForgottenRequestStudent fromModel(ForgottenRequestStudentModel model) {
    return ForgottenRequestStudent(
      requestId: model.requestId,
      createdAt: model.createdAt,
      date: model.date,
      userId: model.userId,
      reason: model.reason,
      approved: model.approved,
    );
  }

  ForgottenRequestStudent copyWith({
    String? requestId,
    DateTime? createdAt,
    DateTime? date,
    String? userId,
    String? reason,
    bool? approved,
  }) {
    return ForgottenRequestStudent(
      requestId: requestId ?? this.requestId,
      createdAt: createdAt ?? this.createdAt,
      date: date ?? this.date,
      userId: userId ?? this.userId,
      reason: reason ?? this.reason,
      approved: approved ?? this.approved,
    );
  }

  @override
  bool operator ==(covariant ForgottenRequestStudent other) {
    if (identical(this, other)) return true;
  
    return 
      other.requestId == requestId &&
      other.createdAt == createdAt &&
      other.date == date &&
      other.userId == userId &&
      other.reason == reason &&
      other.approved == approved;
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
      createdAt.hashCode ^
      date.hashCode ^
      userId.hashCode ^
      reason.hashCode ^
      approved.hashCode;
  }

  @override
  String toString() {
    return 'ForgottenRequestStudent(requestId: $requestId, createdAt: $createdAt, date: $date, userId: $userId, reason: $reason, approved: $approved)';
  }
}
