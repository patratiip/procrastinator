part of 'entry_adding_bloc.dart';

/// Checks if everything is allright or handled an Error State
EntryAddingValidationResponse _isNewStateValid(
    {required EntryAddingState actualState}) {
  final EntryAddingValidationResponse validationResponse =
      EntryAddingValidationResponse(isValid: false);
  // Future check
  if (!_isDateInTheFuture(actualState.date)) {
    return validationResponse.copyWith(
        stateInvalidityType: StateInvalidityType.futureError);
  }

  // Entry exist check
  if (actualState.entriesList.isNotEmpty &&
      !_entryAtThatDateExist(actualState.date, actualState.entriesList)) {
    return validationResponse.copyWith(
        stateInvalidityType: StateInvalidityType.enrtyWithThisDateExists);
  }

  // Lection at that date exists check
  if (actualState.lectionsList.isNotEmpty &&
      !_lectionWithTisDateExist(actualState.date, actualState.lectionsList)) {
    return validationResponse.copyWith(
        stateInvalidityType: StateInvalidityType.noLessonsToday);
  }

  // School and Past check
  if (!_ifTypeIsSchoolDateIsToday(actualState.entryType, actualState.date)) {
    return validationResponse.copyWith(
        stateInvalidityType: StateInvalidityType.schoolOnlyToday);
  }

  return validationResponse.copyWith(isValid: true);
}

/// Returns normalized date
DateTime _normalizeDate(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

bool _entryAtThatDateExist(DateTime date, List<Entry> entriesList) {
  return !entriesList.any((entry) => entry.date == date);
}

bool _lectionWithTisDateExist(DateTime date, List<Lection> lectionsList) {
  return lectionsList.any((lection) => lection.date == date);
}

bool _isDateInTheFuture(DateTime date) {
  final today = _normalizeDate(DateTime.now());
  return !date.isAfter(today);
}

bool _ifTypeIsSchoolDateIsToday(EntryType? type, DateTime date) {
  final today = _normalizeDate(DateTime.now());

  if (type == EntryType.schoolVisit && !date.isAtSameMomentAs(today)) {
    return false;
  }
  return true;
}
