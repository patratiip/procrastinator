part of 'new_calendar_bloc.dart';

final class NewCalendarState extends Equatable {
  NewCalendarState({
    this.date,
    this.type,
    this.isValid = false,
    this.status,
  });

  final DateTime? date;
  final String? type;
  final bool isValid;
  final String? status;

  NewCalendarState copyWith({
    DateTime? date,
    String? type,
    bool? isValid,
    String? status,
  }) {
    return NewCalendarState(
      date: date ?? this.date,
      type: type ?? this.type,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [date, type, isValid, status];
}
