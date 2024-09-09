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

  static String m0(schoolQty) => "${schoolQty} Tage oder";

  static String m1(entiesQty, totalVisits) =>
      "Insgesamt ${entiesQty} von ${totalVisits} Tage";

  static String m2(userDisplayname) => "${userDisplayname} Anmeldungen";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addEntryButtonText": MessageLookupByLibrary.simpleMessage("Anmelden"),
        "anmeldungAppBarText":
            MessageLookupByLibrary.simpleMessage("Anmeldung"),
        "anmeldungLogInScreenName":
            MessageLookupByLibrary.simpleMessage("Anmeldung"),
        "atHomeStatisticWidget":
            MessageLookupByLibrary.simpleMessage("Zuhause"),
        "bugReport": MessageLookupByLibrary.simpleMessage("Bug Report"),
        "calendarFormatButton": MessageLookupByLibrary.simpleMessage("Monat"),
        "calendarFormatButtonTwoWeeks":
            MessageLookupByLibrary.simpleMessage("2 Wochen"),
        "calendarFormatButtonWeek":
            MessageLookupByLibrary.simpleMessage("Woche"),
        "contacts": MessageLookupByLibrary.simpleMessage("Kontakten"),
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
        "homeEntryType": MessageLookupByLibrary.simpleMessage("Heim"),
        "inSchool": MessageLookupByLibrary.simpleMessage("im Schule"),
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
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "noButtonText": MessageLookupByLibrary.simpleMessage("No"),
        "noLessonsToday": MessageLookupByLibrary.simpleMessage(
            "Heute gibt es keine Unterrichten"),
        "passwordTextFieldLabel":
            MessageLookupByLibrary.simpleMessage("Kennwort"),
        "profileAppBarText": MessageLookupByLibrary.simpleMessage("Profil"),
        "profileEdit":
            MessageLookupByLibrary.simpleMessage("Profile bearbeiten"),
        "schoolEntryType": MessageLookupByLibrary.simpleMessage("Schule"),
        "sickEntryType": MessageLookupByLibrary.simpleMessage("Krank"),
        "sickList": MessageLookupByLibrary.simpleMessage("Krankmeldung"),
        "statisticWidgetNDays": m0,
        "statistikAppBarText":
            MessageLookupByLibrary.simpleMessage("Statistik"),
        "todayLectionWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Heutige Lektion"),
        "totalEntiesTotalVisitsDaysStatisticWidget": m1,
        "userNameAndEntriesHeader": m2,
        "yesButtonText": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
