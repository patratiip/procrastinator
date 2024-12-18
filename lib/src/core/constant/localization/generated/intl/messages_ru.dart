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

  static String m0(distance) => "Ты не в школе. Дистанция ${distance} метров";

  static String m1(loosedQty, possibleLooseDays) =>
      "Пропуски  и больничные ${loosedQty} из ${possibleLooseDays} дней";

  static String m2(entiesQty, possibleLooseDays) =>
      "Больничный ${entiesQty} из ${possibleLooseDays} дней";

  static String m3(schoolQty) => "${schoolQty} дней или";

  static String m4(entiesQty, totalVisits) =>
      "Всего ${entiesQty} из ${totalVisits} дней";

  static String m5(userDisplayname) => "Записи ${userDisplayname}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addEntryButtonText": MessageLookupByLibrary.simpleMessage("Добавить"),
        "allEntriesAddedSuccessMessage": MessageLookupByLibrary.simpleMessage(
            "Отлично! Вы добавили все записи"),
        "anmeldungAppBarText":
            MessageLookupByLibrary.simpleMessage("Регистрация"),
        "anmeldungLogInScreenName":
            MessageLookupByLibrary.simpleMessage("Вход"),
        "appThemeTitleDark": MessageLookupByLibrary.simpleMessage("Тёмная"),
        "appThemeTitleDefault":
            MessageLookupByLibrary.simpleMessage("Автоматически"),
        "appThemeTitleLight": MessageLookupByLibrary.simpleMessage("Светлая"),
        "atHomeStatisticWidget": MessageLookupByLibrary.simpleMessage("дома"),
        "authenticationUserTypeErrorScreeenText":
            MessageLookupByLibrary.simpleMessage("Ошибка аутентификации"),
        "bugReport": MessageLookupByLibrary.simpleMessage("Сообщить об ошибке"),
        "calendarFormatButton": MessageLookupByLibrary.simpleMessage("Месяц"),
        "calendarFormatButtonTwoWeeks":
            MessageLookupByLibrary.simpleMessage("2 Недели"),
        "calendarFormatButtonWeek":
            MessageLookupByLibrary.simpleMessage("Неделя"),
        "calendarStateErrorMessage_buttonText_youAreForgot":
            MessageLookupByLibrary.simpleMessage("Я забыл"),
        "calendarStateErrorMessage_distanceToSchool": m0,
        "calendarStateErrorMessage_future":
            MessageLookupByLibrary.simpleMessage("Осторожно! Будущее"),
        "calendarStateErrorMessage_noLessonsToday":
            MessageLookupByLibrary.simpleMessage("Уроков в этот день нет!"),
        "calendarStateErrorMessage_schoolTypeOnlyToday":
            MessageLookupByLibrary.simpleMessage(
                "Отметиться в школе можно только в текущий день"),
        "calendarStateErrorMessage_thisDateExists":
            MessageLookupByLibrary.simpleMessage(
                "Запись с этой датой уже существует"),
        "contacts": MessageLookupByLibrary.simpleMessage("Контакты"),
        "dashboardAppBarText": MessageLookupByLibrary.simpleMessage("Главная"),
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
        "groupText": MessageLookupByLibrary.simpleMessage("Группа"),
        "homeEntryType": MessageLookupByLibrary.simpleMessage("Дом"),
        "inSchool": MessageLookupByLibrary.simpleMessage("в школе"),
        "languagesEnglish": MessageLookupByLibrary.simpleMessage("Английский"),
        "languagesGerman": MessageLookupByLibrary.simpleMessage("Немецкий"),
        "languagesRussian": MessageLookupByLibrary.simpleMessage("Русский"),
        "lastFiveEntriesWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Пять последних записей"),
        "lectionInfoHeader":
            MessageLookupByLibrary.simpleMessage("Информация о лекции"),
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
        "loosedFromPossibleDays": m1,
        "managerLabel": MessageLookupByLibrary.simpleMessage("Менеджер"),
        "name": MessageLookupByLibrary.simpleMessage("Имя"),
        "navigationErrorScteenText": MessageLookupByLibrary.simpleMessage(
            "Экрана не существует. Пожалуйста, вернитесь назад"),
        "noButtonText": MessageLookupByLibrary.simpleMessage("Нет"),
        "noLessonsToday":
            MessageLookupByLibrary.simpleMessage("Сегодня нет лекций"),
        "page404Header": MessageLookupByLibrary.simpleMessage("Экран 404"),
        "passwordTextFieldLabel":
            MessageLookupByLibrary.simpleMessage("Пароль"),
        "profileAppBarText": MessageLookupByLibrary.simpleMessage("Профиль"),
        "profileEdit":
            MessageLookupByLibrary.simpleMessage("Редактировать профиль"),
        "registrationButtonText":
            MessageLookupByLibrary.simpleMessage("Зарегистрировать"),
        "schoolEntryType": MessageLookupByLibrary.simpleMessage("Школа"),
        "schoolLocationDropDownText":
            MessageLookupByLibrary.simpleMessage("Выберите расположение школы"),
        "selectAUserTypeText":
            MessageLookupByLibrary.simpleMessage("Выберите тип пользователя"),
        "settingsLabelText": MessageLookupByLibrary.simpleMessage("Настройки"),
        "settingsOptionAppTheme": MessageLookupByLibrary.simpleMessage("Тема"),
        "settingsOptionLanguage": MessageLookupByLibrary.simpleMessage("Язык"),
        "sickDaysFromPossible": m2,
        "sickEntryType": MessageLookupByLibrary.simpleMessage("Болезнь"),
        "sickList": MessageLookupByLibrary.simpleMessage("Больничный"),
        "statisticWidgetNDays": m3,
        "statistikAppBarText":
            MessageLookupByLibrary.simpleMessage(" Статистика"),
        "studentLabel": MessageLookupByLibrary.simpleMessage("Студент"),
        "todayLectionWidgetHeader":
            MessageLookupByLibrary.simpleMessage("Сегодня"),
        "totalEntiesTotalVisitsDaysStatisticWidget": m4,
        "trainerLabel": MessageLookupByLibrary.simpleMessage("Тренер"),
        "userNameAndEntriesHeader": m5,
        "userTypeLoginError": MessageLookupByLibrary.simpleMessage(
            "Ваш тип пользователя Неопределён. Попробуйте выйти из приложения и заново выполнить вход. Если это не сработает свяжитесь пожалуйста с IT отделом академии Lutz&Grub."),
        "usersAppBarText": MessageLookupByLibrary.simpleMessage("Пользователи"),
        "yesButtonText": MessageLookupByLibrary.simpleMessage("Да"),
        "youHaveNoOneEntryAdded": MessageLookupByLibrary.simpleMessage(
            "У вас нет ни одной добавленной записи")
      };
}
