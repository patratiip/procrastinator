import '../../../../old_files/fake_data/anmeldungen_fake_data/anmeldungen_fake.dart';
import '../../../../old_files/fake_data/kursplan_fake_data/kursplan_fake.dart';

class LoosedEntrysFunction {
  // final List<AnmeldungEntry>? studentsEntrys;
  // final List<KursplanEntry>? kursplanLessons;

  LoosedEntrysFunction(

      // required this.studentsEntrys, required this.kursplanLessons
      );

  // var dateFormat = DateFormat('dd.MM.yy');

  List<KursplanEntry>? loosedLessons;

  List<KursplanEntry>? result(List<AnmeldungEntry> studentsEntrys,
      List<KursplanEntry> kursplanLessons) {
    if (studentsEntrys == null || kursplanLessons == null) {
      return null;
    }

    final List<KursplanEntry> loosedLessons = [];

    for (final lesson in kursplanLessons) {
      bool found = false;
      for (final entry in studentsEntrys) {
        if (entry.date == lesson.date) {
          found = true;
          break;
        }
      }
      if (!found) {
        loosedLessons.add(lesson);
      }
    }

    return loosedLessons;
  }
}
