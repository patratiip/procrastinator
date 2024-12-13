// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:procrastinator/src/features/student_app/features/entries/model/entry_model.dart';

/// {@template entry_type_enum}
/// Determined [EntryType] for [Entry].
/// Thay can be{ [schoolVisit], [homeOffice], [sick], [loosed] }
/// {@endtemplate}

enum EntryType { schoolVisit, homeOffice, sick, loosed }

/// {@macro entry_type_enum}

/// {@template entry_entity}
/// An [Entry] entity class.
/// {@endtemplate}

class Entry {
  final String visitID;
  final DateTime date;
  final EntryType entryType;

  /// {@macro entry_entity}
  const Entry({
    required this.visitID,
    required this.date,
    required this.entryType,
  });

  EntryModel toModel() {
    final EntryModel model = EntryModel(visitID: visitID, date: date);

    switch (entryType) {
      case EntryType.schoolVisit:
        {
          model.schoolVisit = true;
        }
      case EntryType.homeOffice:
        {
          model.homeOffice = true;
        }

      case EntryType.sick:
        {
          model.krank = true;
        }

      case EntryType.loosed:
        {
          model.fehl = true;
        }
    }

    return model;
  }

  static Entry fromModel(EntryModel model) {
    Entry entry = Entry(
        visitID: model.visitID,
        date: _normalizeDate(model.date),
        entryType: EntryType.homeOffice);

    if (model.schoolVisit != null) {
      entry = entry.copyWith(entryType: EntryType.schoolVisit);
    }
    if (model.krank != null) {
      entry = entry.copyWith(entryType: EntryType.sick);
    }
    if (model.fehl != null) {
      entry = entry.copyWith(entryType: EntryType.loosed);
    }
    return entry;
  }

  /// Returns normalized date
  static DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Entry copyWith({
    String? visitID,
    DateTime? date,
    EntryType? entryType,
  }) {
    return Entry(
      visitID: visitID ?? this.visitID,
      date: date ?? this.date,
      entryType: entryType ?? this.entryType,
    );
  }

  @override
  bool operator ==(covariant Entry other) {
    if (identical(this, other)) return true;

    return other.visitID == visitID &&
        other.date == date &&
        other.entryType == entryType;
  }

  @override
  int get hashCode => visitID.hashCode ^ date.hashCode ^ entryType.hashCode;

  @override
  String toString() =>
      'Entry(visitID: $visitID, date: $date, entryType: $entryType)';
}
