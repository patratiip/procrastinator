// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de_DE locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'de_DE';

  static String m0(distance) =>
      "Du bist nicht in der Schule. Distance ${distance} meters";

  static String m1(loosedQty, possibleLooseDays) =>
      "Fehl und Krank ${loosedQty} von ${possibleLooseDays} Tage";

  static String m2(entiesQty, possibleLooseDays) =>
      "Krank ${entiesQty} von ${possibleLooseDays} Tage";

  static String m3(schoolQty) => "${schoolQty} Tage oder";

  static String m4(entiesQty, totalVisits) =>
      "Insgesamt ${entiesQty} von ${totalVisits} Tage";

  static String m5(userDisplayname) => "${userDisplayname} Anmeldungen";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addEntryButtonText": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "allEntriesAddedSuccessMessage":
            MessageLookupByLibrary.simpleMessage("Hast du alles geschaft!"),
        "anmeldungAppBarText":
            MessageLookupByLibrary.simpleMessage("Anmeldung"),
        "anmeldungLogInScreenName":
            MessageLookupByLibrary.simpleMessage("Anmeldung"),
        "appThemeTitleDark": MessageLookupByLibrary.simpleMessage("Dunkel"),
        "appThemeTitleDefault":
            MessageLookupByLibrary.simpleMessage("Automatisch"),
        "appThemeTitleLight": MessageLookupByLibrary.simpleMessage("Licht"),
        "atHomeStatisticWidget":
            MessageLookupByLibrary.simpleMessage("Zuhause"),
        "authenticationUserTypeErrorScreeenText":
            MessageLookupByLibrary.simpleMessage("Authentifizierungsfehler"),
        "bugReport": MessageLookupByLibrary.simpleMessage("Bug Report"),
        "calendarFormatButton": MessageLookupByLibrary.simpleMessage("Monat"),
        "calendarFormatButtonTwoWeeks":
            MessageLookupByLibrary.simpleMessage("2 Wochen"),
        "calendarFormatButtonWeek":
            MessageLookupByLibrary.simpleMessage("Woche"),
        "calendarStateErrorMessage_buttonText_youAreForgot":
            MessageLookupByLibrary.simpleMessage("Hast du vergessen?"),
        "calendarStateErrorMessage_distanceToSchool": m0,
        "calendarStateErrorMessage_future":
            MessageLookupByLibrary.simpleMessage("Achtung! Zukunft"),
        "calendarStateErrorMessage_noLessonsToday":
            MessageLookupByLibrary.simpleMessage("Keine Unterrichten!"),
        "calendarStateErrorMessage_schoolTypeOnlyToday":
            MessageLookupByLibrary.simpleMessage(
                "In der Schule knnst du dich nur Heute anmelden"),
        "calendarStateErrorMessage_thisDateExists":
            MessageLookupByLibrary.simpleMessage(
                "Anmeldung mit diese Datum schon exestiert"),
        "contacts": MessageLookupByLibrary.simpleMessage("Kontakten"),
        "dashboardAppBarText":
            MessageLookupByLibrary.simpleMessage("Dashboard"),
        "deleteEntryDialogHeader":
            MessageLookupByLibrary.simpleMessage("Anmeldung löschen"),
        "deleteEntryShureTextDialog": MessageLookupByLibrary.simpleMessage(
            "Möchtest du echt diese Anmeldung löschen?"),
        "documents": MessageLookupByLibrary.simpleMessage("Unterlagen"),
        "emailTextFieldLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
        "entrySuccessfulAddedCalendarMessage":
            MessageLookupByLibrary.simpleMessage(
                "Eintrag erfolgreich hinzugefügt!"),
        "entryTypeDropdownHintText":
            MessageLookupByLibrary.simpleMessage("Anmeldentyp wahlen..."),
        "forgotPassButtonName":
            MessageLookupByLibrary.simpleMessage("Kennwort vergessen?"),
        "groupText": MessageLookupByLibrary.simpleMessage("Gruppe"),
        "homeEntryType": MessageLookupByLibrary.simpleMessage("Heim"),
        "inSchool": MessageLookupByLibrary.simpleMessage("im Schule"),
        "languagesEnglish": MessageLookupByLibrary.simpleMessage("Englisch"),
        "languagesGerman": MessageLookupByLibrary.simpleMessage("Deutsch"),
        "languagesRussian": MessageLookupByLibrary.simpleMessage("Russisch"),
        "lastFiveEntriesWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Letzte 5 Anmeldungen"),
        "lectionsListWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Nächste"),
        "lectionsPlanAppBarText":
            MessageLookupByLibrary.simpleMessage("Kursplan"),
        "logInButtonName": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "logOutButtonText": MessageLookupByLibrary.simpleMessage("Abmelden"),
        "looseEntryType": MessageLookupByLibrary.simpleMessage("Fehl"),
        "looseReport": MessageLookupByLibrary.simpleMessage("Fehlmeldung"),
        "loosedEntriesWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Fehlende Anmeldungen"),
        "loosedFromPossibleDays": m1,
        "managerLabel": MessageLookupByLibrary.simpleMessage("Manager"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "navigationErrorScteenText": MessageLookupByLibrary.simpleMessage(
            "Der Bildschirm existiert nicht. Bitte zurückgehen"),
        "noButtonText": MessageLookupByLibrary.simpleMessage("No"),
        "noLessonsToday": MessageLookupByLibrary.simpleMessage(
            "Heute gibt es keine Unterrichten"),
        "page404Header": MessageLookupByLibrary.simpleMessage("Seite 404"),
        "passwordTextFieldLabel":
            MessageLookupByLibrary.simpleMessage("Kennwort"),
        "profileAppBarText": MessageLookupByLibrary.simpleMessage("Profil"),
        "profileEdit":
            MessageLookupByLibrary.simpleMessage("Profile bearbeiten"),
        "registrationButtonText":
            MessageLookupByLibrary.simpleMessage("Registrieren"),
        "schoolEntryType": MessageLookupByLibrary.simpleMessage("Schule"),
        "schoolLocationDropDownText": MessageLookupByLibrary.simpleMessage(
            "Wählen Sie den Standort der Schule"),
        "selectAUserTypeText":
            MessageLookupByLibrary.simpleMessage("Wählen Sie den Benutzertyp"),
        "settingsLabelText":
            MessageLookupByLibrary.simpleMessage("Einstellungen"),
        "settingsOptionAppTheme":
            MessageLookupByLibrary.simpleMessage("App Thema"),
        "settingsOptionLanguage":
            MessageLookupByLibrary.simpleMessage("Sprache"),
        "sickDaysFromPossible": m2,
        "sickEntryType": MessageLookupByLibrary.simpleMessage("Krank"),
        "sickList": MessageLookupByLibrary.simpleMessage("Krankmeldung"),
        "statisticWidgetNDays": m3,
        "statistikAppBarText":
            MessageLookupByLibrary.simpleMessage("Statistik"),
        "studentLabel": MessageLookupByLibrary.simpleMessage("Student"),
        "todayLectionWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Heutige Lektion"),
        "totalEntiesTotalVisitsDaysStatisticWidget": m4,
        "trainerLabel": MessageLookupByLibrary.simpleMessage("Trainer"),
        "userNameAndEntriesHeader": m5,
        "userTypeLoginError": MessageLookupByLibrary.simpleMessage(
            "Ihr Benutzertyp ist Undefiniert. Versuchen Sie, sich von der Anwendung abzumelden und erneut anzumelden. Sollte dies nicht funktionieren, wenden Sie sich bitte an die IT-Abteilung der Lutz&Grub Academy."),
        "usersAppBarText": MessageLookupByLibrary.simpleMessage("Benutzer"),
        "yesButtonText": MessageLookupByLibrary.simpleMessage("Yes"),
        "youHaveNoOneEntryAdded": MessageLookupByLibrary.simpleMessage(
            "Sie haben keinen einzigen Eintrag hinzugefügt")
      };
}
