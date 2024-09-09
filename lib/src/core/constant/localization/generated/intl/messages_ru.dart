// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(schoolQty) => "${schoolQty} дней или";

  static String m1(entiesQty, totalVisits) =>
      "Всего ${entiesQty} из ${totalVisits} дней";

  static String m2(userDisplayname) => "Записи ${userDisplayname}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addEntryButtonText": MessageLookupByLibrary.simpleMessage("Добавить"),
        "anmeldungAppBarText":
            MessageLookupByLibrary.simpleMessage("Регистрация"),
        "anmeldungLogInScreenName":
            MessageLookupByLibrary.simpleMessage("Вход"),
        "atHomeStatisticWidget": MessageLookupByLibrary.simpleMessage("дома"),
        "bugReport": MessageLookupByLibrary.simpleMessage("Сообщить об ошибке"),
        "calendarFormatButton": MessageLookupByLibrary.simpleMessage("Месяц"),
        "calendarFormatButtonTwoWeeks":
            MessageLookupByLibrary.simpleMessage("2 Недели"),
        "calendarFormatButtonWeek":
            MessageLookupByLibrary.simpleMessage("Неделя"),
        "contacts": MessageLookupByLibrary.simpleMessage("Контакты"),
        "deleteEntryDialogHeader":
            MessageLookupByLibrary.simpleMessage("Удалить запись"),
        "deleteEntryShureTextDialog": MessageLookupByLibrary.simpleMessage(
            "Вы действительно хотите удалить эту запись?"),
        "documents": MessageLookupByLibrary.simpleMessage("Документы"),
        "emailTextFieldLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
        "entrySuccessfulAddedCalendarMessage":
            MessageLookupByLibrary.simpleMessage("Запись успешно добавлена!"),
        "entryTypeDropdownHintText":
            MessageLookupByLibrary.simpleMessage("Выберите тип записи..."),
        "forgotPassButtonName":
            MessageLookupByLibrary.simpleMessage("Забыли пароль?"),
        "homeEntryType": MessageLookupByLibrary.simpleMessage("Дом"),
        "inSchool": MessageLookupByLibrary.simpleMessage("в школе"),
        "lastFiveEntriesWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Пять последних записей"),
        "lectionsListWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Следующие лекции"),
        "lectionsPlanAppBarText":
            MessageLookupByLibrary.simpleMessage("План занятий"),
        "logInButtonName": MessageLookupByLibrary.simpleMessage("Войти"),
        "logOutButtonText": MessageLookupByLibrary.simpleMessage("Выйти"),
        "looseEntryType": MessageLookupByLibrary.simpleMessage("Пропуск"),
        "looseReport":
            MessageLookupByLibrary.simpleMessage("Уведомить о пропуске"),
        "loosedEntriesWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Пропущенные записи"),
        "name": MessageLookupByLibrary.simpleMessage("Имя"),
        "noButtonText": MessageLookupByLibrary.simpleMessage("Нет"),
        "noLessonsToday":
            MessageLookupByLibrary.simpleMessage("Сегодня нет лекций"),
        "passwordTextFieldLabel":
            MessageLookupByLibrary.simpleMessage("Пароль"),
        "profileAppBarText": MessageLookupByLibrary.simpleMessage("Профиль"),
        "profileEdit":
            MessageLookupByLibrary.simpleMessage("Редактировать профиль"),
        "schoolEntryType": MessageLookupByLibrary.simpleMessage("Школа"),
        "sickEntryType": MessageLookupByLibrary.simpleMessage("Болезнь"),
        "sickList": MessageLookupByLibrary.simpleMessage("Больничный"),
        "statisticWidgetNDays": m0,
        "statistikAppBarText":
            MessageLookupByLibrary.simpleMessage(" Статистика"),
        "todayLectionWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Сегодня"),
        "totalEntiesTotalVisitsDaysStatisticWidget": m1,
        "userNameAndEntriesHeader": m2,
        "yesButtonText": MessageLookupByLibrary.simpleMessage("Да")
      };
}
