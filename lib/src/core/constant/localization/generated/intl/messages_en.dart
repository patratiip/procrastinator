// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(schoolQty) => "${schoolQty} days or";

  static String m1(entiesQty, totalVisits) =>
      "Totally ${entiesQty} from ${totalVisits} days";

  static String m2(userDisplayname) => "${userDisplayname} Entries";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addEntryButtonText": MessageLookupByLibrary.simpleMessage("Add entry"),
        "anmeldungAppBarText": MessageLookupByLibrary.simpleMessage("Main"),
        "anmeldungLogInScreenName":
            MessageLookupByLibrary.simpleMessage("Login"),
        "atHomeStatisticWidget":
            MessageLookupByLibrary.simpleMessage("at Home"),
        "bugReport": MessageLookupByLibrary.simpleMessage("Bug Report"),
        "calendarFormatButton": MessageLookupByLibrary.simpleMessage("Month"),
        "calendarFormatButtonTwoWeeks":
            MessageLookupByLibrary.simpleMessage("2 Weeks"),
        "calendarFormatButtonWeek":
            MessageLookupByLibrary.simpleMessage("Week"),
        "contacts": MessageLookupByLibrary.simpleMessage("Contacts"),
        "deleteEntryDialogHeader":
            MessageLookupByLibrary.simpleMessage("Delete entry"),
        "deleteEntryShureTextDialog": MessageLookupByLibrary.simpleMessage(
            "Are you shure that you want to delete this entry?"),
        "documents": MessageLookupByLibrary.simpleMessage("Documents"),
        "emailTextFieldLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
        "entrySuccessfulAddedCalendarMessage":
            MessageLookupByLibrary.simpleMessage(
                "Entry was added successfully!"),
        "entryTypeDropdownHintText":
            MessageLookupByLibrary.simpleMessage("Choose entry type..."),
        "forgotPassButtonName":
            MessageLookupByLibrary.simpleMessage("Forgot password?"),
        "homeEntryType": MessageLookupByLibrary.simpleMessage("Home"),
        "inSchool": MessageLookupByLibrary.simpleMessage("in School"),
        "lastFiveEntriesWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Last 5 Entries"),
        "lectionsListWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Next lections"),
        "lectionsPlanAppBarText":
            MessageLookupByLibrary.simpleMessage("Lections plan"),
        "logInButtonName": MessageLookupByLibrary.simpleMessage("Login"),
        "logOutButtonText": MessageLookupByLibrary.simpleMessage("Log out"),
        "looseEntryType": MessageLookupByLibrary.simpleMessage("Loose"),
        "looseReport": MessageLookupByLibrary.simpleMessage("Loose report"),
        "loosedEntriesWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Loosed entries"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "noButtonText": MessageLookupByLibrary.simpleMessage("No"),
        "noLessonsToday":
            MessageLookupByLibrary.simpleMessage("No lections found today"),
        "passwordTextFieldLabel":
            MessageLookupByLibrary.simpleMessage("Password"),
        "profileAppBarText": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileEdit": MessageLookupByLibrary.simpleMessage("Edit progile"),
        "schoolEntryType": MessageLookupByLibrary.simpleMessage("School"),
        "sickEntryType": MessageLookupByLibrary.simpleMessage("Sick"),
        "sickList": MessageLookupByLibrary.simpleMessage("Sick list"),
        "statisticWidgetNDays": m0,
        "statistikAppBarText":
            MessageLookupByLibrary.simpleMessage("Statistiс"),
        "todayLectionWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Today\'s lection"),
        "totalEntiesTotalVisitsDaysStatisticWidget": m1,
        "userNameAndEntriesHeader": m2,
        "yesButtonText": MessageLookupByLibrary.simpleMessage("Yes")
      };
}
