import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../data/last_entry_model.dart';

final currentUser = FirebaseAuth.instance.currentUser!.uid;

class OLDEntryFirestoreRepository {
  final CollectionReference _userVisits = FirebaseFirestore.instance
      .collection('users_flutter')
      .doc(currentUser)
      .collection('userVisits');

  // final Box<Entry> entriesBox;

  // EntryFirestoreRepository(this.entriesBox);

  Stream<List<LastEntry>> getVisits() {
    return _userVisits
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // print('ENTRIES STREAM $data loaded');
        return LastEntry(
            // visitID: data?['visitID'],
            visitID: doc.id,
            date: (data['date'] as Timestamp).toDate(),
            // user: (data?['user'] as DocumentReference).toString(),

            schoolVisit: data['schoolVisit'],
            homeOffice: data['homeOffice'],
            krank: data['Krank'],
            fehl: data['Fehl']);
      }).toList();
    });
  }

  // addEntriesToHive(List<Entry> entriesList) async {
  //   await entriesBox.clear();
  //   final entriesMap = {for (var e in entriesList) e.visitID: e};
  //   await entriesBox.putAll(entriesMap);
  //   final printEntries = entriesBox.values;
  //   final printEntriesQty = entriesBox.values.length;
  //   print('Repo: Hive Qty $printEntriesQty entries $printEntries');
  // }

  // addEntryToHive(Entry entry) async {
  //   await entriesBox.put(entry.visitID, entry);
  //   final printEntries = entriesBox.values;
  //   final printEntriesQty = entriesBox.values.length;
  //   print(
  //       'Repo: Hive Qty $printEntriesQty entries $printEntries, added $entry');
  // }

  // Future<List<Entry>>? getEntriesFromHive() async {
  //   final entriesListFromHive = await entriesBox.values.toList();
  //   return entriesListFromHive;
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

  deleteVisit(String visitId) {
    _userVisits.doc(visitId).delete();
    print('entry $visitId was deleted');
  }
}
