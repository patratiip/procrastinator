part of 'entry_adding_bloc.dart';

/// Checks if everything is allright or handled an Error State
EntryAddingValidationResponse? _isNewStateValid(
    {required EntryAddingState actualState}) {
  // TODO: Add validation for situations:
  // state have no entryType, lections list is empty

  // Future check
  if (!_isDateInTheFuture(actualState.date)) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.futureError);
  }

  // Entry exist check
  if (actualState.entriesList.isNotEmpty &&
      !_entryAtThatDateExist(actualState.date, actualState.entriesList)) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.enrtyWithThisDateExists);
  }

  // Lection at that date exists check
  if (actualState.lectionsList.isNotEmpty &&
      !_lectionWithTisDateExist(actualState.date, actualState.lectionsList)) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.noLessonsToday);
  }

  // School and Past check
  if (!_ifTypeIsSchoolDateIsToday(actualState.entryType, actualState.date)) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.schoolOnlyToday);
  }

  // State entryType is null
  if (actualState.entryType == null) {
    return EntryAddingValidationResponse(
        stateValidityType: StateValidityType.noEntryType);
  }

  return null;
}



/// Checking if entry at that date already exist in [entriesList]
bool _entryAtThatDateExist(DateTime date, List<Entry> entriesList) {
  return !entriesList.any((entry) => entry.date == date);
}

/// Checking if entry at that date exist in [lectionsList]
bool _lectionWithTisDateExist(DateTime date, List<Lection> lectionsList) {
  return lectionsList.any((lection) => lection.date == date);
}

/// Checking if actual [state.date] is in a future
bool _isDateInTheFuture(DateTime date) {
  final today = dateNormalizer(DateTime.now());
  return !date.isAfter(today);
}

/// Checking if actual [state.date] is today when user choosed [EntryType.schoolVisit]
bool _ifTypeIsSchoolDateIsToday(EntryType? type, DateTime date) {
  final today = dateNormalizer(DateTime.now());

  if (type == EntryType.schoolVisit && !date.isAtSameMomentAs(today)) {
    return false;
  }
  return true;
}
