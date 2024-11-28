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

  static String m0(distance) =>
      "You are not at school. Distance ${distance} meters";

  static String m1(loosedQty, possibleLooseDays) =>
      "Loosed and sick ${loosedQty} from ${possibleLooseDays} days";

  static String m2(entiesQty, possibleLooseDays) =>
      "Sick ${entiesQty} from ${possibleLooseDays} days";

  static String m3(schoolQty) => "${schoolQty} days or";

  static String m4(entiesQty, totalVisits) =>
      "Totally ${entiesQty} from ${totalVisits} days";

  static String m5(userDisplayname) => "${userDisplayname} Entries";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addEntryButtonText": MessageLookupByLibrary.simpleMessage("Add entry"),
        "allEntriesAddedSuccessMessage":
            MessageLookupByLibrary.simpleMessage("You have done everything!"),
        "anmeldungAppBarText": MessageLookupByLibrary.simpleMessage("Main"),
        "anmeldungLogInScreenName":
            MessageLookupByLibrary.simpleMessage("Login"),
        "atHomeStatisticWidget":
            MessageLookupByLibrary.simpleMessage("at Home"),
        "authenticationUserTypeErrorScreeenText":
            MessageLookupByLibrary.simpleMessage("Authentication error"),
        "bugReport": MessageLookupByLibrary.simpleMessage("Bug Report"),
        "calendarFormatButton": MessageLookupByLibrary.simpleMessage("Month"),
        "calendarFormatButtonTwoWeeks":
            MessageLookupByLibrary.simpleMessage("2 Weeks"),
        "calendarFormatButtonWeek":
            MessageLookupByLibrary.simpleMessage("Week"),
        "calendarStateErrorMessage_buttonText_youAreForgot":
            MessageLookupByLibrary.simpleMessage("Forgot to add an entry?"),
        "calendarStateErrorMessage_distanceToSchool": m0,
        "calendarStateErrorMessage_future":
            MessageLookupByLibrary.simpleMessage("Attention! Future"),
        "calendarStateErrorMessage_noLessonsToday":
            MessageLookupByLibrary.simpleMessage("No lections this day!"),
        "calendarStateErrorMessage_schoolTypeOnlyToday":
            MessageLookupByLibrary.simpleMessage(
                "You can only register at the school today"),
        "calendarStateErrorMessage_thisDateExists":
            MessageLookupByLibrary.simpleMessage(
                "Registration with this date already exists"),
        "contacts": MessageLookupByLibrary.simpleMessage("Contacts"),
        "dashboardAppBarText":
            MessageLookupByLibrary.simpleMessage("Dashboard"),
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
        "groupText": MessageLookupByLibrary.simpleMessage("Group"),
        "homeEntryType": MessageLookupByLibrary.simpleMessage("Home"),
        "inSchool": MessageLookupByLibrary.simpleMessage("in School"),
        "languagesEnglish": MessageLookupByLibrary.simpleMessage("English"),
        "languagesGerman": MessageLookupByLibrary.simpleMessage("German"),
        "languagesRussian": MessageLookupByLibrary.simpleMessage("Russian"),
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
        "loosedFromPossibleDays": m1,
        "managerLabel": MessageLookupByLibrary.simpleMessage("Manager"),
        "name": MessageLookupByLibrary.simpleMessage("Name"),
        "navigationErrorScteenText": MessageLookupByLibrary.simpleMessage(
            "The screen does not exist. Please go back"),
        "noButtonText": MessageLookupByLibrary.simpleMessage("No"),
        "noLessonsToday":
            MessageLookupByLibrary.simpleMessage("No lections found today"),
        "page404Header": MessageLookupByLibrary.simpleMessage("Page 404"),
        "passwordTextFieldLabel":
            MessageLookupByLibrary.simpleMessage("Password"),
        "profileAppBarText": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileEdit": MessageLookupByLibrary.simpleMessage("Edit profile"),
        "registrationButtonText":
            MessageLookupByLibrary.simpleMessage("Register"),
        "schoolEntryType": MessageLookupByLibrary.simpleMessage("School"),
        "schoolLocationDropDownText": MessageLookupByLibrary.simpleMessage(
            "Choose the location of the school"),
        "selectAUserTypeText":
            MessageLookupByLibrary.simpleMessage("Select a user type"),
        "settingsLabelText": MessageLookupByLibrary.simpleMessage("Settings"),
        "settingsOptionLanguage":
            MessageLookupByLibrary.simpleMessage("Language"),
        "sickDaysFromPossible": m2,
        "sickEntryType": MessageLookupByLibrary.simpleMessage("Sick"),
        "sickList": MessageLookupByLibrary.simpleMessage("Sick list"),
        "statisticWidgetNDays": m3,
        "statistikAppBarText":
            MessageLookupByLibrary.simpleMessage("Statistiс"),
        "studentLabel": MessageLookupByLibrary.simpleMessage("Student"),
        "todayLectionWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Today lection"),
        "totalEntiesTotalVisitsDaysStatisticWidget": m4,
        "trainerLabel": MessageLookupByLibrary.simpleMessage("Trainer"),
        "userNameAndEntriesHeader": m5,
        "userTypeLoginError": MessageLookupByLibrary.simpleMessage(
            "Your user type is Undefined. Try logging out of the application and logging in again. If this does not work, please contact the IT department of Lutz&Grub Academy."),
        "usersAppBarText": MessageLookupByLibrary.simpleMessage("Users"),
        "yesButtonText": MessageLookupByLibrary.simpleMessage("Yes"),
        "youHaveNoOneEntryAdded":
            MessageLookupByLibrary.simpleMessage("You have no one entry added")
      };
}
