import 'package:entry_repository/src/entities/entry_entity.dart';
import 'package:equatable/equatable.dart';

class Entry extends Equatable {
  final String visitID;
  final DateTime date;
  bool? schoolVisit;
  bool? homeOffice;
  bool? krank;
  bool? fehl;

  Entry(
      {required this.visitID,
      required this.date,
      this.schoolVisit,
      this.homeOffice,
      this.krank,
      this.fehl});

  static final empty = Entry(visitID: '', date: DateTime.now());

  EntryEntity toEntity() {
    final EntryEntity entity = EntryEntity(visitID: visitID, date: date);
    if (schoolVisit != null) {
      entity.schoolVisit = schoolVisit;
    }
    if (homeOffice != null) {
      entity.homeOffice = homeOffice;
    }
    if (krank != null) {
      entity.krank = krank;
    }
    if (fehl != null) {
      entity.fehl = fehl;
    }

    return entity;
  }

  static Entry fromEntity(EntryEntity entity) {
    final Entry entry = Entry(visitID: entity.visitID, date: entity.date);
    if (entity.schoolVisit != null) {
      entry.schoolVisit = entity.schoolVisit;
    }
    if (entity.homeOffice != null) {
      entry.homeOffice = entity.homeOffice;
    }
    if (entity.krank != null) {
      entry.krank = entity.krank;
    }
    if (entity.fehl != null) {
      entry.fehl = entity.fehl;
    }
    return entry;
  }

  @override
  List<Object?> get props =>
      [visitID, date, schoolVisit, homeOffice, krank, fehl];

  @override
  String toString() {
    return 'Entry: $visitID, $date, $schoolVisit, $homeOffice, $krank, $fehl';
  }
}
