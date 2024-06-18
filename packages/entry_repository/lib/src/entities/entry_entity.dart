import 'package:cloud_firestore/cloud_firestore.dart';

class EntryEntity {
  String? visitID;
  DateTime? date;
  bool? schoolVisit;
  bool? homeOffice;
  bool? krank;
  bool? fehl;

  EntryEntity(
      {required this.visitID,
      required this.date,
      this.schoolVisit,
      this.homeOffice,
      this.krank,
      this.fehl});

  Map<String, Object?> toFirestore() {
    return {
      if (visitID != null) 'visitID': visitID,
      if (date != null) 'date': Timestamp.fromDate(date!),
      if (schoolVisit != null) 'schoolVisit': schoolVisit,
      if (homeOffice != null) 'homeOffice': homeOffice,
      if (krank != null) 'Krank': krank,
      if (fehl != null) 'Fehl': fehl
    };
  }

  static EntryEntity fromFirestore(Map<String, dynamic> doc) {
    return EntryEntity(
        visitID: doc['visitID'],
        date: (doc['date'] as Timestamp).toDate(),
        schoolVisit: doc['schoolVisit'],
        homeOffice: doc['homeOffice'],
        krank: doc['Krank'],
        fehl: doc['Fehl']);
  }
}
