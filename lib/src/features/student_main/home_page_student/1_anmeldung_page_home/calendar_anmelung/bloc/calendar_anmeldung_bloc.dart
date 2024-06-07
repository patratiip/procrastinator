import 'package:bloc/bloc.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';

part 'calendar_anmeldung_event.dart';
part 'calendar_anmeldung_state.dart';

class CalendarAnmeldungBloc
    extends Bloc<CalendarAnmeldungEvent, CalendarAnmeldungState> {
  final EntryRepositoty _firestoreEntryRepo;
  CalendarAnmeldungBloc(this._firestoreEntryRepo)
      : super(CalendarAnmeldungInitial()) {
    on<AddEntry>((event, emit) async {
      emit(AddingCalendarEntry());
      await _firestoreEntryRepo.addEntry(event.newEntry);
      emit(AddedCalendarEntry());
    });
  }
}
