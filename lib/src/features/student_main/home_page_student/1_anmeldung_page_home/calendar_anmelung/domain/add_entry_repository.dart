import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/add_entry_model.dart';

final currentUser = FirebaseAuth.instance.currentUser!.uid;

class CalendarEntryFirestoreRepository {
  final CollectionReference _userVisits = FirebaseFirestore.instance
      .collection('users_flutter')
      .doc(currentUser)
      .collection('userVisits');

  Future<void> addVisit(AddVisitModel visit) {
    String type = '';

    if (visit.schoolVisit == true) {
      type = 'schoolVisit';
    } else if (visit.homeOffice == true) {
      type = 'homeOffice';
    } else if (visit.fehl == true) {
      type = 'Fehl';
    } else if (visit.krank == true) {
      type = 'Krank';
    }

    return _userVisits
        .add({'date': Timestamp.fromDate(visit.date!), type: true});
  }

  // Stream<List<UserVisit>> getVisits() {
  //   return _userVisits
  //       .orderBy('date', descending: true)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       // print('$data loaded');
  //       return UserVisit(
  //         // visitID: data?['visitID'],
  //         visitID: doc.id,
  //         date: (data['date'] as Timestamp).toDate(),
  //         // user: (data?['user'] as DocumentReference).toString(),
  //         schoolVisit: data['schoolVisit'],
  //         homeOffice: data['homeOffice'],
  //         krank: data['Krank'],
  //         fehl: data['Fehl'],
  //       );
  //     }).toList();
  //   });
  // }

  // Future<void> updateVisit(UserVisit visit) {
  //   return _userVisits.doc(visit.id).update({
  //     'title': visit.title,
  //     'completed': visit.completed,
  //   });
  // }

  // deleteVisit(String visitId) {
  //   _userVisits.doc(visitId).delete();
  //   print('entry $visitId was deleted');
  // }
}
