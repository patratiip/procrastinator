import 'package:entry_repository/entry_repository.dart';

abstract class EntryRepositoty {
  
  Stream<List<Entry>?> getVisits();
  Future<void> addEntry(Entry entry);
  Future<void> deleteEntry(String visitId);
}
