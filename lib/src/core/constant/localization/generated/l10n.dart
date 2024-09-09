// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Localization {
  Localization();

  static Localization? _current;

  static Localization get current {
    assert(_current != null,
        'No instance of Localization was loaded. Try to initialize the Localization delegate before accessing Localization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Localization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Localization();
      Localization._current = instance;

      return instance;
    });
  }

  static Localization of(BuildContext context) {
    final instance = Localization.maybeOf(context);
    assert(instance != null,
        'No instance of Localization present in the widget tree. Did you add Localization.delegate in localizationsDelegates?');
    return instance!;
  }

  static Localization? maybeOf(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  /// `Login`
  String get anmeldungLogInScreenName {
    return Intl.message(
      'Login',
      name: 'anmeldungLogInScreenName',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get emailTextFieldLabel {
    return Intl.message(
      'E-mail',
      name: 'emailTextFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordTextFieldLabel {
    return Intl.message(
      'Password',
      name: 'passwordTextFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get logInButtonName {
    return Intl.message(
      'Login',
      name: 'logInButtonName',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassButtonName {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassButtonName',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get anmeldungAppBarText {
    return Intl.message(
      'Main',
      name: 'anmeldungAppBarText',
      desc: '',
      args: [],
    );
  }

  /// `Statistiс`
  String get statistikAppBarText {
    return Intl.message(
      'Statistiс',
      name: 'statistikAppBarText',
      desc: '',
      args: [],
    );
  }

  /// `Lections plan`
  String get lectionsPlanAppBarText {
    return Intl.message(
      'Lections plan',
      name: 'lectionsPlanAppBarText',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileAppBarText {
    return Intl.message(
      'Profile',
      name: 'profileAppBarText',
      desc: '',
      args: [],
    );
  }

  /// `Entry was added successfully!`
  String get entrySuccessfulAddedCalendarMessage {
    return Intl.message(
      'Entry was added successfully!',
      name: 'entrySuccessfulAddedCalendarMessage',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get calendarFormatButton {
    return Intl.message(
      'Month',
      name: 'calendarFormatButton',
      desc: '',
      args: [],
    );
  }

  /// `2 Weeks`
  String get calendarFormatButtonTwoWeeks {
    return Intl.message(
      '2 Weeks',
      name: 'calendarFormatButtonTwoWeeks',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get calendarFormatButtonWeek {
    return Intl.message(
      'Week',
      name: 'calendarFormatButtonWeek',
      desc: '',
      args: [],
    );
  }

  /// `Choose entry type...`
  String get entryTypeDropdownHintText {
    return Intl.message(
      'Choose entry type...',
      name: 'entryTypeDropdownHintText',
      desc: '',
      args: [],
    );
  }

  /// `School`
  String get schoolEntryType {
    return Intl.message(
      'School',
      name: 'schoolEntryType',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeEntryType {
    return Intl.message(
      'Home',
      name: 'homeEntryType',
      desc: '',
      args: [],
    );
  }

  /// `Sick`
  String get sickEntryType {
    return Intl.message(
      'Sick',
      name: 'sickEntryType',
      desc: '',
      args: [],
    );
  }

  /// `Loose`
  String get looseEntryType {
    return Intl.message(
      'Loose',
      name: 'looseEntryType',
      desc: '',
      args: [],
    );
  }

  /// `Add entry`
  String get addEntryButtonText {
    return Intl.message(
      'Add entry',
      name: 'addEntryButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Last 5 Entries`
  String get lastFiveEntriesWidgetHeader {
    return Intl.message(
      'Last 5 Entries',
      name: 'lastFiveEntriesWidgetHeader',
      desc: '',
      args: [],
    );
  }

  /// `Loosed entries`
  String get loosedEntriesWidgetHeader {
    return Intl.message(
      'Loosed entries',
      name: 'loosedEntriesWidgetHeader',
      desc: '',
      args: [],
    );
  }

  /// `Today's lection`
  String get todayLectionWidgetHeader {
    return Intl.message(
      'Today\'s lection',
      name: 'todayLectionWidgetHeader',
      desc: '',
      args: [],
    );
  }

  /// `No lections found today`
  String get noLessonsToday {
    return Intl.message(
      'No lections found today',
      name: 'noLessonsToday',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de', countryCode: 'DE'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Localization> load(Locale locale) => Localization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
