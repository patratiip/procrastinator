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
  });
}
