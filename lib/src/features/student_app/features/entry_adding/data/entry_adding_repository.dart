import 'package:geolocator/geolocator.dart';
import 'package:procrastinator/src/features/student_app/features/entries/model/entry.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/data/entry_adding_firebase_data_provider.dart';
import 'package:procrastinator/src/features/student_app/features/entry_adding/data/entry_adding_geolocation_data_provider.dart';
import 'package:procrastinator/src/features/student_app/features/lection_plan/model/lection.dart';

/// Interface for [EntryAddingRepositoryImpl]
///
/// The repository that adding entries
abstract class IEntryAddingRepository {
  // Firebase Data Provider

  /// Getting lections stream
  Stream<List<Lection>> lectionsStream();

  /// Getting entries stream
  Stream<List<Entry>> entriesStream();

  /// Adding entry to entries collection
  Future<void> addEntry(Entry entry);

  // Gelocation Data Provider

  /// Determines actual user position
  Future<Position> determinePosition();

  /// Calculating distance from user to school
  double distanceToSchool(
      {required Position userGeoposition,
      required double schoolLatitude,
      required double schoolLongtitude});
}

/// {@template entry_adding_repository_impl}
/// Implementation of [IEntryAddingRepository].
/// {@endtemplate}
final class EntryAddingRepositoryImpl implements IEntryAddingRepository {
  final IEntryAddingFirebaseDataProvider _entryAddingFirebaseDataProvider;
  final IEntryAddingGeolocationDataProvider _entryAddingGeolocationDataProvider;

  /// {@macro entry_adding_repository_impl}
  EntryAddingRepositoryImpl({
    required IEntryAddingFirebaseDataProvider entryAddingFirebaseDataProvider,
    required IEntryAddingGeolocationDataProvider
        entryAddingGeolocationDataProvider,
  })  : _entryAddingFirebaseDataProvider = entryAddingFirebaseDataProvider,
        _entryAddingGeolocationDataProvider =
            entryAddingGeolocationDataProvider;

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

  @override
  Future<void> addEntry(Entry entry) async {
    await _entryAddingFirebaseDataProvider.addEntry(entry);
  }

  @override
  Future<Position> determinePosition() {
    return _entryAddingGeolocationDataProvider.determinePosition();
  }

  @override
  double distanceToSchool(
      {required Position userGeoposition,
      required double schoolLatitude,
      required double schoolLongtitude}) {
    return _entryAddingGeolocationDataProvider.distanceToSchool(
      userGeoposition: userGeoposition,
      schoolLatitude: schoolLatitude,
      schoolLongtitude: schoolLongtitude,
    );
  }
}
