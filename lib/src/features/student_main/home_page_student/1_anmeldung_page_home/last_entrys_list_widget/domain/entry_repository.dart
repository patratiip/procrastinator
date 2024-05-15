import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/last_entry_model.dart';

final currentUser = FirebaseAuth.instance.currentUser!.uid;

class EntryFirestoreRepository {
  final CollectionReference _userVisits = FirebaseFirestore.instance
      .collection('users_flutter')
      .doc(currentUser)
      .collection('userVisits');

  Stream<List<UserVisit>> getVisits() {
    return _userVisits
        .orderBy('date', descending: true)
        .limit(5)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // print('$data loaded');
        return UserVisit(
          // visitID: data?['visitID'],
          visitID: doc.id,
          date: (data['date'] as Timestamp).toDate(),
          // user: (data?['user'] as DocumentReference).toString(),
          schoolVisit: data['schoolVisit'],
          homeOffice: data['homeOffice'],
          krank: data['Krank'],
          fehl: data['Fehl'],
        );
      }).toList();
    });
  }

  // Future<void> addVisit(UserVisit visit) {
  //   return _userVisits.add({
  //     'title': visit.title,
  //     'completed': visit.completed,
  //   });
  // }

  // Future<void> updateVisit(UserVisit visit) {
  //   return _userVisits.doc(visit.id).update({
  //     'title': visit.title,
  //     'completed': visit.completed,
  //   });
  // }

  deleteVisit(String visitId) {
    _userVisits.doc(visitId).delete();
    print('entry $visitId was deleted');
  }
}
