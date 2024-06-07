import 'package:entry_repository/src/entities/entry_enity.dart';
import 'package:equatable/equatable.dart';

class Entry extends Equatable {
  String? visitID;
  DateTime? date;
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
    } else if (homeOffice != null) {
      entity.homeOffice = homeOffice;
    } else if (krank != null) {
      entity.krank = krank;
    } else if (fehl != null) {
      entity.fehl = fehl;
    }
    return entity;
  }

  static Entry fromEntity(EntryEntity entity) {
    final Entry entry = Entry(visitID: entity.visitID, date: entity.date);
    if (entity.schoolVisit != null) {
      entry.schoolVisit = entity.schoolVisit;
    } else if (entity.homeOffice != null) {
      entry.homeOffice = entity.homeOffice;
    } else if (entity.krank != null) {
      entry.krank = entity.krank;
    } else if (entity.fehl != null) {
      entry.fehl = entity.fehl;
    }
    return entry;
  }

  @override
  List<Object?> get props =>
      [visitID, date, schoolVisit, homeOffice, krank, fehl];
}
