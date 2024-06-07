// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/data/lection_model.dart';

final currentUser = FirebaseAuth.instance.currentUser!.uid;

class LectionFirestoreRepository {
  final CollectionReference _lectionsCollectionRef =
      FirebaseFirestore.instance.collection('kursplan_flutter')
      // FirebaseFirestore.instance.collection('kursplan_flutter')

      //TO-DO: Add Groups Link in User Profile
      //and make Kursplan individual for every Group!!!

      // .doc(currentUser)
      // .collection('userVisits')
      ;

  final _today = DateTime.now();

  // final Box<Lection> lectionsBox;
  // LectionFirestoreRepository(
  //   this.lectionsBox,
  // );

  Stream<List<Lection>> getLections() {
    final Timestamp _now =
        Timestamp.fromDate(DateTime(_today.year, _today.month, _today.day));
    return _lectionsCollectionRef
        // .where('date', isGreaterThan: _now)
        .orderBy('date', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // print('$data loaded');
        return Lection(
            theme: data['teme'],
            date: (data['date'] as Timestamp).toDate(),
            // user: (data?['user'] as DocumentReference).toString(),
            trainer: data['trainer'],
            dayOfWeek: data['day'],
            lectionID: doc.id);
      }).toList();
    });
  }

  // addLectionsToHive(List<Lection> lectionsList) async {
  //   if (lectionsBox.isNotEmpty) {
  //     await lectionsBox.clear();
  //   }

  //   final lectionsMap = {for (var e in lectionsList) e.lectionID: e};
  //   await lectionsBox.putAll(lectionsMap);
  //   final printLections = lectionsBox.values;
  //   final printLectionsQty = lectionsBox.values.length;
  //   print('Repo: Hive Qty $printLectionsQty lections $printLections');
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
