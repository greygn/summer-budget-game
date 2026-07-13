import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// Название приложения на главном экране
  ///
  /// In ru, this message translates to:
  /// **'Бюджетно!'**
  String get appTitle;

  /// Описание языка интерфейса приложения
  ///
  /// In ru, this message translates to:
  /// **'Это приложение на русском языке'**
  String get languageIntroduction;

  /// No description provided for @welcome_text.
  ///
  /// In ru, this message translates to:
  /// **'Добро пожаловать!'**
  String get welcome_text;

  /// No description provided for @insufficientTimeFailure.
  ///
  /// In ru, this message translates to:
  /// **'Не хватает времени для выполнения действия'**
  String get insufficientTimeFailure;

  /// No description provided for @unfoldingFailure.
  ///
  /// In ru, this message translates to:
  /// **'Ошибка обработки данных'**
  String get unfoldingFailure;

  /// No description provided for @insufficientJobSkillsFailure.
  ///
  /// In ru, this message translates to:
  /// **'Недостаточно: {skills}'**
  String insufficientJobSkillsFailure(Object skills);

  /// No description provided for @finIQ.
  ///
  /// In ru, this message translates to:
  /// **'Фин. IQ'**
  String get finIQ;

  /// No description provided for @score.
  ///
  /// In ru, this message translates to:
  /// **'Очки'**
  String get score;

  /// No description provided for @continue_game.
  ///
  /// In ru, this message translates to:
  /// **'Продолжить игру'**
  String get continue_game;

  /// No description provided for @start_new_game.
  ///
  /// In ru, this message translates to:
  /// **'Начать новую игру'**
  String get start_new_game;

  /// No description provided for @leaderboard.
  ///
  /// In ru, this message translates to:
  /// **'Таблица лидеров'**
  String get leaderboard;

  /// No description provided for @sprint_mode.
  ///
  /// In ru, this message translates to:
  /// **'Спринт'**
  String get sprint_mode;

  /// No description provided for @sprint_mode_desc.
  ///
  /// In ru, this message translates to:
  /// **'Заработай 100 000 за 30 дней'**
  String get sprint_mode_desc;

  /// No description provided for @marathon_mode.
  ///
  /// In ru, this message translates to:
  /// **'Бесконечный'**
  String get marathon_mode;

  /// No description provided for @marathon_mode_desc.
  ///
  /// In ru, this message translates to:
  /// **'Накопи миллион за минимальное время'**
  String get marathon_mode_desc;

  /// No description provided for @balance.
  ///
  /// In ru, this message translates to:
  /// **'Баланс'**
  String get balance;

  /// No description provided for @savings.
  ///
  /// In ru, this message translates to:
  /// **'Сбережения'**
  String get savings;

  /// No description provided for @happiness.
  ///
  /// In ru, this message translates to:
  /// **'Счастье'**
  String get happiness;

  /// No description provided for @energy.
  ///
  /// In ru, this message translates to:
  /// **'Энергия'**
  String get energy;

  /// No description provided for @job.
  ///
  /// In ru, this message translates to:
  /// **'Работа'**
  String get job;

  /// No description provided for @next_day.
  ///
  /// In ru, this message translates to:
  /// **'Следующий день'**
  String get next_day;

  /// No description provided for @choose_job.
  ///
  /// In ru, this message translates to:
  /// **'Выбор работы'**
  String get choose_job;

  /// No description provided for @choose_action.
  ///
  /// In ru, this message translates to:
  /// **'Чем заняться?'**
  String get choose_action;

  /// No description provided for @happiness_gain.
  ///
  /// In ru, this message translates to:
  /// **'+{amount} счастья'**
  String happiness_gain(Object amount);

  /// No description provided for @energy_cost.
  ///
  /// In ru, this message translates to:
  /// **'-{amount} энергии'**
  String energy_cost(Object amount);

  /// No description provided for @time_cost.
  ///
  /// In ru, this message translates to:
  /// **'{amount} ч.'**
  String time_cost(Object amount);

  /// No description provided for @jobs_title.
  ///
  /// In ru, this message translates to:
  /// **'Доступные вакансии'**
  String get jobs_title;

  /// No description provided for @actions_title.
  ///
  /// In ru, this message translates to:
  /// **'Активности'**
  String get actions_title;

  /// No description provided for @no_jobs_available.
  ///
  /// In ru, this message translates to:
  /// **'Нет доступных вакансий'**
  String get no_jobs_available;

  /// No description provided for @no_actions_available.
  ///
  /// In ru, this message translates to:
  /// **'Нет доступных активностей'**
  String get no_actions_available;

  /// No description provided for @action_category_leisure.
  ///
  /// In ru, this message translates to:
  /// **'Досуг'**
  String get action_category_leisure;

  /// No description provided for @action_category_food.
  ///
  /// In ru, this message translates to:
  /// **'Еда'**
  String get action_category_food;

  /// No description provided for @action_category_health.
  ///
  /// In ru, this message translates to:
  /// **'Здоровье'**
  String get action_category_health;

  /// No description provided for @action_coffee.
  ///
  /// In ru, this message translates to:
  /// **'Купить кофе'**
  String get action_coffee;

  /// No description provided for @action_gym.
  ///
  /// In ru, this message translates to:
  /// **'Сходить в спортзал'**
  String get action_gym;

  /// No description provided for @action_movie.
  ///
  /// In ru, this message translates to:
  /// **'Посмотреть кино'**
  String get action_movie;

  /// No description provided for @job_courier.
  ///
  /// In ru, this message translates to:
  /// **'Курьер'**
  String get job_courier;

  /// No description provided for @job_waiter.
  ///
  /// In ru, this message translates to:
  /// **'Официант'**
  String get job_waiter;

  /// No description provided for @job_programmer.
  ///
  /// In ru, this message translates to:
  /// **'Программист-стажер'**
  String get job_programmer;

  /// No description provided for @accept.
  ///
  /// In ru, this message translates to:
  /// **'Принять'**
  String get accept;

  /// No description provided for @event_title.
  ///
  /// In ru, this message translates to:
  /// **'Событие'**
  String get event_title;

  /// No description provided for @day_count.
  ///
  /// In ru, this message translates to:
  /// **'День {day}'**
  String day_count(Object day);

  /// No description provided for @day_left.
  ///
  /// In ru, this message translates to:
  /// **'Осталось: {count}'**
  String day_left(Object count);

  /// No description provided for @savings_goal.
  ///
  /// In ru, this message translates to:
  /// **'Цель: {goal}'**
  String savings_goal(Object goal);

  /// No description provided for @wallet.
  ///
  /// In ru, this message translates to:
  /// **'В кошельке'**
  String get wallet;

  /// No description provided for @total_assets.
  ///
  /// In ru, this message translates to:
  /// **'Общие активы: {amount}'**
  String total_assets(Object amount);

  /// No description provided for @victory_title.
  ///
  /// In ru, this message translates to:
  /// **'Победа!'**
  String get victory_title;

  /// No description provided for @defeat_title.
  ///
  /// In ru, this message translates to:
  /// **'Игра окончена'**
  String get defeat_title;

  /// No description provided for @victory_desc.
  ///
  /// In ru, this message translates to:
  /// **'Поздравляем! Вы достигли цели и накопили необходимую сумму.'**
  String get victory_desc;

  /// No description provided for @defeat_desc.
  ///
  /// In ru, this message translates to:
  /// **'К сожалению, в этот раз не получилось. Попробуйте еще раз!'**
  String get defeat_desc;

  /// No description provided for @back_to_menu.
  ///
  /// In ru, this message translates to:
  /// **'В главное меню'**
  String get back_to_menu;

  /// No description provided for @final_stats.
  ///
  /// In ru, this message translates to:
  /// **'Финальная статистика'**
  String get final_stats;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
