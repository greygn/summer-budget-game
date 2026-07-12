// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Бюджетно!';

  @override
  String get languageIntroduction => 'Это приложение на русском языке';

  @override
  String get welcome_text => 'Добро пожаловать!';

  @override
  String get insufficientTimeFailure =>
      'Не хватает времени для выполнения действия';

  @override
  String get unfoldingFailure => 'Ошибка обработки данных';

  @override
  String insufficientJobSkillsFailure(Object skills) {
    return 'Недостаточно: $skills';
  }

  @override
  String get finIQ => 'Фин. IQ';

  @override
  String get score => 'Очки';

  @override
  String get continue_game => 'Продолжить игру';

  @override
  String get start_new_game => 'Начать новую игру';

  @override
  String get leaderboard => 'Таблица лидеров';

  @override
  String get sprint_mode => 'Спринт';

  @override
  String get sprint_mode_desc => 'Заработай 100 000 за 30 дней';

  @override
  String get marathon_mode => 'Бесконечный';

  @override
  String get marathon_mode_desc => 'Накопи миллион за минимальное время';

  @override
  String get balance => 'Баланс';

  @override
  String get savings => 'Сбережения';

  @override
  String get happiness => 'Счастье';

  @override
  String get energy => 'Энергия';

  @override
  String get job => 'Работа';

  @override
  String get next_day => 'Следующий день';

  @override
  String get choose_job => 'Выбор работы';

  @override
  String get choose_action => 'Чем заняться?';

  @override
  String salary(Object amount) {
    return 'Зарплата: $amount';
  }

  @override
  String cost(Object amount) {
    return 'Цена: $amount';
  }

  @override
  String happiness_gain(Object amount) {
    return '+$amount счастья';
  }

  @override
  String energy_cost(Object amount) {
    return '-$amount энергии';
  }

  @override
  String time_cost(Object amount) {
    return '$amount ч.';
  }

  @override
  String get jobs_title => 'Доступные вакансии';

  @override
  String get actions_title => 'Активности';

  @override
  String get no_jobs_available => 'Нет доступных вакансий';

  @override
  String get no_actions_available => 'Нет доступных активностей';

  @override
  String get action_category_leisure => 'Досуг';

  @override
  String get action_category_food => 'Еда';

  @override
  String get action_category_health => 'Здоровье';

  @override
  String get action_coffee => 'Купить кофе';

  @override
  String get action_gym => 'Сходить в спортзал';

  @override
  String get action_movie => 'Посмотреть кино';

  @override
  String get job_courier => 'Курьер';

  @override
  String get job_waiter => 'Официант';

  @override
  String get job_programmer => 'Программист-стажер';

  @override
  String get accept => 'Принять';

  @override
  String get event_title => 'Событие';

  @override
  String day_count(Object day) {
    return 'День $day';
  }

  @override
  String day_left(Object count) {
    return 'Осталось: $count';
  }

  @override
  String savings_goal(Object goal) {
    return 'Цель: $goal';
  }

  @override
  String get wallet => 'В кошельке';

  @override
  String total_assets(Object amount) {
    return 'Общие активы: $amount';
  }

  @override
  String get currency => '₽';

  @override
  String get victory_title => 'Победа!';

  @override
  String get defeat_title => 'Игра окончена';

  @override
  String get victory_desc =>
      'Поздравляем! Вы достигли цели и накопили необходимую сумму.';

  @override
  String get defeat_desc =>
      'К сожалению, в этот раз не получилось. Попробуйте еще раз!';

  @override
  String get back_to_menu => 'В главное меню';

  @override
  String get final_stats => 'Финальная статистика';
}
