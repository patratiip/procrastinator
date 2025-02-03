import 'package:flutter_test/flutter_test.dart';
import 'package:procrastinator/src/app_student/features/entries/bloc/last_entries_list_bloc/last_entries_list_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:procrastinator/src/app_student/features/entries/model/entry.dart';

import '../mocks/mocks.mocks.dart';

void main() {
  // late MockEntryRepository mockEntryRepository;
  // late EntriesListBloc bloc;

  // setUp(() {
  //   mockEntryRepository = MockEntryRepository();

  //   bloc = EntriesListBloc(entrysRepository: mockEntryRepository);
  // });

  // tearDown(() async {
  //   await bloc.close();
  // });

  group('EntriesListBloc', () {
    // test('Initial state is IdleLastEntriesListState', () {
    //   expect(bloc.state, const LastEntriesListState.idle(entriesList: []));
    // });

    test('emits LoadedLastEntriesListState when entries stream updates',
        () async {
      final mockEntryRepository = MockIEntryRepository();

      // Arrange
      final mockEntries = [
        Entry(
          visitID: '1',
          date: DateTime(2024, 11, 2),
          entryType: EntryType.homeOffice,
        ),
        Entry(
          visitID: '2',
          date: DateTime(2024, 11, 1),
          entryType: EntryType.sick,
        ),
      ];

      // Preparing repository answer
      when(mockEntryRepository.entriesStream())
          .thenAnswer((_) => Stream.value(mockEntries));

      // Act
      final bloc = EntriesListBloc(entrysRepository: mockEntryRepository);

      // Assert
      expectLater(
        bloc.stream,
        emitsInOrder([
          isA<LastEntriesListState>().having((state) => state, 'state is Idle',
              const LastEntriesListState.loading(entriesList: [])),
          isA<LastEntriesListState>().having(
              (state) => state,
              'state is Loaded',
              LastEntriesListState.loading(entriesList: mockEntries)),
          // .having((state) => state.entriesList, 'entriesList', mockEntries),
          isA<LastEntriesListState>().having((state) => state, 'state is Idle',
              LastEntriesListState.loading(entriesList: mockEntries)),
        ]),
      );

      // bloc.close();
    });

    // test('emits ErrorLastEntriesListState when entries stream throws an error',
    //     () async {
    //   // Arrange
    //   final exception = Exception('Test Error');
    //   when(mockEntryRepository.entriesStream())
    //       .thenAnswer((_) => Stream.error(exception));

    //   // Act
    //   bloc = EntriesListBloc(entrysRepository: mockEntryRepository);

    //   // Assert
    //   expectLater(
    //     bloc.stream,
    //     emitsInOrder([
    //       isA<LastEntriesListState>()
    //           .having((state) => state.isIdle, 'state is Idle', true),
    //       isA<LastEntriesListState>()
    //           .having((state) => state.isError, 'state is Error', true),
    //     ]),
    //   );
    // });

    // test('handles EntriesListEventDelete correctly', () async {
    //   // Arrange
    //   const entryId = '1';
    //   when(mockEntryRepository.deleteEntry(entryId)).thenAnswer((_) async {});

    //   // Act
    //   bloc.add(const EntriesListEvent.deleteEntry(entryRef: entryId));

    //   // Assert
    //   expectLater(
    //     bloc.stream,
    //     emitsInOrder([
    //       isA<LastEntriesListState>()
    //           .having((state) => state.loading, 'state is Idle', true),
    //       isA<LastEntriesListState>()
    //           .having((state) => state.isIdle, 'state is Idle', true),
    //     ]),
    //   );
    //   verify(mockEntryRepository.deleteEntry(entryId)).called(1);
    // });
  });
}
