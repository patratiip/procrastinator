// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry_entity.dart';

enum EntryType { schoolVisit, homeOffice, sick, loosed }

class Entry extends Equatable {
  final String visitID;
  final DateTime date;
  final EntryType entryType;

  const Entry({
    required this.visitID,
    required this.date,
    required this.entryType,
  });

  // static final empty = Entry(visitID: '', date: DateTime.now(), entryType: null);

  EntryEntity toEntity() {
    final EntryEntity entity = EntryEntity(visitID: visitID, date: date);
    if (entryType == EntryType.schoolVisit) {
      entity.schoolVisit = true;
    }
    if (entryType == EntryType.homeOffice) {
      entity.homeOffice = true;
    }
    if (entryType == EntryType.sick) {
      entity.krank = true;
    }
    if (entryType == EntryType.loosed) {
      entity.fehl = true;
    }

    return entity;
  }

  static Entry fromEntity(EntryEntity entity) {
    Entry entry = Entry(
        visitID: entity.visitID,
        date: _normalizeDate(entity.date),
        entryType: EntryType.homeOffice);

    if (entity.schoolVisit != null) {
      entry = entry.copyWith(entryType: EntryType.schoolVisit);
    }
    if (entity.krank != null) {
      entry = entry.copyWith(entryType: EntryType.sick);
    }
    if (entity.fehl != null) {
      entry = entry.copyWith(entryType: EntryType.loosed);
    }
    return entry;
  }

  @override
  List<Object> get props => [visitID, date, entryType];

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

  /// Returns normalized date
  static DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
