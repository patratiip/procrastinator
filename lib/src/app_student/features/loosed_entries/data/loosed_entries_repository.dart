import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entry_adding/data/entry_adding_firebase_data_provider.dart';
import 'package:procrastinator/src/app_student/features/lection_plan/model/lection.dart';

/// Interface for [LoosedEntriesRepositoryImpl]
///
/// The repository that adding entries
abstract class ILoosedEntriesRepository {
  // Firebase Data Provider
  /// Getting lections stream
  Stream<List<Lection>> lectionsStream();

  /// Getting entries stream
  Stream<List<Entry>> entriesStream();

  /// Adding entry to entries collection
  Future<void> addEntry(Entry entry);
}

/// {@template loosed_entries_repository_impl}
/// Implementation of [ILoosedEntriesRepository].
/// {@endtemplate}
final class LoosedEntriesRepositoryImpl implements ILoosedEntriesRepository {
  final IEntryAddingFirebaseDataProvider _entryAddingFirebaseDataProvider;

  /// {@macro loosed_entries_repository_impl}
  LoosedEntriesRepositoryImpl(
      {required IEntryAddingFirebaseDataProvider
          entryAddingFirebaseDataProvider})
      : _entryAddingFirebaseDataProvider = entryAddingFirebaseDataProvider;

  @override
  Stream<List<Lection>> lectionsStream() {
    /// Convert [LectionModel]'s stream to an [Lection] stream
    return _entryAddingFirebaseDataProvider
        .lectionsStream()
        .map((entities) =>
            entities.map((entity) => Lection.fromModel(entity)).toList())
        .asBroadcastStream();
  }

  @override
  Stream<List<Entry>> entriesStream() {
    /// Convert [EntryModel]'s stream to an [Entry]'s stream
    return _entryAddingFirebaseDataProvider
        .entriesStream()
        .map((entities) =>
            entities.map((entity) => Entry.fromModel(entity)).toList())
        .asBroadcastStream();
  }

  /// Adding [Entry] to UserVisits collection
  @override
  Future<void> addEntry(Entry entry) async {
    await _entryAddingFirebaseDataProvider.addEntry(entry);
  }
}
