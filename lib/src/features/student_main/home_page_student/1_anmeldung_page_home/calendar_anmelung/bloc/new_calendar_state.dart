part of 'new_calendar_bloc.dart';

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
  NewCalendarState({
    this.date,
    this.type,
    this.isValid = true,
    this.errorMessage,
    this.status = NewCalendarStateStatus.disabled,
  });

  final DateTime? date;
  final String? type;
  final bool isValid;
  final String? errorMessage;
  //TODO Change that with factories or Enum
  final NewCalendarStateStatus status;

  NewCalendarState copyWith({
    DateTime? date,
    String? type,
    bool? isValid,
    String? errorMessage,
    NewCalendarStateStatus? status,
  }) {
    return NewCalendarState(
      date: date ?? this.date,
      type: type ?? this.type,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [date, type, isValid, status];
}
