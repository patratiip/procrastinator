import 'package:cloud_firestore/cloud_firestore.dart';

class AddVisitModel {
  String? visitID;
  DateTime? date;
  String? user;
  bool? schoolVisit;
  bool? homeOffice;
  bool? krank;
  bool? fehl;

  AddVisitModel(
      {this.visitID,
      this.date,
      this.user,
      this.schoolVisit,
      this.homeOffice,
      this.krank,
      this.fehl});

  // factory UserVisit.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return UserVisit(
  //     visitID: data?['visitID'],
  //     date: data?['date'],
  //     user: data?['user'],
  //     schoolVisit: data?['schoolVisit'],
  //     homeOffice: data?['homeOffice'],
  //     krank: data?['krank'],
  //     fehl: data?['fehl'],
  //   );
  // }

  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if (visitID != null) "visitID": visitID,
  //     if (date != null) "date": date,
  //     if (user != null) "user": user,
  //     if (schoolVisit != null) "schoolVisit": schoolVisit,
  //     if (homeOffice != null) "homeOffice": homeOffice,
  //     if (krank != null) "krank": krank,
  //     if (fehl != null) "fehl": fehl,
  //   };
  // }
}
