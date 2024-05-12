import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/heutige_unterricht_widget/data/today_lection_model.dart';

final currentUser = FirebaseAuth.instance.currentUser!.uid;

class TodayLectionFirestoreRepository {
  final CollectionReference _lectionsCollection =
      FirebaseFirestore.instance.collection('kursplan_flutter')
      // FirebaseFirestore.instance.collection('kursplan_flutter')

      //TO-DO: Add Groups Link in User Profile
      //and make Kursplan individual for every Group!!!

      // .doc(currentUser)
      // .collection('userVisits')
      ;

  Stream<List<TodayLection>> getTodayLection() {
    return _lectionsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print('$data loaded');
        return TodayLection(
          theme: data['teme'],
          date: (data['date'] as Timestamp).toDate(),
          // user: (data?['user'] as DocumentReference).toString(),
          trainer: data['trainer'],
          dayOfWeek: data['day'],
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

  // deleteVisit(String visitId) {
  //   _lectionsCollectionRef.doc(visitId).delete();
  //   print('entry $visitId was deleted');
  // }
}
