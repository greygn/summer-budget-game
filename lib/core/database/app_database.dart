import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import 'connection.dart';

import 'dao/game_action_categories_dao.dart';
import 'dao/game_actions_dao.dart';
import 'dao/game_event_options_dao.dart';
import 'dao/game_events_dao.dart';
import 'dao/jobs_dao.dart';
import 'dao/leaderboard_dao.dart';
import 'dao/save_record_dao.dart';
import 'tables/jobs_table.dart';
import 'tables/game_actions_table.dart';
import 'tables/game_action_categories_table.dart';
import 'tables/game_events_table.dart';
import 'tables/game_event_options_table.dart';
import 'tables/save_record_table.dart';
import 'tables/leaderboard_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Jobs,
    GameActionCategories,
    GameActions,
    GameEvents,
    GameEventOptions,
    SaveRecords,
    LeaderboardRecords,
  ],
  daos: [
    JobsDao,
    GameActionCategoriesDao,
    GameActionsDao,
    GameEventsDao,
    GameEventOptionsDao,
    SaveRecordDao,
    LeaderboardDao,
  ],
)
@lazySingleton
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator migrator) async {
      await migrator.createAll();
    },

    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 6) {
        await m.createAll();
      }
    },

    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');

      await batch((batch) {
        batch.insert(
          jobs,
          const JobsCompanion(
            id: Value(0),
            nameRu: Value('Безработный'),
            nameEn: Value('Unemployed'),
            salary: Value(0),
            energyCost: Value(0),
            happinessCost: Value(0),
            timeCost: Value(0),
            minFinIQ: Value(0),
            minPoints: Value(0),
          ),
          mode: InsertMode.insertOrIgnore,
        );
        batch.insert(
          gameEvents,
          const GameEventsCompanion(
            id: Value(0),
            titleRu: Value(''),
            titleEn: Value(''),
            descriptionRu: Value(''),
            descriptionEn: Value(''),
            moneyDelta: Value(0),
            energyDelta: Value(0),
            happinessDelta: Value(0),
            finIQDelta: Value(0),
            pointsDelta: Value(0),
          ),
          mode: InsertMode.insertOrIgnore,
        );
      });

      if (details.wasCreated || details.hadUpgrade) {
        await batch((batch) {
          // 1. КАТЕГОРИИ
          batch.insertAll(gameActionCategories, [
            const GameActionCategoriesCompanion(id: Value(1), nameRu: Value('Еда'), nameEn: Value('Food')),
            const GameActionCategoriesCompanion(id: Value(2), nameRu: Value('Здоровье'), nameEn: Value('Health')),
            const GameActionCategoriesCompanion(id: Value(3), nameRu: Value('Отдых'), nameEn: Value('Leisure')),
            const GameActionCategoriesCompanion(id: Value(4), nameRu: Value('Образование'), nameEn: Value('Education')),
            const GameActionCategoriesCompanion(id: Value(5), nameRu: Value('Работа'), nameEn: Value('Work')),
            const GameActionCategoriesCompanion(id: Value(6), nameRu: Value('Стиль'), nameEn: Value('Style')),
            const GameActionCategoriesCompanion(id: Value(7), nameRu: Value('Финансы'), nameEn: Value('Finance')),
          ]);

          // 2. ПРОФЕССИИ
          batch.insertAll(jobs, [
            const JobsCompanion(id: Value(1), nameRu: Value('Пеший курьер'), nameEn: Value('Walking Courier'), salary: Value(1500), energyCost: Value(-25), happinessCost: Value(-15), timeCost: Value(8), minFinIQ: Value(0), minPoints: Value(0)),
            const JobsCompanion(id: Value(2), nameRu: Value('Бариста в переходе'), nameEn: Value('Barista'), salary: Value(2200), energyCost: Value(-20), happinessCost: Value(-10), timeCost: Value(8), minFinIQ: Value(5), minPoints: Value(5)),
            const JobsCompanion(id: Value(3), nameRu: Value('Продавец-консультант'), nameEn: Value('Shop Assistant'), salary: Value(2800), energyCost: Value(-18), happinessCost: Value(-12), timeCost: Value(8), minFinIQ: Value(10), minPoints: Value(15)),
            const JobsCompanion(id: Value(4), nameRu: Value('Администратор компьютерного клуба'), nameEn: Value('Internet Cafe Admin'), salary: Value(3200), energyCost: Value(-12), happinessCost: Value(5), timeCost: Value(8), minFinIQ: Value(15), minPoints: Value(30)),
            const JobsCompanion(id: Value(5), nameRu: Value('Контент-мейкер на фрилансе'), nameEn: Value('Freelance Content Maker'), salary: Value(4000), energyCost: Value(-15), happinessCost: Value(0), timeCost: Value(8), minFinIQ: Value(25), minPoints: Value(50)),
            const JobsCompanion(id: Value(6), nameRu: Value('Помощник маркетолога'), nameEn: Value('Marketing Assistant'), salary: Value(5000), energyCost: Value(-15), happinessCost: Value(-5), timeCost: Value(8), minFinIQ: Value(35), minPoints: Value(80)),
            const JobsCompanion(id: Value(7), nameRu: Value('Младший тестировщик (QA Intern)'), nameEn: Value('QA Intern'), salary: Value(6500), energyCost: Value(-10), happinessCost: Value(-5), timeCost: Value(8), minFinIQ: Value(50), minPoints: Value(120)),
            const JobsCompanion(id: Value(8), nameRu: Value('Junior QA Engineer'), nameEn: Value('Junior QA Engineer'), salary: Value(8500), energyCost: Value(-10), happinessCost: Value(0), timeCost: Value(8), minFinIQ: Value(65), minPoints: Value(200)),
            const JobsCompanion(id: Value(9), nameRu: Value('Junior Frontend Developer'), nameEn: Value('Junior Frontend Developer'), salary: Value(12000), energyCost: Value(-12), happinessCost: Value(5), timeCost: Value(8), minFinIQ: Value(80), minPoints: Value(300)),
            const JobsCompanion(id: Value(10), nameRu: Value('Middle Fullstack Developer'), nameEn: Value('Middle Fullstack Developer'), salary: Value(18000), energyCost: Value(-15), happinessCost: Value(10), timeCost: Value(8), minFinIQ: Value(100), minPoints: Value(500)),
            const JobsCompanion(id: Value(11), nameRu: Value('Senior Developer / Архитектор'), nameEn: Value('Senior Developer / Architect'), salary: Value(28000), energyCost: Value(-18), happinessCost: Value(15), timeCost: Value(8), minFinIQ: Value(130), minPoints: Value(800)),
            const JobsCompanion(id: Value(12), nameRu: Value('Team Lead'), nameEn: Value('Team Lead'), salary: Value(40000), energyCost: Value(-22), happinessCost: Value(-10), timeCost: Value(8), minFinIQ: Value(160), minPoints: Value(1200)),
          ]);

          // 3. ДЕЙСТВИЯ
          batch.insertAll(gameActions, [
            // Системные
            const GameActionsCompanion(id: Value(100), nameRu: Value('Подработка'), nameEn: Value('Gig'), categoryId: Value(5), timeCost: Value(4)),
            const GameActionsCompanion(id: Value(101), nameRu: Value('Смена'), nameEn: Value('Full Shift'), categoryId: Value(5), timeCost: Value(8)),
            const GameActionsCompanion(id: Value(102), nameRu: Value('Овертайм'), nameEn: Value('Overtime'), categoryId: Value(5), timeCost: Value(12)),
            
            // Еда
            const GameActionsCompanion(id: Value(1), nameRu: Value('Лапша быстрого приготовления'), nameEn: Value('Instant Noodles'), categoryId: Value(1), timeCost: Value(1), moneyDelta: Value(-150), energyDelta: Value(5), happinessDelta: Value(-5)),
            const GameActionsCompanion(id: Value(2), nameRu: Value('Обед в столовой'), nameEn: Value('Canteen Lunch'), categoryId: Value(1), timeCost: Value(1), moneyDelta: Value(-450), energyDelta: Value(15), happinessDelta: Value(5)),
            const GameActionsCompanion(id: Value(3), nameRu: Value('Доставка правильного питания'), nameEn: Value('Healthy Food Delivery'), categoryId: Value(1), timeCost: Value(1), moneyDelta: Value(-1500), energyDelta: Value(25), happinessDelta: Value(15), pointsForAction: Value(5)),
            const GameActionsCompanion(id: Value(4), nameRu: Value('Ужин в ресторане'), nameEn: Value('Restaurant Dinner'), categoryId: Value(1), timeCost: Value(2), moneyDelta: Value(-4000), energyDelta: Value(35), happinessDelta: Value(30), pointsForAction: Value(15)),
            
            // Здоровье
            const GameActionsCompanion(id: Value(5), nameRu: Value('Купить дешевые витамины'), nameEn: Value('Cheap Vitamins'), categoryId: Value(2), timeCost: Value(1), moneyDelta: Value(-300), energyDelta: Value(10), happinessDelta: Value(2)),
            const GameActionsCompanion(id: Value(6), nameRu: Value('Зарядка дома'), nameEn: Value('Home Workout'), categoryId: Value(2), timeCost: Value(1), moneyDelta: Value(0), energyDelta: Value(5), happinessDelta: Value(5), pointsForAction: Value(2)),
            const GameActionsCompanion(id: Value(7), nameRu: Value('Сеанс массажа'), nameEn: Value('Massage'), categoryId: Value(2), timeCost: Value(2), moneyDelta: Value(-2500), energyDelta: Value(30), happinessDelta: Value(20), pointsForAction: Value(10)),
            const GameActionsCompanion(id: Value(8), nameRu: Value('Чек-ап в частной клинике'), nameEn: Value('Private Clinic Check-up'), categoryId: Value(2), timeCost: Value(3), moneyDelta: Value(-8000), energyDelta: Value(40), happinessDelta: Value(10), finIQDelta: Value(5), pointsForAction: Value(25)),
            
            // Отдых
            const GameActionsCompanion(id: Value(9), nameRu: Value('Залипать в соцсетях'), nameEn: Value('Surfing Social Media'), categoryId: Value(3), timeCost: Value(2), moneyDelta: Value(0), energyDelta: Value(10), happinessDelta: Value(5), finIQDelta: Value(-2)),
            const GameActionsCompanion(id: Value(10), nameRu: Value('Поспать днем'), nameEn: Value('Day Nap'), categoryId: Value(3), timeCost: Value(2), moneyDelta: Value(0), energyDelta: Value(35), happinessDelta: Value(10)),
            const GameActionsCompanion(id: Value(11), nameRu: Value('Поход в кино с попкорном'), nameEn: Value('Movie with Popcorn'), categoryId: Value(3), timeCost: Value(3), moneyDelta: Value(-1000), energyDelta: Value(20), happinessDelta: Value(15), pointsForAction: Value(5)),
            const GameActionsCompanion(id: Value(12), nameRu: Value('Вечеринка в клубе'), nameEn: Value('Nightclub Party'), categoryId: Value(3), timeCost: Value(5), moneyDelta: Value(-5000), energyDelta: Value(-10), happinessDelta: Value(35), finIQDelta: Value(-5), pointsForAction: Value(20)),
            const GameActionsCompanion(id: Value(13), nameRu: Value('Загородный SPA-отель'), nameEn: Value('Spa Resort'), categoryId: Value(3), timeCost: Value(8), moneyDelta: Value(-15000), energyDelta: Value(70), happinessDelta: Value(50), pointsForAction: Value(50)),
            
            // Образование
            const GameActionsCompanion(id: Value(14), nameRu: Value('Почитать бесплатную статью'), nameEn: Value('Read Free Article'), categoryId: Value(4), timeCost: Value(1), moneyDelta: Value(0), energyDelta: Value(-5), happinessDelta: Value(-2), finIQDelta: Value(2), pointsForAction: Value(2)),
            const GameActionsCompanion(id: Value(15), nameRu: Value('Купить профильную книгу'), nameEn: Value('Buy Professional Book'), categoryId: Value(4), timeCost: Value(2), moneyDelta: Value(-1200), energyDelta: Value(-10), happinessDelta: Value(0), finIQDelta: Value(8), pointsForAction: Value(10)),
            const GameActionsCompanion(id: Value(16), nameRu: Value('Вебинар от эксперта'), nameEn: Value('Expert Webinar'), categoryId: Value(4), timeCost: Value(3), moneyDelta: Value(-3000), energyDelta: Value(-15), happinessDelta: Value(2), finIQDelta: Value(15), pointsForAction: Value(20)),
            const GameActionsCompanion(id: Value(17), nameRu: Value('Интенсивный буткемп'), nameEn: Value('Intensive Bootcamp'), categoryId: Value(4), timeCost: Value(6), moneyDelta: Value(-18000), energyDelta: Value(-30), happinessDelta: Value(-10), finIQDelta: Value(45), pointsForAction: Value(70)),
            
            // Стиль
            const GameActionsCompanion(id: Value(18), nameRu: Value('Стрижка в эконом-парикмахерской'), nameEn: Value('Cheap Haircut'), categoryId: Value(6), timeCost: Value(1), moneyDelta: Value(-400), energyDelta: Value(-2), happinessDelta: Value(2), pointsForAction: Value(5)),
            const GameActionsCompanion(id: Value(19), nameRu: Value('Новый свитшот из масс-маркета'), nameEn: Value('New Sweatshirt'), categoryId: Value(6), timeCost: Value(2), moneyDelta: Value(-3500), energyDelta: Value(-5), happinessDelta: Value(15), pointsForAction: Value(20)),
            const GameActionsCompanion(id: Value(20), nameRu: Value('Стрижка и борода в барбершопе'), nameEn: Value('Barbershop Haircut'), categoryId: Value(6), timeCost: Value(2), moneyDelta: Value(-2500), energyDelta: Value(5), happinessDelta: Value(20), pointsForAction: Value(30)),
            const GameActionsCompanion(id: Value(21), nameRu: Value('Покупка брендовых кроссовок'), nameEn: Value('Branded Sneakers'), categoryId: Value(6), timeCost: Value(2), moneyDelta: Value(-15000), energyDelta: Value(5), happinessDelta: Value(30), pointsForAction: Value(100)),
            const GameActionsCompanion(id: Value(22), nameRu: Value('Костюм-тройка для собеседований'), nameEn: Value('Three-piece Suit'), categoryId: Value(6), timeCost: Value(4), moneyDelta: Value(-35000), energyDelta: Value(-10), happinessDelta: Value(25), finIQDelta: Value(10), pointsForAction: Value(250)),

            // Финансы
            const GameActionsCompanion(id: Value(23), nameRu: Value('Положить 1 000 на вклад'), nameEn: Value('Deposit 1,000'), categoryId: Value(7), timeCost: Value(0), moneyDelta: Value(-1000), savingsDelta: Value(1000)),
            const GameActionsCompanion(id: Value(24), nameRu: Value('Положить 5 000 на вклад'), nameEn: Value('Deposit 5,000'), categoryId: Value(7), timeCost: Value(0), moneyDelta: Value(-5000), savingsDelta: Value(5000)),
            const GameActionsCompanion(id: Value(25), nameRu: Value('Положить 20 000 на вклад'), nameEn: Value('Deposit 20,000'), categoryId: Value(7), timeCost: Value(0), moneyDelta: Value(-20000), savingsDelta: Value(20000)),
            const GameActionsCompanion(id: Value(26), nameRu: Value('Снять 5 000 со вклада'), nameEn: Value('Withdraw 5,000'), categoryId: Value(7), timeCost: Value(0), moneyDelta: Value(5000), savingsDelta: Value(-5000)),
          ]);

          // 4. СОБЫТИЯ
          batch.insertAll(gameEvents, [
            const GameEventsCompanion(id: Value(1), titleRu: Value('Находка'), titleEn: Value('Lucky Find'), descriptionRu: Value('Вы нашли деньги на улице!'), descriptionEn: Value('You found some money on the street!')),
            const GameEventsCompanion(id: Value(2), titleRu: Value('Поломка'), titleEn: Value('Breakdown'), descriptionRu: Value('Ваш основной гаджет требует срочного ремонта.'), descriptionEn: Value('Your main gadget needs urgent repair.')),
            const GameEventsCompanion(id: Value(3), titleRu: Value('Налоги/Штраф'), titleEn: Value('Tax/Fine'), descriptionRu: Value('Пришло уведомление от налоговой или штраф ГИБДД.'), descriptionEn: Value('A tax notification or a traffic fine arrived.')),
            const GameEventsCompanion(id: Value(4), titleRu: Value('Болезнь'), titleEn: Value('Sickness'), descriptionRu: Value('Вы чувствуете себя неважно.'), descriptionEn: Value('You are not feeling well.')),
            const GameEventsCompanion(id: Value(5), titleRu: Value('Подарок'), titleEn: Value('Gift'), descriptionRu: Value('Вам прислали неожиданный денежный перевод.'), descriptionEn: Value('You received an unexpected money transfer.')),
            const GameEventsCompanion(id: Value(6), titleRu: Value('Спор в интернете'), titleEn: Value('Internet Argument'), descriptionRu: Value('Вы потратили весь вечер на бесполезный спор.'), descriptionEn: Value('You spent the whole evening on a useless argument.')),
            const GameEventsCompanion(id: Value(7), titleRu: Value('Бытовуха'), titleEn: Value('Chores'), descriptionRu: Value('Домашние дела затянули вас.'), descriptionEn: Value('Household chores took up all your time.')),
            const GameEventsCompanion(id: Value(8), titleRu: Value('Инсайты'), titleEn: Value('Insights'), descriptionRu: Value('Вы посмотрели крутое видео про финансы.'), descriptionEn: Value('You watched a great video about finances.')),
            const GameEventsCompanion(id: Value(9), titleRu: Value('Кот'), titleEn: Value('Cat'), descriptionRu: Value('Вы решили завести кота или помочь приюту.'), descriptionEn: Value('You decided to get a cat or help a shelter.')),
            const GameEventsCompanion(id: Value(10), titleRu: Value('Уверенность'), titleEn: Value('Confidence'), descriptionRu: Value('Сегодня вы чувствуете себя на высоте.'), descriptionEn: Value('Today you feel on top of the world.')),
            const GameEventsCompanion(id: Value(11), titleRu: Value('Мелкий штраф'), titleEn: Value('Minor Fine'), descriptionRu: Value('Забыли оплатить парковку.'), descriptionEn: Value('Forgot to pay for parking.')),
            const GameEventsCompanion(id: Value(12), titleRu: Value('Гордость'), titleEn: Value('Pride'), descriptionRu: Value('Ваши успехи заметили.'), descriptionEn: Value('Your success has been noticed.')),
            const GameEventsCompanion(id: Value(13), titleRu: Value('Похмелье'), titleEn: Value('Hangover'), descriptionRu: Value('Вчера было слишком весело.'), descriptionEn: Value('Yesterday was too much fun.')),
            const GameEventsCompanion(id: Value(14), titleRu: Value('Звонок друга'), titleEn: Value('Friend Calling'), descriptionRu: Value('Друг зовет в бар развеяться.'), descriptionEn: Value('A friend calls you to the bar.')),
            const GameEventsCompanion(id: Value(15), titleRu: Value('Распродажа в Steam'), titleEn: Value('Steam Sale'), descriptionRu: Value('Скидки на игры, которые вы давно хотели.'), descriptionEn: Value('Discounts on games you wanted.')),
            const GameEventsCompanion(id: Value(16), titleRu: Value('Зубная боль'), titleEn: Value('Toothache'), descriptionRu: Value('Нужно срочно идти к стоматологу.'), descriptionEn: Value('Need to see a dentist immediately.')),
            const GameEventsCompanion(id: Value(17), titleRu: Value('Инфобизнес'), titleEn: Value('Info Business'), descriptionRu: Value('Вам предлагают купить курс "Успешный успех".'), descriptionEn: Value('You are offered a course on success.')),
            const GameEventsCompanion(id: Value(18), titleRu: Value('Шоппинг'), titleEn: Value('Shopping'), descriptionRu: Value('Наступили холода, нужна верхняя одежда.'), descriptionEn: Value('It is getting cold, need some warm clothes.')),
            const GameEventsCompanion(id: Value(19), titleRu: Value('Визит к бабушке'), titleEn: Value('Visit to Grandma'), descriptionRu: Value('Бабушка пытается накормить и дать денег.'), descriptionEn: Value('Grandma tries to feed you and give you money.')),
            const GameEventsCompanion(id: Value(20), titleRu: Value('Подписка'), titleEn: Value('Subscription'), descriptionRu: Value('Списались деньги за забытую подписку.'), descriptionEn: Value('Money was deducted for a forgotten subscription.')),
            const GameEventsCompanion(id: Value(21), titleRu: Value('Крипто-хайп'), titleEn: Value('Crypto Hype'), descriptionRu: Value('Знакомый зовет вложиться в новую монету.'), descriptionEn: Value('A friend invites you to invest in a new coin.')),
            const GameEventsCompanion(id: Value(22), titleRu: Value('Голод'), titleEn: Value('Hunger'), descriptionRu: Value('Вы очень голодны в конце дня.'), descriptionEn: Value('You are very hungry at the end of the day.')),
            const GameEventsCompanion(id: Value(23), titleRu: Value('Семейный долг'), titleEn: Value('Family Debt'), descriptionRu: Value('Брату срочно понадобились деньги.'), descriptionEn: Value('Your brother needs money urgently.')),
            const GameEventsCompanion(id: Value(24), titleRu: Value('Тестовое задание'), titleEn: Value('Test Task'), descriptionRu: Value('Вам прислали огромное ТЗ на вакансию мечты.'), descriptionEn: Value('You received a huge test task for a dream job.')),
            const GameEventsCompanion(id: Value(25), titleRu: Value('Хайповые очки'), titleEn: Value('Hype Glasses'), descriptionRu: Value('Все ходят в них, может и вам надо?'), descriptionEn: Value('Everyone is wearing them, maybe you should too?')),
            const GameEventsCompanion(id: Value(26), titleRu: Value('Настолки'), titleEn: Value('Board Games'), descriptionRu: Value('Компания собралась поиграть в настолки.'), descriptionEn: Value('Friends gathered to play board games.')),
          ]);

          // 5. ОПЦИИ СОБЫТИЙ
          batch.insertAll(gameEventOptions, [
            const GameEventOptionsCompanion(eventId: Value(1), descriptionRu: Value('Положить в карман'), descriptionEn: Value('Put in pocket'), moneyDelta: Value(1000), happinessDelta: Value(5)),
            const GameEventOptionsCompanion(eventId: Value(2), descriptionRu: Value('Забрать из сервиса и плакать'), descriptionEn: Value('Take from service and cry'), moneyDelta: Value(-8000), energyDelta: Value(-5), happinessDelta: Value(-10)),
            const GameEventOptionsCompanion(eventId: Value(3), descriptionRu: Value('Госуслуги, за что?!'), descriptionEn: Value('Taxes, why?!'), moneyDelta: Value(-3000), happinessDelta: Value(-5), finIQDelta: Value(2)),
            const GameEventOptionsCompanion(eventId: Value(4), descriptionRu: Value('Закинуться терафлю'), descriptionEn: Value('Take medicine'), moneyDelta: Value(-600), energyDelta: Value(-15), happinessDelta: Value(-5)),
            const GameEventOptionsCompanion(eventId: Value(5), descriptionRu: Value('Вот это подгон!'), descriptionEn: Value('What a gift!'), moneyDelta: Value(5000), happinessDelta: Value(15)),
            const GameEventOptionsCompanion(eventId: Value(6), descriptionRu: Value('Кто-то в интернете снова неправ'), descriptionEn: Value('Someone is wrong on the internet'), energyDelta: Value(-10), happinessDelta: Value(-10), finIQDelta: Value(1)),
            const GameEventOptionsCompanion(eventId: Value(7), descriptionRu: Value('Выжимать ковер дальше'), descriptionEn: Value('Keep squeezing the carpet'), energyDelta: Value(-15), happinessDelta: Value(-15)),
            const GameEventOptionsCompanion(eventId: Value(8), descriptionRu: Value('Я теперь инвестор?'), descriptionEn: Value('Am I an investor now?'), energyDelta: Value(-5), finIQDelta: Value(5)),
            const GameEventOptionsCompanion(eventId: Value(9), descriptionRu: Value('Мяу'), descriptionEn: Value('Meow'), moneyDelta: Value(-2000), happinessDelta: Value(20)),
            const GameEventOptionsCompanion(eventId: Value(10), descriptionRu: Value('Я чертовски хорош'), descriptionEn: Value('I am damn good'), happinessDelta: Value(15), pointsDelta: Value(15)),
            const GameEventOptionsCompanion(eventId: Value(11), descriptionRu: Value('Оплатить со скидкой 50%'), descriptionEn: Value('Pay with 50% discount'), moneyDelta: Value(-250), energyDelta: Value(-2), happinessDelta: Value(-2), finIQDelta: Value(1)),
            const GameEventOptionsCompanion(eventId: Value(12), descriptionRu: Value('Гордиться собой'), descriptionEn: Value('Be proud of yourself'), energyDelta: Value(5), happinessDelta: Value(15), pointsDelta: Value(20)),
            const GameEventOptionsCompanion(eventId: Value(13), descriptionRu: Value('Больше никогда...'), descriptionEn: Value('Never again...'), energyDelta: Value(-15), happinessDelta: Value(-20)),
            
            // Интерактивные
            const GameEventOptionsCompanion(eventId: Value(14), descriptionRu: Value('Пойти (гулять так гулять!)'), descriptionEn: Value('Go out (party!)'), moneyDelta: Value(-3000), energyDelta: Value(-10), happinessDelta: Value(25), pointsDelta: Value(10)),
            const GameEventOptionsCompanion(eventId: Value(14), descriptionRu: Value('Остаться дома есть гречку'), descriptionEn: Value('Stay home and eat buckwheat'), energyDelta: Value(10), happinessDelta: Value(-10), finIQDelta: Value(2)),
            
            const GameEventOptionsCompanion(eventId: Value(15), descriptionRu: Value('Купить (все равно играть некогда)'), descriptionEn: Value('Buy (no time to play anyway)'), moneyDelta: Value(-1500), energyDelta: Value(-5), happinessDelta: Value(15), pointsDelta: Value(5)),
            const GameEventOptionsCompanion(eventId: Value(15), descriptionRu: Value('Проявить железную волю'), descriptionEn: Value('Show iron will'), happinessDelta: Value(-5), finIQDelta: Value(5)),
            
            const GameEventOptionsCompanion(eventId: Value(16), descriptionRu: Value('В подвальчик (дешево и сердито)'), descriptionEn: Value('Cheap dentist'), moneyDelta: Value(-3000), energyDelta: Value(-10), happinessDelta: Value(-5), finIQDelta: Value(2)),
            const GameEventOptionsCompanion(eventId: Value(16), descriptionRu: Value('В ВИП-стоматологию'), descriptionEn: Value('VIP Dentistry'), moneyDelta: Value(-12000), energyDelta: Value(5), happinessDelta: Value(10), pointsDelta: Value(30)),
            
            const GameEventOptionsCompanion(eventId: Value(17), descriptionRu: Value('Купить курс успешного успеха'), descriptionEn: Value('Buy success course'), moneyDelta: Value(-5000), energyDelta: Value(-5), happinessDelta: Value(5), finIQDelta: Value(-10), pointsDelta: Value(10)),
            const GameEventOptionsCompanion(eventId: Value(17), descriptionRu: Value('Орать с прогревов и сэкономить'), descriptionEn: Value('Laugh and save money'), happinessDelta: Value(5), finIQDelta: Value(8)),
            
            const GameEventOptionsCompanion(eventId: Value(18), descriptionRu: Value('Купить пуховик за копейки'), descriptionEn: Value('Buy cheap jacket'), moneyDelta: Value(-4000), finIQDelta: Value(5), pointsDelta: Value(5)),
            const GameEventOptionsCompanion(eventId: Value(18), descriptionRu: Value('Взять брендовое пальто'), descriptionEn: Value('Buy branded coat'), moneyDelta: Value(-18000), happinessDelta: Value(25), finIQDelta: Value(-5), pointsDelta: Value(120)),
            
            const GameEventOptionsCompanion(eventId: Value(19), descriptionRu: Value('Взять деньги и огурцы'), descriptionEn: Value('Take money and pickles'), moneyDelta: Value(2000), energyDelta: Value(5), happinessDelta: Value(15)),
            const GameEventOptionsCompanion(eventId: Value(19), descriptionRu: Value('Вернуть деньги, взять только огурцы'), descriptionEn: Value('Return money, take pickles'), energyDelta: Value(5), happinessDelta: Value(25), pointsDelta: Value(50)),
            
            const GameEventOptionsCompanion(eventId: Value(20), descriptionRu: Value('Да ладно, пусть списывают'), descriptionEn: Value('Let them deduct'), moneyDelta: Value(-500), happinessDelta: Value(2), finIQDelta: Value(-2)),
            const GameEventOptionsCompanion(eventId: Value(20), descriptionRu: Value('Отменить ее нафиг'), descriptionEn: Value('Cancel it'), finIQDelta: Value(5)),
            
            const GameEventOptionsCompanion(eventId: Value(21), descriptionRu: Value('Рискнуть! Залить в щиткоины'), descriptionEn: Value('Risk it! Invest in shitcoins'), moneyDelta: Value(-6000), energyDelta: Value(-10), happinessDelta: Value(10), finIQDelta: Value(-15), pointsDelta: Value(40)),
            const GameEventOptionsCompanion(eventId: Value(21), descriptionRu: Value('Послать криптоманить других'), descriptionEn: Value('Let others mine'), finIQDelta: Value(10)),
            
            const GameEventOptionsCompanion(eventId: Value(22), descriptionRu: Value('Заказать бургер сет'), descriptionEn: Value('Order burger set'), moneyDelta: Value(-1200), energyDelta: Value(15), happinessDelta: Value(15)),
            const GameEventOptionsCompanion(eventId: Value(22), descriptionRu: Value('Сварить пустые макароны'), descriptionEn: Value('Cook empty pasta'), moneyDelta: Value(-50), energyDelta: Value(5), happinessDelta: Value(-10), finIQDelta: Value(4)),
            
            const GameEventOptionsCompanion(eventId: Value(23), descriptionRu: Value('Занять (ну родственник же)'), descriptionEn: Value('Lend money (family)'), moneyDelta: Value(-15000), energyDelta: Value(-5), happinessDelta: Value(-5), finIQDelta: Value(-10), pointsDelta: Value(30)),
            const GameEventOptionsCompanion(eventId: Value(23), descriptionRu: Value('Сказать, что карманы пустые'), descriptionEn: Value('Say pockets are empty'), finIQDelta: Value(12)),
            
            const GameEventOptionsCompanion(eventId: Value(24), descriptionRu: Value('Пройти этот ад ради галочки'), descriptionEn: Value('Go through hell for the check'), energyDelta: Value(-15), happinessDelta: Value(-15), finIQDelta: Value(12), pointsDelta: Value(25)),
            const GameEventOptionsCompanion(eventId: Value(24), descriptionRu: Value('Закрыть тест и пойти спать'), descriptionEn: Value('Close test and sleep'), energyDelta: Value(15), happinessDelta: Value(10)),
            
            const GameEventOptionsCompanion(eventId: Value(25), descriptionRu: Value('Купить ради хайпа'), descriptionEn: Value('Buy for hype'), moneyDelta: Value(-3500), happinessDelta: Value(15), pointsDelta: Value(60)),
            const GameEventOptionsCompanion(eventId: Value(25), descriptionRu: Value('Пройти мимо ловушки'), descriptionEn: Value('Walk past the trap'), finIQDelta: Value(6)),
            
            const GameEventOptionsCompanion(eventId: Value(26), descriptionRu: Value('Остаться играть в "Манчкин"'), descriptionEn: Value('Stay and play board games'), moneyDelta: Value(-300), energyDelta: Value(-5), happinessDelta: Value(20), finIQDelta: Value(2), pointsDelta: Value(15)),
            const GameEventOptionsCompanion(eventId: Value(26), descriptionRu: Value('Молча сбежать домой'), descriptionEn: Value('Quietly escape home'), energyDelta: Value(10), happinessDelta: Value(-5)),
          ]);
        });
      }
    },
  );
}
