import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry_model.dart';

void main() {
  group('EntryModel', () {
    test('toFirestore() successfully convrets EntryModel to json', () {
      // Arrange
      final entryModel = EntryModel(
        visitID: '123',
        date: DateTime(2020, 4, 1),
        schoolVisit: true,
      );

      // Act
      final docForFirestore = entryModel.toFirestore();

      // Assert
      expect(docForFirestore['visitID'], '123');
      expect((docForFirestore['date'] as Timestamp).toDate(),
          DateTime(2020, 4, 1));
      expect(docForFirestore['schoolVisit'], isTrue);
      expect(docForFirestore['homeOffice'], isNull);
      expect(docForFirestore['Krank'], isNull);
      expect(docForFirestore['Fehl'], isNull);
    });

    test('fromFirestore() successfully converts json to EntryModel', () {
      // Arrange
      final jsonFromFirestore = {
        'visitID': '123',
        'date': Timestamp.fromDate(DateTime(2022, 1, 10)),
        'schoolVisit': true,
      };

      // Act
      final entryModel = EntryModel.fromFirestore(jsonFromFirestore);

      // Assert
      expect(entryModel.visitID, '123');
      expect(entryModel.date, DateTime(2022, 1, 10));
      expect(entryModel.schoolVisit, isTrue);
      expect(entryModel.homeOffice, isNull);
      expect(entryModel.sick, isNull);
      expect(entryModel.loosed, isNull);
    });
  });
}
