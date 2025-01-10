// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/actions_redux/app_action.dart';
import 'package:procrastinator/src/app_student/features/entries/bloc/entry_adding_bloc/entry_adding_bloc.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/data/entry_adding_repository.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/redux_app_state.dart';
import 'package:uuid/uuid.dart';

/// {@template add_entry_action}
/// [AddEntryAction] validate state data and add entry to database.
/// {@endtemplate}

class AddEntryAction extends AppAction {
  final IEntryAddingRepository _entryAddingRepository;

  /// {@macro add_entry_action}
  AddEntryAction({
    required IEntryAddingRepository entryAddingRepository,
  }) : _entryAddingRepository = entryAddingRepository;

  @override
  Future<ReduxAppState?> reduce() async {
    final actualEntryAddingState = state.reduxEntryAddingState;
    final validationResponse =
        await _isStudentInSchool(entryType: actualEntryAddingState.entryType!);

    if (validationResponse != null) {
      return state.copy(
        reduxEntryAddingState: actualEntryAddingState.copy(
          validationResponse: validationResponse,
        ),
      );
    }

    final Entry entry = Entry(
        visitID: const Uuid().v4(),
        date: actualEntryAddingState.date,
        entryType: actualEntryAddingState.entryType!);

    // Entry Adding
    _entryAddingRepository.addEntry(entry);

    log('Entry was successfully added $entry');

    return null;
  }

  /// Checks if Student is in the scool
  /// or handled an Error State with a distance to school
  Future<EntryAddingValidationResponse?> _isStudentInSchool(
      {required EntryType entryType}) async {
    if (entryType != EntryType.schoolVisit) return null;
    try {
      //TODO: Handle situation, when user denied acces to device geolocation services
      final userSchoolGeoposition =
          await _entryAddingRepository.getUserSchoolPosition();
      final userGeoPosition = await _entryAddingRepository.determinePosition();

      final distanceToSchool = _entryAddingRepository.distanceToSchool(
          userGeoposition: userGeoPosition,
          schoolLatitude: userSchoolGeoposition.latitude,
          schoolLongtitude: userSchoolGeoposition.longitude);

      if (distanceToSchool >= 100) {
        return EntryAddingValidationResponse(
            stateValidityType: StateValidityType.distanceToSchool,
            value: distanceToSchool.toInt());
      } else {
        return null;
      }
    } on Object catch (error) {
      log(error.toString());
      return EntryAddingValidationResponse(
          stateValidityType: StateValidityType.unexpectedError, value: error);
    }
  }
}
