import 'package:bloc/bloc.dart';
import 'package:entry_repository/entry_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'new_calendar_event.dart';
part 'new_calendar_state.dart';

class NewCalendarBloc extends Bloc<NewCalendarEvent, NewCalendarState> {
  final EntryRepositoty _entriesRepository;
  NewCalendarBloc({required entrysRepository})
      : _entriesRepository = entrysRepository,
        super(NewCalendarState(date: DateTime.now())) {
    on<CalendarDateChanged>((event, emit) {
      print('$state');
      final newDate = event.date;
      emit(state.copyWith(
          date: newDate,
          status: state.type != null ? 'readyToAdding' : 'hasDate'));
      print('$state');
    });
    on<CalendarTypeChanged>((event, emit) {
      print('$state');
      final newType = event.type;
      emit(state.copyWith(
          type: newType,
          status: state.date != null ? 'readyToAdding' : 'hasType'));
      print('$state');
    });

    on<CalendarAddEntry>((event, emit) async {
      if (state.status == 'readyToAdding') {
        emit(state.copyWith(status: 'Adding'));

        final entry = Entry(visitID: const Uuid().v4(), date: state.date);

        if (state.type == 'Schule') {
          entry.schoolVisit = true;
        } else if (state.type == 'Heim') {
          entry.homeOffice = true;
        } else if (state.type == 'Krank') {
          entry.krank = true;
        } else if (state.type == 'Fehl') {
          entry.fehl = true;
        }
        _entriesRepository.addEntry(entry);
        print('NEW BLOC $entry');
        await Future<void>.delayed(const Duration(seconds: 5));
        emit(state.copyWith(status: 'Added'));
      } else {}
    });
  }
}
