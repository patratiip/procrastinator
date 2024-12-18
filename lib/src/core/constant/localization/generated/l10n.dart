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

  /// `Today lection`
  String get todayLectionWidgetHeader {
    return Intl.message(
      'Today lection',
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

  /// `Next lections`
  String get lectionsListWidgetHeader {
    return Intl.message(
      'Next lections',
      name: 'lectionsListWidgetHeader',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOutButtonText {
    return Intl.message(
      'Log out',
      name: 'logOutButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get profileEdit {
    return Intl.message(
      'Edit profile',
      name: 'profileEdit',
      desc: '',
      args: [],
    );
  }

  /// `Sick list`
  String get sickList {
    return Intl.message(
      'Sick list',
      name: 'sickList',
      desc: '',
      args: [],
    );
  }

  /// `Loose report`
  String get looseReport {
    return Intl.message(
      'Loose report',
      name: 'looseReport',
      desc: '',
      args: [],
    );
  }

  /// `Bug Report`
  String get bugReport {
    return Intl.message(
      'Bug Report',
      name: 'bugReport',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get documents {
    return Intl.message(
      'Documents',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get contacts {
    return Intl.message(
      'Contacts',
      name: 'contacts',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `{userDisplayname} Entries`
  String userNameAndEntriesHeader(Object userDisplayname) {
    return Intl.message(
      '$userDisplayname Entries',
      name: 'userNameAndEntriesHeader',
      desc: '',
      args: [userDisplayname],
    );
  }

  /// `{schoolQty} days or`
  String statisticWidgetNDays(Object schoolQty) {
    return Intl.message(
      '$schoolQty days or',
      name: 'statisticWidgetNDays',
      desc: '',
      args: [schoolQty],
    );
  }

  /// `in School`
  String get inSchool {
    return Intl.message(
      'in School',
      name: 'inSchool',
      desc: '',
      args: [],
    );
  }

  /// `at Home`
  String get atHomeStatisticWidget {
    return Intl.message(
      'at Home',
      name: 'atHomeStatisticWidget',
      desc: '',
      args: [],
    );
  }

  /// `Totally {entiesQty} from {totalVisits} days`
  String totalEntiesTotalVisitsDaysStatisticWidget(
      Object entiesQty, Object totalVisits) {
    return Intl.message(
      'Totally $entiesQty from $totalVisits days',
      name: 'totalEntiesTotalVisitsDaysStatisticWidget',
      desc: '',
      args: [entiesQty, totalVisits],
    );
  }

  /// `Delete entry`
  String get deleteEntryDialogHeader {
    return Intl.message(
      'Delete entry',
      name: 'deleteEntryDialogHeader',
      desc: '',
      args: [],
    );
  }

  /// `Are you shure that you want to delete this entry?`
  String get deleteEntryShureTextDialog {
    return Intl.message(
      'Are you shure that you want to delete this entry?',
      name: 'deleteEntryShureTextDialog',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get noButtonText {
    return Intl.message(
      'No',
      name: 'noButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yesButtonText {
    return Intl.message(
      'Yes',
      name: 'yesButtonText',
      desc: '',
      args: [],
    );
  }

  /// `You have done everything!`
  String get allEntriesAddedSuccessMessage {
    return Intl.message(
      'You have done everything!',
      name: 'allEntriesAddedSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `Attention! Future`
  String get calendarStateErrorMessage_future {
    return Intl.message(
      'Attention! Future',
      name: 'calendarStateErrorMessage_future',
      desc: '',
      args: [],
    );
  }

  /// `You can only register at the school today`
  String get calendarStateErrorMessage_schoolTypeOnlyToday {
    return Intl.message(
      'You can only register at the school today',
      name: 'calendarStateErrorMessage_schoolTypeOnlyToday',
      desc: '',
      args: [],
    );
  }

  /// `Registration with this date already exists`
  String get calendarStateErrorMessage_thisDateExists {
    return Intl.message(
      'Registration with this date already exists',
      name: 'calendarStateErrorMessage_thisDateExists',
      desc: '',
      args: [],
    );
  }

  /// `No lections this day!`
  String get calendarStateErrorMessage_noLessonsToday {
    return Intl.message(
      'No lections this day!',
      name: 'calendarStateErrorMessage_noLessonsToday',
      desc: '',
      args: [],
    );
  }

  /// `You are not at school. Distance {distance} meters`
  String calendarStateErrorMessage_distanceToSchool(Object distance) {
    return Intl.message(
      'You are not at school. Distance $distance meters',
      name: 'calendarStateErrorMessage_distanceToSchool',
      desc: '',
      args: [distance],
    );
  }

  /// `Your user type is Undefined. Try logging out of the application and logging in again. If this does not work, please contact the IT department of Lutz&Grub Academy.`
  String get userTypeLoginError {
    return Intl.message(
      'Your user type is Undefined. Try logging out of the application and logging in again. If this does not work, please contact the IT department of Lutz&Grub Academy.',
      name: 'userTypeLoginError',
      desc: '',
      args: [],
    );
  }

  /// `Authentication error`
  String get authenticationUserTypeErrorScreeenText {
    return Intl.message(
      'Authentication error',
      name: 'authenticationUserTypeErrorScreeenText',
      desc: '',
      args: [],
    );
  }

  /// `Sick {entiesQty} from {possibleLooseDays} days`
  String sickDaysFromPossible(Object entiesQty, Object possibleLooseDays) {
    return Intl.message(
      'Sick $entiesQty from $possibleLooseDays days',
      name: 'sickDaysFromPossible',
      desc: '',
      args: [entiesQty, possibleLooseDays],
    );
  }

  /// `Loosed and sick {loosedQty} from {possibleLooseDays} days`
  String loosedFromPossibleDays(Object loosedQty, Object possibleLooseDays) {
    return Intl.message(
      'Loosed and sick $loosedQty from $possibleLooseDays days',
      name: 'loosedFromPossibleDays',
      desc: '',
      args: [loosedQty, possibleLooseDays],
    );
  }

  /// `You have no one entry added`
  String get youHaveNoOneEntryAdded {
    return Intl.message(
      'You have no one entry added',
      name: 'youHaveNoOneEntryAdded',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get groupText {
    return Intl.message(
      'Group',
      name: 'groupText',
      desc: '',
      args: [],
    );
  }

  /// `Select a user type`
  String get selectAUserTypeText {
    return Intl.message(
      'Select a user type',
      name: 'selectAUserTypeText',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get studentLabel {
    return Intl.message(
      'Student',
      name: 'studentLabel',
      desc: '',
      args: [],
    );
  }

  /// `Manager`
  String get managerLabel {
    return Intl.message(
      'Manager',
      name: 'managerLabel',
      desc: '',
      args: [],
    );
  }

  /// `Trainer`
  String get trainerLabel {
    return Intl.message(
      'Trainer',
      name: 'trainerLabel',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registrationButtonText {
    return Intl.message(
      'Register',
      name: 'registrationButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Choose the location of the school`
  String get schoolLocationDropDownText {
    return Intl.message(
      'Choose the location of the school',
      name: 'schoolLocationDropDownText',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboardAppBarText {
    return Intl.message(
      'Dashboard',
      name: 'dashboardAppBarText',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get usersAppBarText {
    return Intl.message(
      'Users',
      name: 'usersAppBarText',
      desc: '',
      args: [],
    );
  }

  /// `I forgot`
  String get calendarStateErrorMessage_buttonText_youAreForgot {
    return Intl.message(
      'I forgot',
      name: 'calendarStateErrorMessage_buttonText_youAreForgot',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsLabelText {
    return Intl.message(
      'Settings',
      name: 'settingsLabelText',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingsOptionLanguage {
    return Intl.message(
      'Language',
      name: 'settingsOptionLanguage',
      desc: '',
      args: [],
    );
  }

  /// `The screen does not exist. Please go back`
  String get navigationErrorScteenText {
    return Intl.message(
      'The screen does not exist. Please go back',
      name: 'navigationErrorScteenText',
      desc: '',
      args: [],
    );
  }

  /// `Page 404`
  String get page404Header {
    return Intl.message(
      'Page 404',
      name: 'page404Header',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get languagesEnglish {
    return Intl.message(
      'English',
      name: 'languagesEnglish',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get languagesGerman {
    return Intl.message(
      'German',
      name: 'languagesGerman',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get languagesRussian {
    return Intl.message(
      'Russian',
      name: 'languagesRussian',
      desc: '',
      args: [],
    );
  }

  /// `App theme`
  String get settingsOptionAppTheme {
    return Intl.message(
      'App theme',
      name: 'settingsOptionAppTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get appThemeTitleLight {
    return Intl.message(
      'Light',
      name: 'appThemeTitleLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get appThemeTitleDark {
    return Intl.message(
      'Dark',
      name: 'appThemeTitleDark',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get appThemeTitleDefault {
    return Intl.message(
      'Default',
      name: 'appThemeTitleDefault',
      desc: '',
      args: [],
    );
  }

  /// `Lection information`
  String get lectionInfoHeader {
    return Intl.message(
      'Lection information',
      name: 'lectionInfoHeader',
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
