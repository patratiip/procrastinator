import 'package:entry_repository/entry_repository.dart';

class StatisticComputingServise {
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
}
