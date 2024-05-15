import 'package:procrastinator/src/features/student_main/home_page_student/1_anmeldung_page_home/last_entrys_list_widget/data/last_entry_model.dart';
import 'package:procrastinator/src/features/student_main/home_page_student/3_kursplan_page/data/lection_model.dart';

class ComparingLectionsAndEntrysRepository {
  //
  List<Lection> comareLectionsAndEntrys(
      {required List<Lection> kursplanQuery,
      required List<Entry> visitsQuery}) {
    List<Lection> kursplanQueryList = kursplanQuery;
    List<Entry> visitsQueryList = visitsQuery;

    final List<Lection> fehlUnterrichtenList = [];

    for (final kurs in kursplanQueryList) {
      bool found = false;
      for (final visit in visitsQueryList) {
        if (visit.date == kurs.date) {
          found = true;
          break;
        }
      }
      if (!found) {
        fehlUnterrichtenList.add(kurs);
      }
    }
    print(fehlUnterrichtenList);
    return fehlUnterrichtenList;
  }
}
