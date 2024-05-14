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
  final _now = DateTime.now();
  //Testing No Lections
  // final _now = DateTime(2024, 02, 22);

  Future getTodayLection() async {
    final Timestamp today =
        Timestamp.fromDate(DateTime(_now.year, _now.month, _now.day));

    try {
      final todayQuery =
          await _lectionsCollection.where('date', isEqualTo: today).get();
      Map<String, dynamic> data =
          todayQuery.docs.first.data() as Map<String, dynamic>;
      // print('$data loaded');
      return TodayLection(
        theme: data['teme'],
        date: (data['date'] as Timestamp).toDate(),
        // user: (data?['user'] as DocumentReference).toString(),
        trainer: data['trainer'],
        dayOfWeek: data['day'],
      );
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  // Stream<List<TodayLection>> getTodayLectionStream() {
  //   final Timestamp _now =
  //       Timestamp.fromDate(DateTime(_today.year, _today.month, _today.day));
  //   print(_now);
  //   return _lectionsCollection
  //       .where('date', isEqualTo: _now)
  //       .snapshots()
  //       .map((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       print('$data loaded');
  //       return TodayLection(
  //         theme: data['teme'],
  //         date: (data['date'] as Timestamp).toDate(),
  //         // user: (data?['user'] as DocumentReference).toString(),
  //         trainer: data['trainer'],
  //         dayOfWeek: data['day'],
  //       );
  //     }).toList();
  //   });
  // }

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
