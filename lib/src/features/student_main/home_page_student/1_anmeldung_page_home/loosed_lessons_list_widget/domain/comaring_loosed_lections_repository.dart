import 'package:hive_flutter/hive_flutter.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/data/last_entry_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/data/lection_model.dart';

class ComparingLectionsAndEntrysRepository {
  final Box<Entry> entriesBox;
  final Box<Lection> lectionsBox;

  ComparingLectionsAndEntrysRepository(this.entriesBox, this.lectionsBox);

  // Stream<BoxEvent> enriesBoxStream() {
  //   return entriesBox.watch().timeout(const Duration(seconds: 5));
  // }

  // Stream<BoxEvent> lectionsBoxStream() {
  //   return entriesBox.watch().timeout(const Duration(seconds: 5));
  // }

  //COMPAIRING
  Future<List<Lection>> comareLectionsAndEntrys() async {
    List<Lection> kursplanQueryList = lectionsBox.values
        .toList()
        .where((lection) => lection.date!.isBefore(DateTime.now()))
        .toList();
    List<Entry> visitsQueryList = entriesBox.values.toList();

    final List<Lection> fehlUnterrichtenList = [];

    if (kursplanQueryList.isNotEmpty && visitsQueryList.isNotEmpty) {
      for (final kurs in kursplanQueryList) {
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
