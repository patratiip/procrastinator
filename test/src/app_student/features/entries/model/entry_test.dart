import 'package:flutter_test/flutter_test.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry_model.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';

void main() {
  group('Entry entity tests', () {
    test('toModel() correctly converts Entry to EntryModel', () {
      // Arrange
      final entry = Entry(
        visitID: '1',
        date: DateTime(2023, 1, 1),
        entryType: EntryType.schoolVisit,
      );

      // Act
      final model = entry.toModel();

      // Assert
      expect(model.visitID, '1');
      expect(model.date, DateTime(2023, 1, 1));
      expect(model.schoolVisit, true);
      expect(model.homeOffice, null);
      expect(model.sick, null);
      expect(model.loosed, null);
    });

    test('toModel() handles all entry types correctly', () {
      // Arrange
      final entryHomeOffice = Entry(
        visitID: '124',
        date: DateTime(2023, 1, 1),
        entryType: EntryType.homeOffice,
      );
      final entrySick = Entry(
        visitID: '125',
        date: DateTime(2023, 1, 1),
        entryType: EntryType.sick,
      );
      final entryLoosed = Entry(
        visitID: '126',
        date: DateTime(2023, 1, 1),
        entryType: EntryType.loosed,
      );

      // Act
      final entryModelHomeOffice = entryHomeOffice.toModel();
      final entryModelSick = entrySick.toModel();
      final entryModelLoosed = entryLoosed.toModel();

      // Assert
      expect(entryModelHomeOffice.homeOffice, isTrue);
      expect(entryModelSick.sick, isTrue);
      expect(entryModelLoosed.loosed, isTrue);
    });

    test('fromModel() correctly converts EntryModel to Entry', () {
      // Arrange
      final model = EntryModel(
        visitID: '456',
        date: DateTime(2023, 2, 2),
        schoolVisit: true,
      );

      // Act
      final entry = Entry.fromModel(model);

      // Assert
      expect(entry.visitID, '456');
      expect(entry.date, DateTime(2023, 2, 2));
      expect(entry.entryType, EntryType.schoolVisit);
    });

    test('fromModel() handles all entry types correctly', () {
      // Arrange
      final modelHomeOffice = EntryModel(
        visitID: '100',
        date: DateTime(2023, 3, 3),
        homeOffice: true,
      );

      final modelSick = EntryModel(
        visitID: '101',
        date: DateTime(2023, 4, 4),
        sick: true,
      );

      final modelLoosed = EntryModel(
        visitID: '102',
        date: DateTime(2023, 5, 5),
        loosed: true,
      );

      // Act
      final entryHomeOffice = Entry.fromModel(modelHomeOffice);
      final entrySick = Entry.fromModel(modelSick);
      final entryLoosed = Entry.fromModel(modelLoosed);

      // Assert
      expect(entryHomeOffice.entryType, EntryType.homeOffice);
      expect(entrySick.entryType, EntryType.sick);
      expect(entryLoosed.entryType, EntryType.loosed);
    });

    test('copyWith() creates a new instance with updated fields', () {
      // Arrange
      final entry = Entry(
        visitID: '123',
        date: DateTime(2023, 6, 6),
        entryType: EntryType.sick,
      );

      // Act
      final updatedEntry = entry.copyWith(
        date: DateTime(2023, 7, 7),
        entryType: EntryType.loosed,
      );

      // Assert
      expect(updatedEntry.visitID, '123');
      expect(updatedEntry.date, DateTime(2023, 7, 7));
      expect(updatedEntry.entryType, EntryType.loosed);
    });
  });
}
