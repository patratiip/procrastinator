import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/calendar_anmelung/data/add_entry_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/calendar_anmelung/domain/add_entry_repository.dart';

part 'calendar_anmeldung_event.dart';
part 'calendar_anmeldung_state.dart';

class CalendarAnmeldungBloc
    extends Bloc<CalendarAnmeldungEvent, CalendarAnmeldungState> {
  final CalenarEntryFirestoreRepository _firestoreService;
  CalendarAnmeldungBloc(this._firestoreService)
      : super(CalendarAnmeldungInitial()) {
    on<AddEntry>((event, emit) async {
      emit(AddingCalendarEntry());
      await _firestoreService.addVisit(event.newEntry);

      emit(AddedCalendarEntry());
    });
  }
}
