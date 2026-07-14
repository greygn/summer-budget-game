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
  /// **'Добро пожаловать в игру!'**
  String get welcome_text;

  /// No description provided for @insufficientTimeFailure.
  ///
  /// In ru, this message translates to:
  /// **'В сутках всего 24 часа, на это действие не хватит времени'**
  String get insufficientTimeFailure;

  /// No description provided for @unfoldingFailure.
  ///
  /// In ru, this message translates to:
  /// **'Произошла ошибка при загрузке данных'**
  String get unfoldingFailure;

  /// No description provided for @insufficientJobSkillsFailure.
  ///
  /// In ru, this message translates to:
  /// **'Вам не хватает опыта: {skills}'**
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
  /// **'Таблица рекордов'**
  String get leaderboard;

  /// No description provided for @sprint_mode.
  ///
  /// In ru, this message translates to:
  /// **'Спринт'**
  String get sprint_mode;

  /// No description provided for @sprint_mode_desc.
  ///
  /// In ru, this message translates to:
  /// **'Заработайте 100 000 за 30 дней'**
  String get sprint_mode_desc;

  /// No description provided for @marathon_mode.
  ///
  /// In ru, this message translates to:
  /// **'Марафон'**
  String get marathon_mode;

  /// No description provided for @marathon_mode_desc.
  ///
  /// In ru, this message translates to:
  /// **'Накопите миллион за минимальное время'**
  String get marathon_mode_desc;

  /// No description provided for @balance.
  ///
  /// In ru, this message translates to:
  /// **'Наличные'**
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
  /// **'Выбрать работу'**
  String get choose_job;

  /// No description provided for @choose_action.
  ///
  /// In ru, this message translates to:
  /// **'Чем займемся?'**
  String get choose_action;

  /// No description provided for @happiness_gain.
  ///
  /// In ru, this message translates to:
  /// **'+{amount} к счастью'**
  String happiness_gain(Object amount);

  /// No description provided for @energy_cost.
  ///
  /// In ru, this message translates to:
  /// **'-{amount} энергии'**
  String energy_cost(Object amount);

  /// No description provided for @time_cost.
  ///
  /// In ru, this message translates to:
  /// **'{amount} часов'**
  String time_cost(Object amount);

  /// No description provided for @jobs_title.
  ///
  /// In ru, this message translates to:
  /// **'Рынок вакансий'**
  String get jobs_title;

  /// No description provided for @actions_title.
  ///
  /// In ru, this message translates to:
  /// **'Доступные действия'**
  String get actions_title;

  /// No description provided for @no_jobs_available.
  ///
  /// In ru, this message translates to:
  /// **'Нет подходящих вакансий'**
  String get no_jobs_available;

  /// No description provided for @no_actions_available.
  ///
  /// In ru, this message translates to:
  /// **'Нет доступных действий'**
  String get no_actions_available;

  /// No description provided for @action_category_leisure.
  ///
  /// In ru, this message translates to:
  /// **'Отдых'**
  String get action_category_leisure;

  /// No description provided for @action_category_food.
  ///
  /// In ru, this message translates to:
  /// **'Питание'**
  String get action_category_food;

  /// No description provided for @action_category_health.
  ///
  /// In ru, this message translates to:
  /// **'Здоровье'**
  String get action_category_health;

  /// No description provided for @action_category_edu.
  ///
  /// In ru, this message translates to:
  /// **'Обучение'**
  String get action_category_edu;

  /// No description provided for @action_category_work.
  ///
  /// In ru, this message translates to:
  /// **'Труд'**
  String get action_category_work;

  /// No description provided for @action_category_style.
  ///
  /// In ru, this message translates to:
  /// **'Стиль'**
  String get action_category_style;

  /// No description provided for @action_category_finance.
  ///
  /// In ru, this message translates to:
  /// **'Финансы'**
  String get action_category_finance;

  /// No description provided for @job_unemployed.
  ///
  /// In ru, this message translates to:
  /// **'Безработный'**
  String get job_unemployed;

  /// No description provided for @job_courier_walk.
  ///
  /// In ru, this message translates to:
  /// **'Пеший курьер'**
  String get job_courier_walk;

  /// No description provided for @job_barista.
  ///
  /// In ru, this message translates to:
  /// **'Бариста'**
  String get job_barista;

  /// No description provided for @job_shop_assistant.
  ///
  /// In ru, this message translates to:
  /// **'Продавец-консультант'**
  String get job_shop_assistant;

  /// No description provided for @job_club_admin.
  ///
  /// In ru, this message translates to:
  /// **'Администратор компьютерного клуба'**
  String get job_club_admin;

  /// No description provided for @job_content_maker.
  ///
  /// In ru, this message translates to:
  /// **'Контент-менеджер'**
  String get job_content_maker;

  /// No description provided for @job_marketing_ass.
  ///
  /// In ru, this message translates to:
  /// **'Ассистент маркетолога'**
  String get job_marketing_ass;

  /// No description provided for @job_qa_intern.
  ///
  /// In ru, this message translates to:
  /// **'Стажер-тестировщик'**
  String get job_qa_intern;

  /// No description provided for @job_junior_qa.
  ///
  /// In ru, this message translates to:
  /// **'Младший тестировщик'**
  String get job_junior_qa;

  /// No description provided for @job_junior_dev.
  ///
  /// In ru, this message translates to:
  /// **'Младший разработчик'**
  String get job_junior_dev;

  /// No description provided for @job_middle_dev.
  ///
  /// In ru, this message translates to:
  /// **'Middle разработчик'**
  String get job_middle_dev;

  /// No description provided for @job_senior_dev.
  ///
  /// In ru, this message translates to:
  /// **'Старший разработчик'**
  String get job_senior_dev;

  /// No description provided for @job_team_lead.
  ///
  /// In ru, this message translates to:
  /// **'Team Lead'**
  String get job_team_lead;

  /// No description provided for @action_gig.
  ///
  /// In ru, this message translates to:
  /// **'Небольшая подработка'**
  String get action_gig;

  /// No description provided for @action_shift.
  ///
  /// In ru, this message translates to:
  /// **'Рабочая смена'**
  String get action_shift;

  /// No description provided for @action_overtime.
  ///
  /// In ru, this message translates to:
  /// **'Сверхурочная работа'**
  String get action_overtime;

  /// No description provided for @action_noodles.
  ///
  /// In ru, this message translates to:
  /// **'Лапша быстрого приготовления'**
  String get action_noodles;

  /// No description provided for @action_canteen.
  ///
  /// In ru, this message translates to:
  /// **'Обед в столовой'**
  String get action_canteen;

  /// No description provided for @action_healthy_food.
  ///
  /// In ru, this message translates to:
  /// **'Доставка здорового питания'**
  String get action_healthy_food;

  /// No description provided for @action_restaurant.
  ///
  /// In ru, this message translates to:
  /// **'Ужин в ресторане'**
  String get action_restaurant;

  /// No description provided for @action_vitamins.
  ///
  /// In ru, this message translates to:
  /// **'Курс витаминов'**
  String get action_vitamins;

  /// No description provided for @action_home_workout.
  ///
  /// In ru, this message translates to:
  /// **'Зарядка дома'**
  String get action_home_workout;

  /// No description provided for @action_massage.
  ///
  /// In ru, this message translates to:
  /// **'Сеанс массажа'**
  String get action_massage;

  /// No description provided for @action_checkup.
  ///
  /// In ru, this message translates to:
  /// **'Медицинское обследование'**
  String get action_checkup;

  /// No description provided for @action_social.
  ///
  /// In ru, this message translates to:
  /// **'Просмотр социальных сетей'**
  String get action_social;

  /// No description provided for @action_nap.
  ///
  /// In ru, this message translates to:
  /// **'Дневной сон'**
  String get action_nap;

  /// No description provided for @action_movie_popcorn.
  ///
  /// In ru, this message translates to:
  /// **'Поход в кино'**
  String get action_movie_popcorn;

  /// No description provided for @action_party.
  ///
  /// In ru, this message translates to:
  /// **'Вечеринка в клубе'**
  String get action_party;

  /// No description provided for @action_spa.
  ///
  /// In ru, this message translates to:
  /// **'Поездка в SPA-отель'**
  String get action_spa;

  /// No description provided for @action_article.
  ///
  /// In ru, this message translates to:
  /// **'Чтение полезной статьи'**
  String get action_article;

  /// No description provided for @action_book.
  ///
  /// In ru, this message translates to:
  /// **'Профессиональная литература'**
  String get action_book;

  /// No description provided for @action_webinar.
  ///
  /// In ru, this message translates to:
  /// **'Обучающий вебинар'**
  String get action_webinar;

  /// No description provided for @action_bootcamp.
  ///
  /// In ru, this message translates to:
  /// **'Интенсивный курс (Буткемп)'**
  String get action_bootcamp;

  /// No description provided for @action_haircut_eco.
  ///
  /// In ru, this message translates to:
  /// **'Простая стрижка'**
  String get action_haircut_eco;

  /// No description provided for @action_sweatshirt.
  ///
  /// In ru, this message translates to:
  /// **'Покупка нового свитшота'**
  String get action_sweatshirt;

  /// No description provided for @action_barbershop.
  ///
  /// In ru, this message translates to:
  /// **'Визит в барбершоп'**
  String get action_barbershop;

  /// No description provided for @action_sneakers.
  ///
  /// In ru, this message translates to:
  /// **'Брендовые кроссовки'**
  String get action_sneakers;

  /// No description provided for @action_suit.
  ///
  /// In ru, this message translates to:
  /// **'Деловой костюм'**
  String get action_suit;

  /// No description provided for @action_deposit_1k.
  ///
  /// In ru, this message translates to:
  /// **'Положить 1 000 на вклад'**
  String get action_deposit_1k;

  /// No description provided for @action_deposit_5k.
  ///
  /// In ru, this message translates to:
  /// **'Положить 5 000 на вклад'**
  String get action_deposit_5k;

  /// No description provided for @action_deposit_20k.
  ///
  /// In ru, this message translates to:
  /// **'Положить 20 000 на вклад'**
  String get action_deposit_20k;

  /// No description provided for @action_withdraw_5k.
  ///
  /// In ru, this message translates to:
  /// **'Снять 5 000 со вклада'**
  String get action_withdraw_5k;

  /// No description provided for @event_lucky_find_title.
  ///
  /// In ru, this message translates to:
  /// **'Удачная находка'**
  String get event_lucky_find_title;

  /// No description provided for @event_lucky_find_desc.
  ///
  /// In ru, this message translates to:
  /// **'Ого, под ногами что-то блестит! Кажется, кто-то обронил купюру, и теперь она твоя.'**
  String get event_lucky_find_desc;

  /// No description provided for @event_lucky_find_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Забрать в кошелек'**
  String get event_lucky_find_opt1;

  /// No description provided for @event_breakdown_title.
  ///
  /// In ru, this message translates to:
  /// **'Гаджет сдался'**
  String get event_breakdown_title;

  /// No description provided for @event_breakdown_desc.
  ///
  /// In ru, this message translates to:
  /// **'Твой любимый девайс издал странный звук и выключился. Придется раскошелиться на ремонт.'**
  String get event_breakdown_desc;

  /// No description provided for @event_breakdown_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Оплатить стоимость ремонта'**
  String get event_breakdown_opt1;

  /// No description provided for @event_tax_fine_title.
  ///
  /// In ru, this message translates to:
  /// **'Письмо счастья'**
  String get event_tax_fine_title;

  /// No description provided for @event_tax_fine_desc.
  ///
  /// In ru, this message translates to:
  /// **'Налоговая или полиция вспомнили о твоем существовании. Пора платить по счетам.'**
  String get event_tax_fine_desc;

  /// No description provided for @event_tax_fine_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Оплатить все квитанции'**
  String get event_tax_fine_opt1;

  /// No description provided for @event_sickness_title.
  ///
  /// In ru, this message translates to:
  /// **'Апчхи!'**
  String get event_sickness_title;

  /// No description provided for @event_sickness_desc.
  ///
  /// In ru, this message translates to:
  /// **'Похоже, твой организм решил взять незапланированный отпуск. Придется лечиться.'**
  String get event_sickness_desc;

  /// No description provided for @event_sickness_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Купить необходимые лекарства'**
  String get event_sickness_opt1;

  /// No description provided for @event_gift_title.
  ///
  /// In ru, this message translates to:
  /// **'Нежданный подгон'**
  String get event_gift_title;

  /// No description provided for @event_gift_desc.
  ///
  /// In ru, this message translates to:
  /// **'Кто-то прислал тебе денежный перевод просто так. Приятно, когда о тебе помнят!'**
  String get event_gift_desc;

  /// No description provided for @event_gift_opt1.
  ///
  /// In ru, this message translates to:
  /// **'С благодарностью принять подарок'**
  String get event_gift_opt1;

  /// No description provided for @event_arg_title.
  ///
  /// In ru, this message translates to:
  /// **'Битва в комментариях'**
  String get event_arg_title;

  /// No description provided for @event_arg_desc.
  ///
  /// In ru, this message translates to:
  /// **'Весь вечер пролетел за бессмысленным спором с незнакомцем. Кто-то в интернете снова неправ!'**
  String get event_arg_desc;

  /// No description provided for @event_arg_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Остаться при своем мнении'**
  String get event_arg_opt1;

  /// No description provided for @event_chores_title.
  ///
  /// In ru, this message translates to:
  /// **'Бытовая ловушка'**
  String get event_chores_title;

  /// No description provided for @event_chores_desc.
  ///
  /// In ru, this message translates to:
  /// **'Гора немытой посуды и пыль объявили тебе войну. Пришлось принять вызов.'**
  String get event_chores_desc;

  /// No description provided for @event_chores_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Навести идеальный порядок'**
  String get event_chores_opt1;

  /// No description provided for @event_insights_title.
  ///
  /// In ru, this message translates to:
  /// **'Озарение'**
  String get event_insights_title;

  /// No description provided for @event_insights_desc.
  ///
  /// In ru, this message translates to:
  /// **'Посмотрел крутое видео про финансовую грамотность. Кажется, ты начинаешь что-то понимать!'**
  String get event_insights_desc;

  /// No description provided for @event_insights_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Применить знания на практике'**
  String get event_insights_opt1;

  /// No description provided for @event_cat_title.
  ///
  /// In ru, this message translates to:
  /// **'Кошачья карма'**
  String get event_cat_title;

  /// No description provided for @event_cat_desc.
  ///
  /// In ru, this message translates to:
  /// **'Ты не смог пройти мимо грустных глаз в приюте и решил поддержать пушистых друзей.'**
  String get event_cat_desc;

  /// No description provided for @event_cat_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Погладить кота и помочь приюту'**
  String get event_cat_opt1;

  /// No description provided for @event_conf_title.
  ///
  /// In ru, this message translates to:
  /// **'На кураже'**
  String get event_conf_title;

  /// No description provided for @event_conf_desc.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня ты чувствуешь, что можешь свернуть горы. Главное — направить эту энергию в дело!'**
  String get event_conf_desc;

  /// No description provided for @event_conf_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Использовать этот момент'**
  String get event_conf_opt1;

  /// No description provided for @event_fine_minor_title.
  ///
  /// In ru, this message translates to:
  /// **'Мелкая неприятность'**
  String get event_fine_minor_title;

  /// No description provided for @event_fine_minor_desc.
  ///
  /// In ru, this message translates to:
  /// **'Ой, кажется, парковка была не совсем бесплатной. Камера всё засняла.'**
  String get event_fine_minor_desc;

  /// No description provided for @event_fine_minor_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Оплатить штраф со скидкой'**
  String get event_fine_minor_opt1;

  /// No description provided for @event_pride_title.
  ///
  /// In ru, this message translates to:
  /// **'Момент славы'**
  String get event_pride_title;

  /// No description provided for @event_pride_desc.
  ///
  /// In ru, this message translates to:
  /// **'Твои старания наконец-то заметили окружающие. Повод немного погордиться собой!'**
  String get event_pride_desc;

  /// No description provided for @event_pride_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Порадоваться результату'**
  String get event_pride_opt1;

  /// No description provided for @event_hangover_title.
  ///
  /// In ru, this message translates to:
  /// **'Последствия веселья'**
  String get event_hangover_title;

  /// No description provided for @event_hangover_desc.
  ///
  /// In ru, this message translates to:
  /// **'Вчера было весело, но сегодня голова напоминает чугунный котел. День будет долгим.'**
  String get event_hangover_desc;

  /// No description provided for @event_hangover_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Больше так не делать'**
  String get event_hangover_opt1;

  /// No description provided for @event_friend_title.
  ///
  /// In ru, this message translates to:
  /// **'Старый добрый друг'**
  String get event_friend_title;

  /// No description provided for @event_friend_desc.
  ///
  /// In ru, this message translates to:
  /// **'Друг зовет пропустить по чашечке кофе и обсудить последние новости. Пойдешь?'**
  String get event_friend_desc;

  /// No description provided for @event_friend_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Идем гулять! (Минус деньги, плюс радость)'**
  String get event_friend_opt1;

  /// No description provided for @event_friend_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Остаться дома и сэкономить'**
  String get event_friend_opt2;

  /// No description provided for @event_steam_title.
  ///
  /// In ru, this message translates to:
  /// **'Геймерский соблазн'**
  String get event_steam_title;

  /// No description provided for @event_steam_desc.
  ///
  /// In ru, this message translates to:
  /// **'В Steam началась распродажа тех самых игр из твоего списка желаемого. Кошелек в опасности!'**
  String get event_steam_desc;

  /// No description provided for @event_steam_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Купить пару игр (когда-нибудь поиграю)'**
  String get event_steam_opt1;

  /// No description provided for @event_steam_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Проявить волю и закрыть вкладку'**
  String get event_steam_opt2;

  /// No description provided for @event_tooth_title.
  ///
  /// In ru, this message translates to:
  /// **'Зубной вопрос'**
  String get event_tooth_title;

  /// No description provided for @event_tooth_desc.
  ///
  /// In ru, this message translates to:
  /// **'Зуб решил напомнить о себе острой болью в самый неподходящий момент. Пора к врачу.'**
  String get event_tooth_desc;

  /// No description provided for @event_tooth_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Пойти в обычную клинику (дешево)'**
  String get event_tooth_opt1;

  /// No description provided for @event_tooth_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Записаться в частную стоматологию'**
  String get event_tooth_opt2;

  /// No description provided for @event_infobiz_title.
  ///
  /// In ru, this message translates to:
  /// **'Успешный успех'**
  String get event_infobiz_title;

  /// No description provided for @event_infobiz_desc.
  ///
  /// In ru, this message translates to:
  /// **'Тебе обещают золотые горы за неделю обучения. Верим маркетингу или проходим мимо?'**
  String get event_infobiz_desc;

  /// No description provided for @event_infobiz_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Рискнуть и купить курс'**
  String get event_infobiz_opt1;

  /// No description provided for @event_infobiz_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Посмеяться и сэкономить'**
  String get event_infobiz_opt2;

  /// No description provided for @event_shopping_title.
  ///
  /// In ru, this message translates to:
  /// **'Обновление стиля'**
  String get event_shopping_title;

  /// No description provided for @event_shopping_desc.
  ///
  /// In ru, this message translates to:
  /// **'Похолодало, и твоя старая куртка больше не справляется. Пора за покупками!'**
  String get event_shopping_desc;

  /// No description provided for @event_shopping_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать бюджетный вариант'**
  String get event_shopping_opt1;

  /// No description provided for @event_shopping_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Купить качественное дорогое пальто'**
  String get event_shopping_opt2;

  /// No description provided for @event_grandma_title.
  ///
  /// In ru, this message translates to:
  /// **'У бабули на блинах'**
  String get event_grandma_title;

  /// No description provided for @event_grandma_desc.
  ///
  /// In ru, this message translates to:
  /// **'Бабушка накормила до отвала и настойчиво сует купюру \'на карманные расходы\'.'**
  String get event_grandma_desc;

  /// No description provided for @event_grandma_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Взять и помощь, и угощения'**
  String get event_grandma_opt1;

  /// No description provided for @event_grandma_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Взять только угощения'**
  String get event_grandma_opt2;

  /// No description provided for @event_sub_title.
  ///
  /// In ru, this message translates to:
  /// **'Забытая подписка'**
  String get event_sub_title;

  /// No description provided for @event_sub_desc.
  ///
  /// In ru, this message translates to:
  /// **'Ты забыл про пробный период, а сервис — нет. Деньги улетели в облака.'**
  String get event_sub_desc;

  /// No description provided for @event_sub_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Оставить всё как есть'**
  String get event_sub_opt1;

  /// No description provided for @event_sub_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Отменить подписку немедленно'**
  String get event_sub_opt2;

  /// No description provided for @event_crypto_title.
  ///
  /// In ru, this message translates to:
  /// **'Крипто-хайп'**
  String get event_crypto_title;

  /// No description provided for @event_crypto_desc.
  ///
  /// In ru, this message translates to:
  /// **'Знакомый обещает \'иксы\' на новой монете. Рискнешь сбережениями или побережешь нервы?'**
  String get event_crypto_desc;

  /// No description provided for @event_crypto_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Рискнуть сбережениями'**
  String get event_crypto_opt1;

  /// No description provided for @event_crypto_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Отказаться от риска'**
  String get event_crypto_opt2;

  /// No description provided for @event_hunger_title.
  ///
  /// In ru, this message translates to:
  /// **'Ночной дожор'**
  String get event_hunger_title;

  /// No description provided for @event_hunger_desc.
  ///
  /// In ru, this message translates to:
  /// **'Вечерний голод застал тебя врасплох. Холодильник пуст, а живот требует праздника.'**
  String get event_hunger_desc;

  /// No description provided for @event_hunger_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Заказать доставку еды'**
  String get event_hunger_opt1;

  /// No description provided for @event_hunger_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Сделать простой перекус дома'**
  String get event_hunger_opt2;

  /// No description provided for @event_fam_debt_title.
  ///
  /// In ru, this message translates to:
  /// **'Семейные узы'**
  String get event_fam_debt_title;

  /// No description provided for @event_fam_debt_desc.
  ///
  /// In ru, this message translates to:
  /// **'Близкому родственнику срочно понадобились деньги в долг. Выручишь по-родственному?'**
  String get event_fam_debt_desc;

  /// No description provided for @event_fam_debt_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Помочь семье и занять деньги'**
  String get event_fam_debt_opt1;

  /// No description provided for @event_fam_debt_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Сказать, что сейчас нет возможности'**
  String get event_fam_debt_opt2;

  /// No description provided for @event_test_task_title.
  ///
  /// In ru, this message translates to:
  /// **'Испытание на прочность'**
  String get event_test_task_title;

  /// No description provided for @event_test_task_desc.
  ///
  /// In ru, this message translates to:
  /// **'Тебе прислали огромное ТЗ на вакансию мечты. Кажется, придется попотеть!'**
  String get event_test_task_desc;

  /// No description provided for @event_test_task_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Потратить силы и выполнить его'**
  String get event_test_task_opt1;

  /// No description provided for @event_test_task_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Отказаться из-за нехватки времени'**
  String get event_test_task_opt2;

  /// No description provided for @event_glasses_title.
  ///
  /// In ru, this message translates to:
  /// **'Жертва моды'**
  String get event_glasses_title;

  /// No description provided for @event_glasses_desc.
  ///
  /// In ru, this message translates to:
  /// **'Все вокруг ходят в этих странных очках. Может, тебе тоже такие нужны для хайпа?'**
  String get event_glasses_desc;

  /// No description provided for @event_glasses_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Купить очки, чтобы быть в тренде'**
  String get event_glasses_opt1;

  /// No description provided for @event_glasses_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить деньги'**
  String get event_glasses_opt2;

  /// No description provided for @event_board_games_title.
  ///
  /// In ru, this message translates to:
  /// **'Битва за кубики'**
  String get event_board_games_title;

  /// No description provided for @event_board_games_desc.
  ///
  /// In ru, this message translates to:
  /// **'Друзья затащили тебя играть в настолки. Похоже, это затянется до рассвета!'**
  String get event_board_games_desc;

  /// No description provided for @event_board_games_opt1.
  ///
  /// In ru, this message translates to:
  /// **'Остаться играть до конца'**
  String get event_board_games_opt1;

  /// No description provided for @event_board_games_opt2.
  ///
  /// In ru, this message translates to:
  /// **'Уйти пораньше, чтобы отдохнуть'**
  String get event_board_games_opt2;

  /// No description provided for @accept.
  ///
  /// In ru, this message translates to:
  /// **'Принять'**
  String get accept;

  /// No description provided for @event_title.
  ///
  /// In ru, this message translates to:
  /// **'Что-то случилось!'**
  String get event_title;

  /// No description provided for @day_count.
  ///
  /// In ru, this message translates to:
  /// **'День {day}'**
  String day_count(Object day);

  /// No description provided for @days_goal.
  ///
  /// In ru, this message translates to:
  /// **'Цель: {count} дней'**
  String days_goal(Object count);

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
  /// **'Поздравляем! Вы достигли цели и накопили нужную сумму.'**
  String get victory_desc;

  /// No description provided for @defeat_desc.
  ///
  /// In ru, this message translates to:
  /// **'К сожалению, на этот раз не получилось. Попробуйте еще раз!'**
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

  /// No description provided for @enter_name.
  ///
  /// In ru, this message translates to:
  /// **'Введите ваше имя'**
  String get enter_name;

  /// No description provided for @record_result.
  ///
  /// In ru, this message translates to:
  /// **'Записать результат'**
  String get record_result;
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
