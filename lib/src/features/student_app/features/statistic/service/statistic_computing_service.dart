import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';

class StatisticComputingServise {
  int computeSchoolVisitsQty(List<Entry> entries) {
    int count = 0;
    for (var entry in entries) {
      if (entry.entryType == EntryType.schoolVisit) {
        count += 1;
      }
    }
    return count;
  }

  int computeHomeOfficeQty(List<Entry> entries) {
    int count = 0;
    for (var entry in entries) {
      if (entry.entryType == EntryType.homeOffice) {
        count += 1;
      }
    }
    return count;
  }

  int computeKrankQty(List<Entry> entries) {
    int count = 0;
    for (var entry in entries) {
      if (entry.entryType == EntryType.sick) {
        count += 1;
      }
    }
    return count;
  }

  int computeFehlQty(List<Entry> entries) {
    int count = 0;
    for (var entry in entries) {
      if (entry.entryType == EntryType.loosed) {
        count += 1;
      }
    }
    return count;
  }
}
