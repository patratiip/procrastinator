part of 'calendar_anmeldung_bloc.dart';

sealed class CalendarAnmeldungState extends Equatable {
  const CalendarAnmeldungState();

  @override
  List<Object> get props => [];
}

final class CalendarAnmeldungInitial extends CalendarAnmeldungState {}

final class AddingCalendarEntry extends CalendarAnmeldungState {}

final class AddedCalendarEntry extends CalendarAnmeldungState {}
