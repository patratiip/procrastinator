import 'package:cloud_firestore/cloud_firestore.dart';

class EntryValidator {
  final _now = DateTime.now();
  //  final Timestamp today =
  //       Timestamp.fromDate(DateTime(_now.year, _now.month, _now.day));
  bool validateDate(DateTime date) {
    final _dateIsValid = false;

    return _dateIsValid;
  }

  bool validateExistingEntry(DateTime date) {
    final _entryExist = false;

    return _entryExist;
  }
}
