import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';

part 'calendar_error_message_event.dart';
part 'calendar_error_message_state.dart';

class CalendarErrorMessageBloc
    extends Bloc<CalendarErrorMessageEvent, CalendarErrorMessageState> {
  CalendarErrorMessageBloc() : super(CalendarErrorMessageDisabled()) {
    on<CalendarErrorMessageEvent>(
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
      Emitter<CalendarErrorMessageState> emit) async {
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
      Emitter<CalendarErrorMessageState> emit) async {
    emit(CalendarErrorMessageDisabled());
  }
}
