import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/data/entry_adding_data_provider.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection.dart';

/// Interface for [EntryAddingRepositoryImpl]
///
/// The repository that adding entries
abstract class IEntryAddingRepository {
  /// Getting lections stream
  Stream<List<Lection>> lectionsStream();

  /// Getting entries stream
  Stream<List<Entry>> entriesStream();

  /// Adding entry to entries collection
  Future<void> addEntry(Entry entry);
}

/// {@template entry_adding_repository_impl}
/// Implementation of [IEntryAddingRepository].
/// {@endtemplate}
final class EntryAddingRepositoryImpl implements IEntryAddingRepository {
  final IEntryAddingDataProvider _entryAddingDataProvider;

  /// {@macro entry_adding_repository_impl}
  EntryAddingRepositoryImpl({
    required IEntryAddingDataProvider entryAddingDataProvider,
  }) : _entryAddingDataProvider = entryAddingDataProvider;

  @override
  Stream<List<Lection>> lectionsStream() {
    /// Convert [LectionModel]'s stream to an [Lection] stream
    return _entryAddingDataProvider
        .lectionsStream()
        .map((entities) =>
            entities.map((entity) => Lection.fromModel(entity)).toList())
        .asBroadcastStream();
  }

  @override
  Stream<List<Entry>> entriesStream() {
    /// Convert [EntryModel]'s stream to an [Entry]'s stream
    return _entryAddingDataProvider
        .entriesStream()
        .map((entities) =>
            entities.map((entity) => Entry.fromModel(entity)).toList())
        .asBroadcastStream();
  }

  @override
  Future<void> addEntry(Entry entry) async {
    await _entryAddingDataProvider.addEntry(entry);
  }
}
