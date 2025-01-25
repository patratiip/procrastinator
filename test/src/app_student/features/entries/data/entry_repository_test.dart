import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:procrastinator/src/app_student/features/entries/data/entry_repository.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry_model.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  late final MockIEntryDataProvider mockEntryDataProvider;
  late final EntryRepositoryImpl entryRepository;

  setUpAll(() {
    mockEntryDataProvider = MockIEntryDataProvider();
    entryRepository =
        EntryRepositoryImpl(entryDataProvider: mockEntryDataProvider);
  });

  group('EntryRepositoryImpl', () {
    test('entriesStream() converts EntryModel to Entry correctly', () {
      // Arrange
      final entryModel1 = EntryModel(
        visitID: '1',
        date: DateTime(2025, 1, 1),
        schoolVisit: true,
      );
      final entryModel2 = EntryModel(
        visitID: '2',
        date: DateTime(2025, 1, 2),
        homeOffice: true,
      );

      final entry1 = Entry.fromModel(entryModel1);
      final entry2 = Entry.fromModel(entryModel2);

      when(mockEntryDataProvider.entriesStream())
          .thenAnswer((_) => Stream.value([entryModel1, entryModel2]));

      // Act
      final stream = entryRepository.entriesStream();

      // Assert
      expectLater(
        stream,
        emitsInOrder([
          [entry1, entry2],
        ]),
      );
      verify(mockEntryDataProvider.entriesStream()).called(1);
    });

    test('addEntry() calls addEntry on the data provider with correct data',
        () async {
      // Arrange
      final entry = Entry(
        visitID: '1',
        date: DateTime(2025, 1, 1),
        entryType: EntryType.schoolVisit,
      );

      when(mockEntryDataProvider.addEntry(entry)).thenAnswer((_) async {});

      // Act
      await entryRepository.addEntry(entry);

      // Assert
      verify(mockEntryDataProvider.addEntry(entry)).called(1);
    });

    test('deleteEntry() calls deleteEntry on the data provider with correct ID',
        () async {
      // Arrange
      const entryId = '1';

      when(mockEntryDataProvider.deleteEntry(entryId)).thenAnswer((_) async {});

      // Act
      await entryRepository.deleteEntry(entryId);

      // Assert
      verify(mockEntryDataProvider.deleteEntry(entryId)).called(1);
    });
  });
}
