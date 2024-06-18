import 'package:entry_repository/entry_repository.dart';

// final currentUser = FirebaseAuth.instance.currentUser!.uid;

class StatisticRepositoryLocal {
  // final CollectionReference _userVisits = FirebaseFirestore.instance
  //     .collection('users_flutter')
  //     .doc(currentUser)
  //     .collection('userVisits');

  ////////////
  ///
  int computeSchoolVisitsQty(List<Entry> entries) {
    int count = 0;
    for (var entry in entries) {
      if (entry.schoolVisit == true) {
        count += 1;
      }
    }
    return count;
  }

  int computeHomeOfficeQty(List<Entry> entries) {
    int count = 0;
    for (var entry in entries) {
      if (entry.homeOffice == true) {
        count += 1;
      }
    }
    return count;
  }

  int computeKrankQty(List<Entry> entries) {
    int count = 0;
    for (var entry in entries) {
      if (entry.krank == true) {
        count += 1;
      }
    }
    return count;
  }

  int computeFehlQty(List<Entry> entries) {
    int count = 0;
    for (var entry in entries) {
      if (entry.fehl == true) {
        count += 1;
      }
    }
    return count;
  }

// /////OLD////
//   Future<int?> getSchoolVisitsQty() async {
//     int? schoolVisits;
//     await _userVisits
//         .where('schoolVisit', isEqualTo: true)
//         .count()
//         .get()
//         .then((value) {
//       schoolVisits = value.count;
//     });
//     // print('School $schoolVisits');
//     return schoolVisits;
//   }

//   Future<int?> getHomeOfficeQty() async {
//     int? homeOffice;
//     await _userVisits
//         .where('homeOffice', isEqualTo: true)
//         .count()
//         .get()
//         .then((value) {
//       homeOffice = value.count;
//     });
//     // print('Home $homeOffice');
//     return homeOffice;
//   }

//   Future<int?> getKrankQty() async {
//     int? krank;
//     await _userVisits
//         .where('Krank', isEqualTo: true)
//         .count()
//         .get()
//         .then((value) {
//       krank = value.count;
//     });
//     // print('Krank $krank');
//     return krank;
//   }

//   Future<int?> getFehlQty() async {
//     int? fehl;
//     await _userVisits
//         .where('Fehl', isEqualTo: true)
//         .count()
//         .get()
//         .then((value) {
//       fehl = value.count;
//     });
//     // print('Fehl $fehl');
//     return fehl;
//   }
}
