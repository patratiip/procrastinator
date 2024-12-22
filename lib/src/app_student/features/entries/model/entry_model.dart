// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template entry_model}
/// [EntryModel] is a DTO for [Entry].
/// {@endtemplate}

class EntryModel {
  String visitID;
  DateTime date;
  bool? schoolVisit;
  bool? homeOffice;
  bool? krank;
  bool? fehl;

  /// {@macro entry_model}
  EntryModel(
      {required this.visitID,
      required this.date,
      this.schoolVisit,
      this.homeOffice,
      this.krank,
      this.fehl});

  Map<String, Object?> toFirestore() {
    return {
      'visitID': visitID,
      'date': Timestamp.fromDate(date),
      if (schoolVisit != null) 'schoolVisit': schoolVisit,
      if (homeOffice != null) 'homeOffice': homeOffice,
      if (krank != null) 'Krank': krank,
      if (fehl != null) 'Fehl': fehl
    };
  }

  static EntryModel fromFirestore(Map<String, dynamic> doc) {
    return EntryModel(
        visitID: doc['visitID'],
        date: (doc['date'] as Timestamp).toDate(),
        schoolVisit: doc['schoolVisit'],
        homeOffice: doc['homeOffice'],
        krank: doc['Krank'],
        fehl: doc['Fehl']);
  }

  @override
  bool operator ==(covariant EntryModel other) {
    if (identical(this, other)) return true;

    return other.visitID == visitID &&
        other.date == date &&
        other.schoolVisit == schoolVisit &&
        other.homeOffice == homeOffice &&
        other.krank == krank &&
        other.fehl == fehl;
  }

  @override
  int get hashCode {
    return visitID.hashCode ^
        date.hashCode ^
        schoolVisit.hashCode ^
        homeOffice.hashCode ^
        krank.hashCode ^
        fehl.hashCode;
  }
}
