part of 'calendar_anmeldung_bloc.dart';

sealed class CalendarAnmeldungEvent extends Equatable {
  const CalendarAnmeldungEvent();

  @override
  List<Object> get props => [];
}

final class AddEntry extends CalendarAnmeldungEvent{
  final Entry newEntry;

  const AddEntry({required this.newEntry});
}
