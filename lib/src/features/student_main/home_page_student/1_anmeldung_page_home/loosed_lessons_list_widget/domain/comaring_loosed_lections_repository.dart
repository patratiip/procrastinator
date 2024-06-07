import 'package:entry_repository/entry_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/data/lection_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/domain/kursplan_repository.dart';

class ComparingLectionsAndEntrysRepository {
  final FirebaseEntryRepository _entryFirestoreRepository =
      GetIt.I<FirebaseEntryRepository>();
  final LectionFirestoreRepository _lectionFirestoreRepository =
      GetIt.I<LectionFirestoreRepository>();

  //COMPAIRING
  Future<List<Lection>> comareLectionsAndEntrys() async {
    List<Lection>? _kursplanQueryList =
        await _lectionFirestoreRepository.getLections().first;

    final _filteredLectionsList = _kursplanQueryList
        .where((lection) => lection.date!.isBefore(DateTime.now()))
        .toList();
    List<Entry>? visitsQueryList =
        await _entryFirestoreRepository.getVisits().first;

    final List<Lection> fehlUnterrichtenList = [];

    if (_filteredLectionsList.isNotEmpty && visitsQueryList!.isNotEmpty) {
      for (final kurs in _filteredLectionsList) {
        bool found = false;
        for (final visit in visitsQueryList) {
          final DateTime visitDate =
              DateTime(visit.date!.year, visit.date!.month, visit.date!.day);
          final DateTime kursDate =
              DateTime(kurs.date!.year, kurs.date!.month, kurs.date!.day);

          if (visitDate == kursDate) {
            found = true;
            break;
          }
        }
        if (!found) {
          fehlUnterrichtenList.add(kurs);
        }
      }
      return fehlUnterrichtenList;
    } else {
      return fehlUnterrichtenList;
    }
  }
}
