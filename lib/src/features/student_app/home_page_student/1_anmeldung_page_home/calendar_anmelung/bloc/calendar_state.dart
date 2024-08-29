part of 'calendar_bloc.dart';

enum NewCalendarStateStatus {
  disabled,
  hasDate,
  hasType,
  inProgress,
  readyToAdding,
  succes,
  error,
  allDone,
}

final class NewCalendarState extends Equatable {
  const NewCalendarState({
    this.date,
    this.type,
    this.isValid = true,
    this.message,
    this.status = NewCalendarStateStatus.disabled,
  });

  final DateTime? date;
  final String? type;
  final bool isValid;
  final String? message;
  final NewCalendarStateStatus status;

  NewCalendarState copyWith({
    DateTime? date,
    String? type,
    bool? isValid,
    String? message,
    NewCalendarStateStatus? status,
  }) {
    return NewCalendarState(
      date: date ?? this.date,
      type: type ?? this.type,
      isValid: isValid ?? this.isValid,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [date, type, isValid, message, status];
}
