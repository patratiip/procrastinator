import 'package:entry_repository/entry_repository.dart';
import 'package:lection_repository/lection_repository.dart';

class ComparingLectionsAndEntrysRepositoryLocal {
//COMPAIRING NEW-- from Bloc State
  List<Lection> comareLectionsAndEntrysState(
    List<Lection>? lectionList,
    List<Entry>? entryList,
  ) {
    final filteredLectionsList = lectionList!
        .where((lection) => lection.date!.isBefore(DateTime.now()))
        .toList();

    final List<Lection> loosedLectionsList = [];

    if (filteredLectionsList.isNotEmpty && entryList!.isNotEmpty) {
      for (final lection in filteredLectionsList) {
        bool found = false;
        for (final visit in entryList) {
          final DateTime visitDate =
              DateTime(visit.date!.year, visit.date!.month, visit.date!.day);
          final DateTime kursDate = DateTime(
              lection.date!.year, lection.date!.month, lection.date!.day);

          if (visitDate == kursDate) {
            found = true;
            break;
          }
        }
        if (!found) {
          loosedLectionsList.add(lection);
        }
      }
      return loosedLectionsList;
    } else {
      return loosedLectionsList;
    }
  }

  /////OLD

  // final FirebaseEntryRepository _entryFirestoreRepository =
  //     GetIt.I<FirebaseEntryRepository>();
  // final LectionFirestoreRepository _lectionFirestoreRepository =
  //     GetIt.I<LectionFirestoreRepository>();

  // //COMPAIRING
  // Future<List<OldLection>> comareLectionsAndEntrysRepos() async {
  //   List<OldLection>? _kursplanQueryList =
  //       await _lectionFirestoreRepository.getLections().first;

  //   final _filteredLectionsList = _kursplanQueryList
  //       .where((lection) => lection.date!.isBefore(DateTime.now()))
  //       .toList();
  //   List<Entry>? visitsQueryList =
  //       await _entryFirestoreRepository.getVisits().first;

  //   final List<OldLection> fehlUnterrichtenList = [];

  //   if (_filteredLectionsList.isNotEmpty && visitsQueryList!.isNotEmpty) {
  //     for (final kurs in _filteredLectionsList) {
  //       bool found = false;
  //       for (final visit in visitsQueryList) {
  //         final DateTime visitDate =
  //             DateTime(visit.date!.year, visit.date!.month, visit.date!.day);
  //         final DateTime kursDate =
  //             DateTime(kurs.date!.year, kurs.date!.month, kurs.date!.day);

  //         if (visitDate == kursDate) {
  //           found = true;
  //           break;
  //         }
  //       }
  //       if (!found) {
  //         fehlUnterrichtenList.add(kurs);
  //       }
  //     }
  //     return fehlUnterrichtenList;
  //   } else {
  //     return fehlUnterrichtenList;
  //   }
  // }
}
