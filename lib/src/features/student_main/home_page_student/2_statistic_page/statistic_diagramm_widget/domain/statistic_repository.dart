import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final currentUser = FirebaseAuth.instance.currentUser!.uid;

class StatisticRepository {
  final CollectionReference _userVisits = FirebaseFirestore.instance
      .collection('users_flutter')
      .doc(currentUser)
      .collection('userVisits');

  Future<int?> getSchoolVisitsQty() async {
    int? schoolVisits;
    await _userVisits
        .where('schoolVisit', isEqualTo: true)
        .count()
        .get()
        .then((value) {
      schoolVisits = value.count;
    });
    // print('School $schoolVisits');
    return schoolVisits;
  }

  Future<int?> getHomeOfficeQty() async {
    int? homeOffice;
    await _userVisits
        .where('homeOffice', isEqualTo: true)
        .count()
        .get()
        .then((value) {
      homeOffice = value.count;
    });
    // print('Home $homeOffice');
    return homeOffice;
  }

  Future<int?> getKrankQty() async {
    int? krank;
    await _userVisits
        .where('Krank', isEqualTo: true)
        .count()
        .get()
        .then((value) {
      krank = value.count;
    });
    // print('Krank $krank');
    return krank;
  }

  Future<int?> getFehlQty() async {
    int? fehl;
    await _userVisits
        .where('Fehl', isEqualTo: true)
        .count()
        .get()
        .then((value) {
      fehl = value.count;
    });
    // print('Fehl $fehl');
    return fehl;
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
}
