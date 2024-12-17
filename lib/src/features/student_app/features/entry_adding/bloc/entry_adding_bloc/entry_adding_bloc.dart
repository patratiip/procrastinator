import 'dart:async';
import 'dart:developer';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection.dart';

part 'entry_adding_event.dart';
part 'entry_adding_state.dart';
part 'validators_calendar_bloc.dart';

class EntryAddingBloc extends Bloc<EntryAddingEvent, EntryAddingState> {
  final IEntryAddingRepository _entryAddingRepository;

  late final StreamSubscription<List<Entry>?> _entrysListListener;
  late final StreamSubscription<List<Lection>?> _lectionListListener;

  EntryAddingBloc({
    required IEntryAddingRepository entryAddingRepository,
  })  : _entryAddingRepository = entryAddingRepository,
        super(_InitialEntryAddingState(
          date: _normalizeDate(DateTime.now()),
          calendarFormat: CalendarFormat.week,
          entriesList: [],
          lectionsList: [],
        )) {
    _initializeListeners();

    on<EntryAddingEvent>(
      (event, emit) => switch (event) {
        // TODO: Add logic to push a AllComplete state. Maybe with LoosedEntries feature
        //TODO add a timing in that user can change calendar formats

        final _StateDataChangedEntryAddingEvent e =>
          _stateDataChangedEntryAddingEvent(e, emit),
      },
      transformer: sequential(),
    );
  }

  /// Subscriptons initialization
  void _initializeListeners() {
    _entrysListListener = _entryAddingRepository.entriesStream().listen(
      (entriesList) {
        add(_StateDataChangedEntryAddingEvent(entriesList: entriesList));

        //TODO: Work on that feature
        // if (state.status != CalendarStateStatus.initial) {
        //   add(CalendarDateChanged(date: state.date!));
        // }
      },
      cancelOnError: false,
    );

    _lectionListListener = _entryAddingRepository.lectionsStream().listen(
      (lectionsList) {
        add(_StateDataChangedEntryAddingEvent(lectionsList: lectionsList));
      },
      cancelOnError: false,
    );
  }

  /// State data was changed
  ///
  Future<void> _stateDataChangedEntryAddingEvent(
      _StateDataChangedEntryAddingEvent event,
      Emitter<EntryAddingState> emit) async {
    try {
      emit(_ValidatingEntryAddingState(
        date: event.date ?? state.date,
        entryType: event.entryType ?? state.entryType,
        calendarFormat: event.calendarFormat ?? state.calendarFormat,
        entriesList: event.entriesList ?? state.entriesList,
        lectionsList: event.lectionsList ?? state.lectionsList,
      ));

      final isStateValid = _isNewStateValid(actualState: state);

      if (_isNewStateValid(actualState: state).isValid) {
        emit(_ValidEntryAddingState(
          date: state.date,
          entryType: state.entryType,
          calendarFormat: state.calendarFormat,
          entriesList: state.entriesList,
          lectionsList: state.lectionsList,
        ));
      } else {
        emit(_InvalidEntryAddingState(
          validationResponse: isStateValid,
          date: state.date,
          entryType: state.entryType,
          calendarFormat: state.calendarFormat,
          entriesList: state.entriesList,
          lectionsList: state.lectionsList,
        ));
      }
    } on Object catch (e, st) {
      onError(e, st);
      emit(_ErrorEntryAddingState(
        error: e,
        date: state.date,
        entryType: state.entryType,
        calendarFormat: state.calendarFormat,
        entriesList: state.entriesList,
        lectionsList: state.lectionsList,
      ));
    }

    // /// Nothing to add
    // ///
    // Future<void> _calendarNothingToAddEvent(CalendarNothingToAddEvent event,
    //     Emitter<CalendarEntryAddingState> emit) async {
    //   await Future<void>.delayed(const Duration(seconds: 2));
    //   emit(state.copyWith(
    //     status: CalendarStateStatus.allDone,
    //   ));
    // }
  }

  @override
  Future<void> close() {
    _entrysListListener.cancel();
    _lectionListListener.cancel();
    log('EntryAddingBloc listeners are closed');
    return super.close();
  }
}
