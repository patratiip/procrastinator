// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

/// {@template entry_model}
/// [EntryModel] is a DTO for [Entry] entity.
/// {@endtemplate}

class EntryModel {
  String visitID;
  DateTime date;
  bool? schoolVisit;
  bool? homeOffice;
  bool? sick;
  bool? loosed;

  /// {@macro entry_model}
  EntryModel({
    required this.visitID,
    required this.date,
    this.schoolVisit,
    this.homeOffice,
    this.sick,
    this.loosed,
  });

  /// Converts [EntryModel] to json for Firestore
  Map<String, Object?> toFirestore() {
    return {
      'visitID': visitID,
      'date': Timestamp.fromDate(date),
      if (schoolVisit != null) 'schoolVisit': schoolVisit,
      if (homeOffice != null) 'homeOffice': homeOffice,
      if (sick != null) 'Krank': sick,
      if (loosed != null) 'Fehl': loosed
    };
  }

  /// Converts json from Firestore to [EntryModel]
  static EntryModel fromFirestore(Map<String, dynamic> doc) {
    return EntryModel(
        visitID: doc['visitID'],
        date: (doc['date'] as Timestamp).toDate(),
        schoolVisit: doc['schoolVisit'],
        homeOffice: doc['homeOffice'],
        sick: doc['Krank'],
        loosed: doc['Fehl']);
  }

  @override
  bool operator ==(covariant EntryModel other) {
    if (identical(this, other)) return true;

    return other.visitID == visitID &&
        other.date == date &&
        other.schoolVisit == schoolVisit &&
        other.homeOffice == homeOffice &&
        other.sick == sick &&
        other.loosed == loosed;
  }

  @override
  int get hashCode {
    return visitID.hashCode ^
        date.hashCode ^
        schoolVisit.hashCode ^
        homeOffice.hashCode ^
        sick.hashCode ^
        loosed.hashCode;
  }

  @override
  String toString() {
    return 'EntryModel(visitID: $visitID, date: $date, schoolVisit: $schoolVisit, homeOffice: $homeOffice, krank: $sick, fehl: $loosed)';
  }
}
