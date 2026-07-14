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
  String get welcome_text => 'Добро пожаловать в игру!';

  @override
  String get insufficientTimeFailure =>
      'В сутках всего 24 часа, на это действие не хватит времени';

  @override
  String get unfoldingFailure => 'Произошла ошибка при загрузке данных';

  @override
  String insufficientJobSkillsFailure(Object skills) {
    return 'Вам не хватает опыта: $skills';
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
  String get leaderboard => 'Таблица рекордов';

  @override
  String get sprint_mode => 'Спринт';

  @override
  String get sprint_mode_desc => 'Заработайте 100 000 за 30 дней';

  @override
  String get marathon_mode => 'Марафон';

  @override
  String get marathon_mode_desc => 'Накопите миллион за минимальное время';

  @override
  String get balance => 'Наличные';

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
  String get choose_job => 'Выбрать работу';

  @override
  String get choose_action => 'Чем займемся сегодня?';

  @override
  String happiness_gain(Object amount) {
    return '+$amount к счастью';
  }

  @override
  String energy_cost(Object amount) {
    return '-$amount энергии';
  }

  @override
  String time_cost(Object amount) {
    return '$amount часов';
  }

  @override
  String get jobs_title => 'Рынок вакансий';

  @override
  String get actions_title => 'Доступные действия';

  @override
  String get no_jobs_available => 'Нет подходящих вакансий';

  @override
  String get no_actions_available => 'Нет доступных действий';

  @override
  String get action_category_leisure => 'Отдых';

  @override
  String get action_category_food => 'Питание';

  @override
  String get action_category_health => 'Здоровье';

  @override
  String get action_category_edu => 'Обучение';

  @override
  String get action_category_work => 'Труд';

  @override
  String get action_category_style => 'Стиль';

  @override
  String get action_category_finance => 'Финансы';

  @override
  String get job_unemployed => 'Безработный';

  @override
  String get job_courier_walk => 'Пеший курьер';

  @override
  String get job_barista => 'Бариста';

  @override
  String get job_shop_assistant => 'Продавец-консультант';

  @override
  String get job_club_admin => 'Администратор компьютерного клуба';

  @override
  String get job_content_maker => 'Контент-менеджер';

  @override
  String get job_marketing_ass => 'Ассистент маркетолога';

  @override
  String get job_qa_intern => 'Стажер-тестировщик';

  @override
  String get job_junior_qa => 'Младший тестировщик';

  @override
  String get job_junior_dev => 'Младший разработчик';

  @override
  String get job_middle_dev => 'Middle разработчик';

  @override
  String get job_senior_dev => 'Старший разработчик';

  @override
  String get job_team_lead => 'Team Lead';

  @override
  String get action_gig => 'Небольшая подработка';

  @override
  String get action_shift => 'Рабочая смена';

  @override
  String get action_overtime => 'Сверхурочная работа';

  @override
  String get action_noodles => 'Лапша быстрого приготовления';

  @override
  String get action_canteen => 'Обед в столовой';

  @override
  String get action_healthy_food => 'Доставка здорового питания';

  @override
  String get action_restaurant => 'Ужин в ресторане';

  @override
  String get action_vitamins => 'Курс витаминов';

  @override
  String get action_home_workout => 'Зарядка дома';

  @override
  String get action_massage => 'Сеанс массажа';

  @override
  String get action_checkup => 'Медицинское обследование';

  @override
  String get action_social => 'Просмотр социальных сетей';

  @override
  String get action_nap => 'Дневной сон';

  @override
  String get action_movie_popcorn => 'Поход в кино';

  @override
  String get action_party => 'Вечеринка в клубе';

  @override
  String get action_spa => 'Поездка в SPA-отель';

  @override
  String get action_article => 'Чтение полезной статьи';

  @override
  String get action_book => 'Профессиональная литература';

  @override
  String get action_webinar => 'Обучающий вебинар';

  @override
  String get action_bootcamp => 'Интенсивный курс (Буткемп)';

  @override
  String get action_haircut_eco => 'Простая стрижка';

  @override
  String get action_sweatshirt => 'Покупка нового свитшота';

  @override
  String get action_barbershop => 'Визит в барбершоп';

  @override
  String get action_sneakers => 'Брендовые кроссовки';

  @override
  String get action_suit => 'Деловой костюм';

  @override
  String get action_deposit_1k => 'Положить 1 000 на вклад';

  @override
  String get action_deposit_5k => 'Положить 5 000 на вклад';

  @override
  String get action_deposit_20k => 'Положить 20 000 на вклад';

  @override
  String get action_withdraw_5k => 'Снять 5 000 со вклада';

  @override
  String get event_lucky_find_title => 'Удачная находка';

  @override
  String get event_lucky_find_desc =>
      'Ого, под ногами что-то блестит! Кажется, кто-то обронил купюру, и теперь она твоя.';

  @override
  String get event_lucky_find_opt1 => 'Забрать в кошелек';

  @override
  String get event_breakdown_title => 'Гаджет сдался';

  @override
  String get event_breakdown_desc =>
      'Твой любимый девайс издал странный звук и выключился. Придется раскошелиться на ремонт.';

  @override
  String get event_breakdown_opt1 => 'Оплатить стоимость ремонта';

  @override
  String get event_tax_fine_title => 'Письмо счастья';

  @override
  String get event_tax_fine_desc =>
      'Налоговая или полиция вспомнили о твоем существовании. Пора платить по счетам.';

  @override
  String get event_tax_fine_opt1 => 'Оплатить все квитанции';

  @override
  String get event_sickness_title => 'Апчхи!';

  @override
  String get event_sickness_desc =>
      'Похоже, твой организм решил взять незапланированный отпуск. Придется лечиться.';

  @override
  String get event_sickness_opt1 => 'Купить необходимые лекарства';

  @override
  String get event_gift_title => 'Нежданный подгон';

  @override
  String get event_gift_desc =>
      'Кто-то прислал тебе денежный перевод просто так. Приятно, когда о тебе помнят!';

  @override
  String get event_gift_opt1 => 'С благодарностью принять подарок';

  @override
  String get event_arg_title => 'Битва в комментариях';

  @override
  String get event_arg_desc =>
      'Весь вечер пролетел за бессмысленным спором с незнакомцем. Кто-то в интернете снова неправ!';

  @override
  String get event_arg_opt1 => 'Остаться при своем мнении';

  @override
  String get event_chores_title => 'Бытовая ловушка';

  @override
  String get event_chores_desc =>
      'Гора немытой посуды и пыль объявили тебе войну. Пришлось принять вызов.';

  @override
  String get event_chores_opt1 => 'Навести идеальный порядок';

  @override
  String get event_insights_title => 'Озарение';

  @override
  String get event_insights_desc =>
      'Посмотрел крутое видео про финансовую грамотность. Кажется, ты начинаешь что-то понимать!';

  @override
  String get event_insights_opt1 => 'Применить знания на практике';

  @override
  String get event_cat_title => 'Кошачья карма';

  @override
  String get event_cat_desc =>
      'Ты не смог пройти мимо грустных глаз в приюте и решил поддержать пушистых друзей.';

  @override
  String get event_cat_opt1 => 'Погладить кота и помочь приюту';

  @override
  String get event_conf_title => 'На кураже';

  @override
  String get event_conf_desc =>
      'Сегодня ты чувствуешь, что можешь свернуть горы. Главное — направить эту энергию в дело!';

  @override
  String get event_conf_opt1 => 'Использовать этот момент';

  @override
  String get event_fine_minor_title => 'Мелкая неприятность';

  @override
  String get event_fine_minor_desc =>
      'Ой, кажется, парковка была не совсем бесплатной. Камера всё засняла.';

  @override
  String get event_fine_minor_opt1 => 'Оплатить штраф со скидкой';

  @override
  String get event_pride_title => 'Момент славы';

  @override
  String get event_pride_desc =>
      'Твои старания наконец-то заметили окружающие. Повод немного погордиться собой!';

  @override
  String get event_pride_opt1 => 'Порадоваться результату';

  @override
  String get event_hangover_title => 'Последствия веселья';

  @override
  String get event_hangover_desc =>
      'Вчера было весело, но сегодня голова напоминает чугунный котел. День будет долгим.';

  @override
  String get event_hangover_opt1 => 'Больше так не делать';

  @override
  String get event_friend_title => 'Старый добрый друг';

  @override
  String get event_friend_desc =>
      'Друг зовет пропустить по чашечке кофе и обсудить последние новости. Пойдешь?';

  @override
  String get event_friend_opt1 => 'Идем гулять! (Минус деньги, плюс радость)';

  @override
  String get event_friend_opt2 => 'Остаться дома и сэкономить';

  @override
  String get event_steam_title => 'Геймерский соблазн';

  @override
  String get event_steam_desc =>
      'В Steam началась распродажа тех самых игр из твоего списка желаемого. Кошелек в опасности!';

  @override
  String get event_steam_opt1 => 'Купить пару игр (когда-нибудь поиграю)';

  @override
  String get event_steam_opt2 => 'Проявить волю и закрыть вкладку';

  @override
  String get event_tooth_title => 'Зубной вопрос';

  @override
  String get event_tooth_desc =>
      'Зуб решил напомнить о себе острой болью в самый неподходящий момент. Пора к врачу.';

  @override
  String get event_tooth_opt1 => 'Пойти в обычную клинику (дешево)';

  @override
  String get event_tooth_opt2 => 'Записаться в частную стоматологию';

  @override
  String get event_infobiz_title => 'Успешный успех';

  @override
  String get event_infobiz_desc =>
      'Тебе обещают золотые горы за неделю обучения. Верим маркетингу или проходим мимо?';

  @override
  String get event_infobiz_opt1 => 'Рискнуть и купить курс';

  @override
  String get event_infobiz_opt2 => 'Посмеяться и сэкономить';

  @override
  String get event_shopping_title => 'Обновление стиля';

  @override
  String get event_shopping_desc =>
      'Похолодало, и твоя старая куртка больше не справляется. Пора за покупками!';

  @override
  String get event_shopping_opt1 => 'Выбрать бюджетный вариант';

  @override
  String get event_shopping_opt2 => 'Купить качественное дорогое пальто';

  @override
  String get event_grandma_title => 'У бабули на блинах';

  @override
  String get event_grandma_desc =>
      'Бабушка накормила до отвала и настойчиво сует купюру \'на карманные расходы\'.';

  @override
  String get event_grandma_opt1 => 'Взять и помощь, и угощения';

  @override
  String get event_grandma_opt2 => 'Взять только угощения';

  @override
  String get event_sub_title => 'Забытая подписка';

  @override
  String get event_sub_desc =>
      'Ты забыл про пробный период, а сервис — нет. Деньги улетели в облака.';

  @override
  String get event_sub_opt1 => 'Оставить всё как есть';

  @override
  String get event_sub_opt2 => 'Отменить подписку немедленно';

  @override
  String get event_crypto_title => 'Крипто-хайп';

  @override
  String get event_crypto_desc =>
      'Знакомый обещает \'иксы\' на новой монете. Рискнешь сбережениями или побережешь нервы?';

  @override
  String get event_crypto_opt1 => 'Рискнуть сбережениями';

  @override
  String get event_crypto_opt2 => 'Отказаться от риска';

  @override
  String get event_hunger_title => 'Ночной дожор';

  @override
  String get event_hunger_desc =>
      'Вечерний голод застал тебя врасплох. Холодильник пуст, а живот требует праздника.';

  @override
  String get event_hunger_opt1 => 'Заказать доставку еды';

  @override
  String get event_hunger_opt2 => 'Сделать простой перекус дома';

  @override
  String get event_fam_debt_title => 'Семейные узы';

  @override
  String get event_fam_debt_desc =>
      'Близкому родственнику срочно понадобились деньги в долг. Выручишь по-родственному?';

  @override
  String get event_fam_debt_opt1 => 'Помочь семье и занять деньги';

  @override
  String get event_fam_debt_opt2 => 'Сказать, что сейчас нет возможности';

  @override
  String get event_test_task_title => 'Испытание на прочность';

  @override
  String get event_test_task_desc =>
      'Тебе прислали огромное ТЗ на вакансию мечты. Кажется, придется попотеть!';

  @override
  String get event_test_task_opt1 => 'Потратить силы и выполнить его';

  @override
  String get event_test_task_opt2 => 'Отказаться из-за нехватки времени';

  @override
  String get event_glasses_title => 'Жертва моды';

  @override
  String get event_glasses_desc =>
      'Все вокруг ходят в этих странных очках. Может, тебе тоже такие нужны для хайпа?';

  @override
  String get event_glasses_opt1 => 'Купить очки, чтобы быть в тренде';

  @override
  String get event_glasses_opt2 => 'Сохранить деньги';

  @override
  String get event_board_games_title => 'Битва за кубики';

  @override
  String get event_board_games_desc =>
      'Друзья затащили тебя играть в настолки. Похоже, это затянется до рассвета!';

  @override
  String get event_board_games_opt1 => 'Остаться играть до конца';

  @override
  String get event_board_games_opt2 => 'Уйти пораньше, чтобы отдохнуть';

  @override
  String get accept => 'Принять';

  @override
  String get event_title => 'Что-то случилось!';

  @override
  String day_count(Object day) {
    return 'День $day';
  }

  @override
  String days_goal(Object count) {
    return 'Цель: $count дней';
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
  String get victory_title => 'Победа!';

  @override
  String get defeat_title => 'Игра окончена';

  @override
  String get victory_desc =>
      'Поздравляем! Вы достигли цели и накопили нужную сумму.';

  @override
  String get defeat_desc =>
      'К сожалению, на этот раз не получилось. Попробуйте еще раз!';

  @override
  String get back_to_menu => 'В главное меню';

  @override
  String get final_stats => 'Финальная статистика';

  @override
  String get enter_name => 'Введите ваше имя';

  @override
  String get record_result => 'Записать результат';
}
