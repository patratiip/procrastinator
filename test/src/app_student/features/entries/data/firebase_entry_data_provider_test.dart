import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:procrastinator/src/app_student/features/entries/data/firebase_entry_data_provider.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry_model.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  group('EntryFirebaseDataProviderImpl', () {
    late MockCollectionReference<Map<String, dynamic>> mockCollectionRef;
    late MockDocumentReference<Map<String, dynamic>> mockDocumentRef;
    late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
    late MockQueryDocumentSnapshot<Map<String, dynamic>>
        mockQueryDocumentSnapshot;
    late EntryFirebaseDataProviderImpl dataProvider;

    setUp(() {
      mockCollectionRef = MockCollectionReference<Map<String, dynamic>>();
      mockDocumentRef = MockDocumentReference<Map<String, dynamic>>();
      mockQuerySnapshot = MockQuerySnapshot<Map<String, dynamic>>();
      mockQueryDocumentSnapshot =
          MockQueryDocumentSnapshot<Map<String, dynamic>>();
      dataProvider =
          EntryFirebaseDataProviderImpl(collectionRef: mockCollectionRef);
    });

    test('entriesStream returns a stream of EntryModel list', () async {
      // Arrange
      final mockData = {
        'visitID': '123',
        'date': Timestamp.fromDate(DateTime(2025, 1, 1)),
        'schoolVisit': true,
      };

      when(mockCollectionRef.orderBy('date', descending: true))
          .thenReturn(mockCollectionRef);

      when(mockCollectionRef.snapshots())
          .thenAnswer((_) => Stream.value(mockQuerySnapshot));

      when(mockQuerySnapshot.docs).thenReturn([mockQueryDocumentSnapshot]);

      when(mockQueryDocumentSnapshot.data()).thenReturn(mockData);

      // Act
      final stream = dataProvider.entriesStream();

      // Assert
      await expectLater(
        stream,
        emits([
          EntryModel(
            visitID: '123',
            date: DateTime(2025, 1, 1),
            schoolVisit: true,
          ),
        ]),
      );

      verify(mockCollectionRef.orderBy('date', descending: true)).called(1);
      verify(mockCollectionRef.snapshots()).called(1);
    });

    test('addEntry calls set on the correct document with the correct data',
        () async {
      // Arrange
      final entry = Entry(
        visitID: '123',
        date: DateTime(2025, 1, 1),
        entryType: EntryType.schoolVisit,
      );

      final entryModel = entry.toModel();
      final entryData = entryModel.toFirestore();

      when(mockCollectionRef.doc('123')).thenReturn(mockDocumentRef);
      when(mockDocumentRef.set(entryData)).thenAnswer((_) async {});

      // Act
      await dataProvider.addEntry(entry);

      // Assert
      verify(mockCollectionRef.doc('123')).called(1);
      verify(mockDocumentRef.set(entryData)).called(1);
    });

    test('deleteEntry calls delete on the correct document', () async {
      // Arrange
      when(mockCollectionRef.doc('123')).thenReturn(mockDocumentRef);
      when(mockDocumentRef.delete()).thenAnswer((_) async {});

      // Act
      await dataProvider.deleteEntry('123');

      // Assert
      verify(mockCollectionRef.doc('123')).called(1);
      verify(mockDocumentRef.delete()).called(1);
    });
  });
}
