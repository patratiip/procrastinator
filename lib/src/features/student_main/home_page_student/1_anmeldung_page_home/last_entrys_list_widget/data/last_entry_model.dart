class UserVisit {
  final String? visitID;
  final DateTime? date;
  final String? user;
  final bool? schoolVisit;
  final bool? homeOffice;
  final bool? krank;
  final bool? fehl;

  UserVisit(
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
