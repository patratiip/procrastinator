import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

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
      case ErrorType.futureError:
        emit(CalendarErrorMessageFutureError());
      case ErrorType.schoolOnlyToday:
        emit(CalendarErrorMessageSchoolOnlyToday());
      case ErrorType.enrtyWithThisDateExists:
        emit(CalendarErrorMessageEnrtyWithThisDateExists());
      case ErrorType.noLessonsToday:
        emit(CalendarErrorMessageNoLessonsToday());
      case ErrorType.distanceToSchool:
        emit(CalendarErrorMessageDistanceToSchool(distance: event.value!));
      case ErrorType.errorOnGeopositionCheck:
        emit(CalendarErrorMessageErrorOnGeopositionCheck());
    }
  }

  Future<void> _disableCalendarErrorMessageEvent(
      DisableCalendarErrorMessageEvent event,
      Emitter<EntryAddingErrorMessageState> emit) async {
    emit(CalendarErrorMessageDisabled());
  }
}
