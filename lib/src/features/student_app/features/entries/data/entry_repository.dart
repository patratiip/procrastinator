import 'package:procrastinator/src/features/student_app/features/entries/data/firebase_entry_data_provider.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';

/// Interface for [EntryRepositoryImpl]
///
/// The repository that working with entries
abstract interface class IEntryRepositoty {
  /// Getting entries stream
  Stream<List<Entry>> entriesStream();

  /// Adding entry to entries collection
  Future<void> addEntry(Entry entry);

  /// Deleting entry from entries collection
  Future<void> deleteEntry(String visitId);
}

/// {@template entry_repository_impl}
/// Implementation of [IEntryRepositoty].
/// {@endtemplate}

final class EntryRepositoryImpl implements IEntryRepositoty {
  final IEntryDataProvider _entryDataProvider;

  /// {@macro entry_repository_impl}
  EntryRepositoryImpl({
    required IEntryDataProvider entryDataProvider,
  }) : _entryDataProvider = entryDataProvider;

  @override
  Stream<List<Entry>> entriesStream() {
    /// Convert [EntryModel]'s stream to an [Entry]'s stream
    return _entryDataProvider
        .entriesStream()
        .map((entities) =>
            entities.map((entity) => Entry.fromModel(entity)).toList())
        .asBroadcastStream();
  }

  @override
  Future<void> addEntry(Entry entry) async {
    await _entryDataProvider.addEntry(entry);
  }

  @override
  Future<void> deleteEntry(String entryId) async {
    await _entryDataProvider.deleteEntry(entryId);
  }
}
