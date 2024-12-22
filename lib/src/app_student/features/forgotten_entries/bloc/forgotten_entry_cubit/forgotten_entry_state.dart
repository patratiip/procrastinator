// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'forgotten_entry_cubit.dart';

enum ForgottenEntryStateStatus {
  idle,
  inProgress,
  success,
  error,
}

final class ForgottenEntryState {
  final DateTime date;
  final String userId;
  final String reason;
  final ForgottenEntryStateStatus status;
  final bool? reasonIsValid;
  final String? errorMessage;

  const ForgottenEntryState({
    required this.date,
    required this.userId,
    this.reason = '',
    this.status = ForgottenEntryStateStatus.idle,
    this.reasonIsValid,
    this.errorMessage,
  });

  ForgottenEntryState copyWith({
    DateTime? date,
    String? userId,
    String? reason,
    ForgottenEntryStateStatus? status,
    bool? reasonIsValid,
    String? errorMessage,
  }) {
    return ForgottenEntryState(
      date: date ?? this.date,
      userId: userId ?? this.userId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      reasonIsValid: reasonIsValid ?? this.reasonIsValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(covariant ForgottenEntryState other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.userId == userId &&
        other.reason == reason &&
        other.status == status &&
        other.reasonIsValid == reasonIsValid &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        userId.hashCode ^
        reason.hashCode ^
        status.hashCode ^
        reasonIsValid.hashCode ^
        errorMessage.hashCode;
  }

  @override
  String toString() {
    return 'ForgottenEntryState(date: $date, userId: $userId, reason: $reason, status: $status, reasonIsValid: $reasonIsValid, errorMessage: $errorMessage)';
  }
}
