import 'dart:async';
import 'package:entry_repository/entry_repository.dart';
import 'package:geolocation_repository/geolocation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lection_repository/lection_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  //
  final UserRepository _userRepository;
  //Entries Repo
  final EntryRepositoty _entriesRepository;
  late final StreamSubscription<List<Entry>?> _entrysListListener;
  //Lessons Repo
  final LectionRepository _lectionsRepository;
  late final StreamSubscription<List<Lection>?> _lectionListListener;
  final GeolocationRepository _geolocationRepository;

  // //Loosed Bloc
  // final LoosedEntrysBloc _loosedEntriesBloc;
  // late final StreamSubscription _loosedEntriesBlocStreamSubscription;

  CalendarBloc(
      {required UserRepository userRepository,
      required EntryRepositoty entriesRepository,
      required LectionRepository lectionsRepository,
      required GeolocationRepository geolocationRepository})
      : _userRepository = userRepository,
        _entriesRepository = entriesRepository,
        _lectionsRepository = lectionsRepository,
        _geolocationRepository = geolocationRepository,
        super(CalendarState(
          date: DateTime.now(),
          calendarFormat: CalendarFormat.week,
        )) {
    //
    //

    List<Entry> entriesListFromStream = [];
    List<Lection> lectionsListFromStream = [];

    //Subscription - Entries List from Repo
    _entrysListListener = _entriesRepository.getVisits().listen(
      (entriesList) {
        if (entriesList != null && entriesList.isNotEmpty) {
          entriesListFromStream = entriesList;
        }
        // print('Loosed Bloc Stram (Enrty): e: $entriesList, _l: $_lectionsList');
        // if (entriesList != null &&
        //     entriesList.isNotEmpty &&
        //     lectionsListFromStream.isNotEmpty) {
        //   add(ComairingLectionsAndVisitsEvent(
        //     lectionsListFromStream,
        //     entriesListFromStream,
        //   ));
        // }
      },
      onError: (error, stackTrace) {
        // Запись ошибки в лог
        print('Ошибка в потоке записей: $error');
        // Дополнительная информация об ошибке (например, стек вызовов)
        print('StackTrace: $stackTrace');

        // Дополнительные действия при ошибке (например, уведомление пользователя)
        // ...
      },
      cancelOnError: false,
    );

    //Subscription - Lessons Bloc
    _lectionListListener = _lectionsRepository.getLections().listen(
      (lectionsList) {
        if (lectionsList != null && lectionsList.isNotEmpty) {
          lectionsListFromStream = lectionsList;
        }
        // print( 'Loosed Bloc Stram (Lection): _e: $_entriesList, l: $lectionsList');
        // if (lectionsList != null &&
        //     lectionsList.isNotEmpty &&
        //     entriesListFromStream.isNotEmpty) {
        //   add(ComairingLectionsAndVisitsEvent(
        //     lectionsListFromStream,
        //     entriesListFromStream,
        //   ));
        // }
      },
      onError: (error, stackTrace) {
        // Запись ошибки в лог
        print('Ошибка в потоке записей: $error');
        // Дополнительная информация об ошибке (например, стек вызовов)
        print('StackTrace: $stackTrace');

        // Дополнительные действия при ошибке (например, уведомление пользователя)
        // ...
      },
      cancelOnError: false,
    );

    //Subscription - Loosed Bloc
    // _loosedEntriesBlocStreamSubscription = _loosedEntriesBloc.stream.listen(
    //   (state) {
    //     if (state is CopmaredAllClear) {
    //       // if (state.loosedLectionsList!.isEmpty) {
    //       add(CalendarNothingToAddEvent());
    //       // }
    //     } else if (state is ComaredEntrysState) {
    //       add(CalendarSomethingToAddEvent());
    //     }
    //   },
    //   cancelOnError: false,
    // );

    // ///Initialization
    // on<CalendarInitializationEvent>((event, emit) async {
    //   // await Future<void>.delayed(const Duration(seconds: 2));
    //   // emit(state.copyWith(
    //   //   status: 'Hast du alles geschaft!',
    //   // ));
    // });

    ///Nothing to add
    on<CalendarNothingToAddEvent>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 2));
      emit(state.copyWith(
        message: 'Hast du alles geschaft!',
        status: CalendarStateStatus.allDone,
      ));
    });

    // ///Something to add
    // on<CalendarSomethingToAddEvent>(
    //   (event, emit) async {
    //     await Future<void>.delayed(const Duration(seconds: 2));
    //     emit(state.copyWith(
    //       status: NewCalendarStateStatus.disabled,
    //     ));
    //   },
    //   transformer: sequential(),
    // );

    ///User changed calendar format
    on<CalendarFormatChanged>((event, emit) {
      emit(state.copyWith(calendarFormat: event.calendarFormat));
    });

    ///User changed date
    on<CalendarDateChanged>((event, emit) {
      emit(state.copyWith(isValid: true));

      final today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);

      final newDate =
          DateTime(event.date.year, event.date.month, event.date.day);

      emit(state.copyWith(date: newDate));

      //Future check
      if (newDate.isAfter(today)) {
        emit(state.copyWith(
          isValid: false,
          message: 'Achtung! Zukunft',
          status: CalendarStateStatus.error,
        ));
      }

      //School and Past check
      if (state.isValid &&
          state.type == 'Schule' &&
          !newDate.isAtSameMomentAs(today)) {
        emit(state.copyWith(
          isValid: false,
          message: 'In der Schule knnst du dich nur Heute anmelden',
          status: CalendarStateStatus.error,
        ));
      }

      //Entry exist check
      if (state.isValid && entriesListFromStream.isNotEmpty) {
        final entriesDateList = entriesListFromStream.map((entry) {
          return DateTime(
            entry.date.year,
            entry.date.month,
            entry.date.day,
          );
        }).toList();

        if (entriesDateList.contains(newDate)) {
          emit(state.copyWith(
            isValid: false,
            message: 'Anmeldung mit diese Datum schon exestiert',
            status: CalendarStateStatus.error,
          ));
        }
      }

      //Lection at that date exists check
      if (state.isValid && lectionsListFromStream.isNotEmpty) {
        final lectionsDateList = lectionsListFromStream.map((lection) {
          return DateTime(
            lection.date!.year,
            lection.date!.month,
            lection.date!.day,
          );
        }).toList();

        if (lectionsDateList.contains(newDate) == false) {
          emit(state.copyWith(
            isValid: false,
            message: 'Keine Unterrichten!',
            status: CalendarStateStatus.error,
          ));
        }
      }

      //Total Validation check
      if (state.isValid) {
        emit(state.copyWith(
            // date: newDate,
            status: state.type != null
                ? CalendarStateStatus.readyToAdding
                : CalendarStateStatus.hasDate));
      }
    });

    ///User changed type of entry
    on<CalendarTypeChanged>((event, emit) {
      emit(state.copyWith(isValid: true));
      final newType = event.type;
      emit(state.copyWith(type: newType));

      final today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      final stateDate =
          DateTime(state.date!.year, state.date!.month, state.date!.day);

      //Future check
      if (stateDate.isAfter(today)) {
        emit(state.copyWith(
          isValid: false,
          message: 'Achtung! Zukunft',
          status: CalendarStateStatus.error,
        ));
      }

      //School and Past check
      if (state.isValid &&
          newType == 'Schule' &&
          !stateDate.isAtSameMomentAs(today)) {
        emit(state.copyWith(
          isValid: false,
          message: 'In der Schule knnst du dich nur Heute anmelden',
          status: CalendarStateStatus.error,
        ));
      }

      //Entry exist check
      if (state.isValid && entriesListFromStream.isNotEmpty) {
        final entriesDateList = entriesListFromStream.map((entry) {
          return DateTime(
            entry.date.year,
            entry.date.month,
            entry.date.day,
          );
        }).toList();

        if (entriesDateList.contains(stateDate)) {
          emit(state.copyWith(
            isValid: false,
            message: 'Anmeldung mit diese Datum schon exestiert',
            status: CalendarStateStatus.error,
          ));
        }
      }

      //Lection at that date exists check
      if (state.isValid && lectionsListFromStream.isNotEmpty) {
        final lectionsDateList = lectionsListFromStream.map((lection) {
          return DateTime(
            lection.date!.year,
            lection.date!.month,
            lection.date!.day,
          );
        }).toList();

        if (lectionsDateList.contains(stateDate) == false) {
          emit(state.copyWith(
            isValid: false,
            message: 'Keine Unterrichten!',
            status: CalendarStateStatus.error,
          ));
        }
      }

      //Total Validation check
      if (state.isValid) {
        emit(state.copyWith(
            status: state.date != null
                ? CalendarStateStatus.readyToAdding
                : CalendarStateStatus.hasType));
      }
    });

    ///User submitted choise
    on<CalendarAddEntry>((event, emit) async {
      if (state.status == CalendarStateStatus.readyToAdding) {
        emit(state.copyWith(
          isValid: true,
          status: CalendarStateStatus.inProgress,
        ));

        final entryType = state.type;

        final entry = Entry(visitID: const Uuid().v4(), date: state.date!);

        bool typeDependIsOK = false;

        //School Geoposition Check
        if (entryType == 'Schule') {
          entry.schoolVisit = true;

          try {
            final user = await _userRepository.user.first;
            final schoolPosition = user!.schoolGeoPosition;
            print(schoolPosition);

            final userGeoPosition =
                await _geolocationRepository.determinePosition();
            print(userGeoPosition);

            final distanceToSchool = _geolocationRepository.distanceToSchool(
                userGeoposition: userGeoPosition,
                schoolLatitude: schoolPosition!.latitude,
                schoolLongtitude: schoolPosition.longitude);

            print('DISTANCE: $distanceToSchool');

            if (distanceToSchool <= 100) {
              typeDependIsOK = true;
            } else {
              emit(state.copyWith(
                isValid: false,
                message:
                    'Du bist nicht in der Schule. Distance ${distanceToSchool.toInt()} meters',
                status: CalendarStateStatus.error,
              ));
              typeDependIsOK = false;
            }
          } catch (e) {
            emit(state.copyWith(
                isValid: false,
                message: '$e',
                status: CalendarStateStatus.error));
            print(e);
            rethrow;
          }
        }

        if (entryType == 'Heim') {
          entry.homeOffice = true;
          typeDependIsOK = true;
        } else if (entryType == 'Krank') {
          entry.krank = true;
          typeDependIsOK = true;
        } else if (entryType == 'Fehl') {
          entry.fehl = true;
          typeDependIsOK = true;
        }

        // FINALLY ENTRY ADDING... or not :(

        if (typeDependIsOK) {
          entriesRepository.addEntry(entry);
          print('Calendar Bloc: Entry was added $entry');
        } else {}

        await Future<void>.delayed(const Duration(seconds: 1));
        emit(state.copyWith(
          status: CalendarStateStatus.succes,
        ));
      } else {}
    });
  }
  @override
  Future<void> close() {
    _entrysListListener.cancel();
    _lectionListListener.cancel();
    return super.close();
  }
}
