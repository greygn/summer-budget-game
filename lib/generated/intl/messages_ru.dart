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

  static String m0(day) => "День ${day}";

  static String m1(count) => "Осталось: ${count}";

  static String m2(count) => "Цель: ${count} дн.";

  static String m3(amount) => "-${amount} энергии";

  static String m4(amount) => "+${amount} счастья";

  static String m5(skills) => "Недостаточно: ${skills}";

  static String m6(goal) => "Цель: ${goal}";

  static String m7(amount) => "${amount} ч.";

  static String m8(amount) => "Общие активы: ${amount}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept": MessageLookupByLibrary.simpleMessage("Принять"),
    "action_category_food": MessageLookupByLibrary.simpleMessage("Еда"),
    "action_category_health": MessageLookupByLibrary.simpleMessage("Здоровье"),
    "action_category_leisure": MessageLookupByLibrary.simpleMessage("Досуг"),
    "action_coffee": MessageLookupByLibrary.simpleMessage("Купить кофе"),
    "action_gym": MessageLookupByLibrary.simpleMessage("Сходить в спортзал"),
    "action_movie": MessageLookupByLibrary.simpleMessage("Посмотреть кино"),
    "actions_title": MessageLookupByLibrary.simpleMessage("Активности"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Бюджетно!"),
    "back_to_menu": MessageLookupByLibrary.simpleMessage("В главное меню"),
    "balance": MessageLookupByLibrary.simpleMessage("Баланс"),
    "choose_action": MessageLookupByLibrary.simpleMessage("Чем заняться?"),
    "choose_job": MessageLookupByLibrary.simpleMessage("Выбор работы"),
    "continue_game": MessageLookupByLibrary.simpleMessage("Продолжить игру"),
    "day_count": m0,
    "day_left": m1,
    "days_goal": m2,
    "defeat_desc": MessageLookupByLibrary.simpleMessage(
      "К сожалению, в этот раз не получилось. Попробуйте еще раз!",
    ),
    "defeat_title": MessageLookupByLibrary.simpleMessage("Игра окончена"),
    "energy": MessageLookupByLibrary.simpleMessage("Энергия"),
    "energy_cost": m3,
    "enter_name": MessageLookupByLibrary.simpleMessage("Введите ваше имя"),
    "event_title": MessageLookupByLibrary.simpleMessage("Событие"),
    "finIQ": MessageLookupByLibrary.simpleMessage("Фин. IQ"),
    "final_stats": MessageLookupByLibrary.simpleMessage("Финальная статистика"),
    "happiness": MessageLookupByLibrary.simpleMessage("Счастье"),
    "happiness_gain": m4,
    "insufficientJobSkillsFailure": m5,
    "insufficientTimeFailure": MessageLookupByLibrary.simpleMessage(
      "Не хватает времени для выполнения действия",
    ),
    "job": MessageLookupByLibrary.simpleMessage("Работа"),
    "job_courier": MessageLookupByLibrary.simpleMessage("Курьер"),
    "job_programmer": MessageLookupByLibrary.simpleMessage(
      "Программист-стажер",
    ),
    "job_waiter": MessageLookupByLibrary.simpleMessage("Официант"),
    "jobs_title": MessageLookupByLibrary.simpleMessage("Доступные вакансии"),
    "languageIntroduction": MessageLookupByLibrary.simpleMessage(
      "Это приложение на русском языке",
    ),
    "leaderboard": MessageLookupByLibrary.simpleMessage("Таблица лидеров"),
    "marathon_mode": MessageLookupByLibrary.simpleMessage("Бесконечный"),
    "marathon_mode_desc": MessageLookupByLibrary.simpleMessage(
      "Накопи миллион за минимальное время",
    ),
    "next_day": MessageLookupByLibrary.simpleMessage("Следующий день"),
    "no_actions_available": MessageLookupByLibrary.simpleMessage(
      "Нет доступных активностей",
    ),
    "no_jobs_available": MessageLookupByLibrary.simpleMessage(
      "Нет доступных вакансий",
    ),
    "record_result": MessageLookupByLibrary.simpleMessage("Записать результат"),
    "savings": MessageLookupByLibrary.simpleMessage("Сбережения"),
    "savings_goal": m6,
    "score": MessageLookupByLibrary.simpleMessage("Очки"),
    "sprint_mode": MessageLookupByLibrary.simpleMessage("Спринт"),
    "sprint_mode_desc": MessageLookupByLibrary.simpleMessage(
      "Заработай 100 000 за 30 дней",
    ),
    "start_new_game": MessageLookupByLibrary.simpleMessage("Начать новую игру"),
    "time_cost": m7,
    "total_assets": m8,
    "unfoldingFailure": MessageLookupByLibrary.simpleMessage(
      "Ошибка обработки данных",
    ),
    "victory_desc": MessageLookupByLibrary.simpleMessage(
      "Поздравляем! Вы достигли цели и накопили необходимую сумму.",
    ),
    "victory_title": MessageLookupByLibrary.simpleMessage("Победа!"),
    "wallet": MessageLookupByLibrary.simpleMessage("В кошельке"),
    "welcome_text": MessageLookupByLibrary.simpleMessage("Добро пожаловать!"),
  };
}
