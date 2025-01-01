import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';
import 'package:procrastinator/src/app_student/features/loosed_entries/data/loosed_entries_firebase_data_provider.dart';

/// Interface for [LoosedEntriesRepositoryImpl]
///
/// The repository that adding entries
abstract class ILoosedEntriesRepository {
  // Firebase Data Provider
  /// Getting lections stream
  Stream<List<Lection>> lectionsStream();

  /// Getting entries stream
  Stream<List<Entry>> entriesStream();

  /// Compairing [Entry] and [Lection] lists do define loosed entries
  Future<List<Lection>> comareLectionsAndEntries(
    List<Lection> lectionList,
    List<Entry> entryList,
  );
}

/// {@template loosed_entries_repository_impl}
/// Implementation of [ILoosedEntriesRepository].
/// {@endtemplate}
final class LoosedEntriesRepositoryImpl implements ILoosedEntriesRepository {
  final ILoosedEntriesFirebaseDataProvider _loosedEntriesFirebaseDataProvider;

  /// {@macro loosed_entries_repository_impl}
  LoosedEntriesRepositoryImpl(
      {required ILoosedEntriesFirebaseDataProvider
          loosedEntriesFirebaseDataProvider})
      : _loosedEntriesFirebaseDataProvider = loosedEntriesFirebaseDataProvider;

  @override
  Stream<List<Lection>> lectionsStream() {
    /// Convert [LectionModel]'s stream to an [Lection] stream
    return _loosedEntriesFirebaseDataProvider
        .lectionsStream()
        .map((entities) =>
            entities.map((entity) => Lection.fromModel(entity)).toList())
        .asBroadcastStream();
  }

  @override
  Stream<List<Entry>> entriesStream() {
    /// Convert [EntryModel]'s stream to an [Entry]'s stream
    return _loosedEntriesFirebaseDataProvider
        .entriesStream()
        .map((entities) =>
            entities.map((entity) => Entry.fromModel(entity)).toList())
        .asBroadcastStream();
  }

  @override
  Future<List<Lection>> comareLectionsAndEntries(
      List<Lection> lectionList, List<Entry> entryList) async {
    final filteredLectionsList = lectionList
        .where((lection) => lection.date.isBefore(DateTime.now()))
        .toList();

    final List<Lection> loosedLectionsList = [];

    if (filteredLectionsList.isNotEmpty) {
      for (final lection in filteredLectionsList) {
        bool found = false;
        for (final visit in entryList) {
          if (visit.date == lection.date) {
            found = true;
            break;
          }
        }
        if (!found) {
          loosedLectionsList.add(lection);
        }
      }
    }
    return loosedLectionsList;
  }
}
