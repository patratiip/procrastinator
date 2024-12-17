import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/bloc/entry_adding_bloc/entry_adding_bloc.dart';

part 'entry_adding_error_message_event.dart';
part 'entry_adding_error_message_state.dart';

class EntryAddingErrorMessageBloc
    extends Bloc<EntryAddingErrorMessageEvent, EntryAddingErrorMessageState> {
  EntryAddingErrorMessageBloc() : super(CalendarErrorMessageDisabled()) {
    on<EntryAddingErrorMessageEvent>(
      (event, emit) => switch (event) {
        final EnableCalendarErrorMessageEvent e =>
          _enableCalendarErrorMessageEvent(e, emit),
        final DisableCalendarErrorMessageEvent e =>
          _disableCalendarErrorMessageEvent(e, emit)
      },
      transformer: droppable(),
    );
  }

  Future<void> _enableCalendarErrorMessageEvent(
      EnableCalendarErrorMessageEvent event,
      Emitter<EntryAddingErrorMessageState> emit) async {
    switch (event.errorType) {
      case StateInvalidityType.futureError:
        emit(CalendarErrorMessageFutureError());
      case StateInvalidityType.schoolOnlyToday:
        emit(CalendarErrorMessageSchoolOnlyToday());
      case StateInvalidityType.enrtyWithThisDateExists:
        emit(CalendarErrorMessageEnrtyWithThisDateExists());
      case StateInvalidityType.noLessonsToday:
        emit(CalendarErrorMessageNoLessonsToday());
      case StateInvalidityType.distanceToSchool:
        emit(CalendarErrorMessageDistanceToSchool(distance: event.value!));
      case StateInvalidityType.errorOnGeopositionCheck:
        emit(CalendarErrorMessageErrorOnGeopositionCheck());
    }
  }

  Future<void> _disableCalendarErrorMessageEvent(
      DisableCalendarErrorMessageEvent event,
      Emitter<EntryAddingErrorMessageState> emit) async {
    emit(CalendarErrorMessageDisabled());
  }
}
