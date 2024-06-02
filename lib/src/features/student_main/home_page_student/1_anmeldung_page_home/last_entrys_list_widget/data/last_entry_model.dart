import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'last_entry_model.g.dart';


@HiveType(typeId: 2)
class Entry extends Equatable {
  @HiveField(0)
  final String? visitID;
  @HiveField(1)
  final DateTime? date;
  @HiveField(2)
  final String? user;
  @HiveField(3)
  final bool? schoolVisit;
  @HiveField(4)
  final bool? homeOffice;
  @HiveField(5)
  final bool? krank;
  @HiveField(6)
  final bool? fehl;

  const Entry(
      {this.visitID,
      this.date,
      this.user,
      this.schoolVisit,
      this.homeOffice,
      this.krank,
      this.fehl});

  @override
  List<Object?> get props =>
      [visitID, date, user, schoolVisit, homeOffice, krank, fehl];

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
