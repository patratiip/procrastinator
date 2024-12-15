part of 'entry_adding_bloc.dart';

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
