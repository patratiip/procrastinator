// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:procrastinator/src/app_student/features/entries/model/entry_model.dart';
import 'package:procrastinator/src/core/utils/little_helpers.dart';

/// {@template entry_type_enum}
/// Determined [EntryType] for [Entry].
/// Thay can be [schoolVisit], [homeOffice], [sick], [loosed]
/// {@endtemplate}
enum EntryType {
  schoolVisit,
  homeOffice,
  sick,
  loosed,
}

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

  /// Converts [Entry] to model
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
          model.sick = true;
        }
      case EntryType.loosed:
        {
          model.loosed = true;
        }
    }

    return model;
  }

  /// Converts model to [Entry] entity
  static Entry fromModel(EntryModel model) {
    Entry entry = Entry(
        visitID: model.visitID,
        date: dateNormalizer(model.date),
        entryType: EntryType.homeOffice);

    if (model.schoolVisit != null) {
      entry = entry.copyWith(entryType: EntryType.schoolVisit);
    }
    if (model.sick != null) {
      entry = entry.copyWith(entryType: EntryType.sick);
    }
    if (model.loosed != null) {
      entry = entry.copyWith(entryType: EntryType.loosed);
    }
    return entry;
  }

  Entry copyWith({
    DateTime? date,
    EntryType? entryType,
  }) {
    return Entry(
      visitID: visitID,
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
