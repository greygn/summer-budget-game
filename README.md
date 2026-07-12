## Summer Budget Game
Игра написанная на Dart + Flutter, позволяющая обучаться финансовой грамотности и планированию бюджета в увлекательной форме. Через выполнение обязанностей и столкновение с непредвиденными обстоятельствами игрок сможет понять важность накоплений и разумности при трате денег.

Планируемые фичи:
- Адаптивный дизайн с поддержкой экранов разного размера
- Две локализации интерфейса (русская и английская)
- Система случайных событий
- Текстовое оформление

---
## Про локализацию (Важно!)
Локализация выполняется с помощью библиотек `flutter_localizations` и `intl`. Строки для локализации генерируются с помощью l10n.

Локализированные строки задаются в файлах `intl_<язык>.arb` в папке `/lib/l10n`. Файл `intl_ru.arb` является основным и также должен содержать подсказки для перевода на другой язык.

Пример русской локализации (`intl_ru.arb`):
```json
{
	"languageIntroduction": "Это приложение на русском языке",
  "@languageIntroduction": {
    "description": "Приветственный текст, описывающий язык интерфейса"
  },

  "welcomeUser": "Добро пожаловать, {username}!",
  "@welcomeUser": {
    "description": "Приветствие пользователя на главном экране",
    "placeholders": {
      "username": {
        "type": "String",
        "example": "Алексей"
      }
    }
  },

  "tasksCount": "{count, plural, =0{У вас нет задач} one{У вас {count} активная задача} few{У вас {count} активные задачи} other{У вас {count} активных задач}}",
  "@tasksCount": {
    "description": "Количество невыполненных задач с правильным склонением",
    "placeholders": {
      "count": {
        "type": "int",
        "example": "3"
      }
    }
  }
}
```

> **Важно:** В дополнительных файлах перевода (таких как английский, если основным выбран русский) метаданные с описаниями (строки с символом `@`) указывать **не нужно**. Flutter автоматически возьмет структуру и типы данных из основного шаблона.

Пример английской локализации (`intl_en.arb`):
```json
{
   "languageIntroduction": "This application is in English",

  "welcomeUser": "Welcome, {username}!",

  "tasksCount": "{count, plural, =0{You have no tasks} one{You have {count} active task} other{You have {count} active tasks}}"
}
```

После добавления новых строк необходимо сгенерировать локализацию командой

```bash
flutter gen-l10n
```

Использование локализации в коде (Dart):
```Dart
// 1. Простая строка
Text(AppLocalizations.of(context)!.languageIntroduction)

// 2. Переменная (Выведет: Добро пожаловать, Алексей!)
Text(AppLocalizations.of(context)!.welcomeUser('Алексей'))

// 3. Склонение (Выведет: У вас 3 активные задачи)
Text(AppLocalizations.of(context)!.tasksCount(3))
```

> **Важно! Хардкодить строки для production-кода нельзя! Такие строки не будут менять язык при смене языка системы.**

### ❌ Как делать НЕ НАДО (Хардкод)
```dart
// Строка намертво останется на русском, даже если у пользователя английский интерфейс
Text(
  'У вас осталось 3 задачи',
  style: TextStyle(fontSize: 16),
);
```

### Как делать НАДО (Локализация)
```dart
// Язык адаптируется под систему, а числа будут склоняться правильно
Text(
  AppLocalizations.of(context)!.tasksCount(3),
  style: TextStyle(fontSize: 16),
);
```


---

# Data слой

Проект использует **Clean Architecture**. Data слой отвечает за получение, сохранение и преобразование данных и не используется напрямую из UI.

Структура слоя:

```
lib/
├── core/
│   └── database/
│       ├── app_database.dart
│       ├── connection.dart
│       ├── dao/
│       └── tables/
│
├── data/
│   ├── datasource/
│   │   └── local/
│   ├── mapper/
│   └── repository/
│
└── domain/
```

## Используемые библиотеки

Для хранения данных используется **Drift**.

Основные зависимости:

```yaml
drift
sqlite3_flutter_libs
path
path_provider
build_runner
drift_dev
```

DI реализован через **GetIt**.

---

## Структура базы данных

База данных состоит из следующих таблиц:

| Таблица | Назначение |
|----------|------------|
| Jobs | Список профессий |
| GameActionCategories | Категории игровых действий |
| GameActions | Игровые действия |
| GameEvents | Игровые события |
| GameEventOptions | Варианты выбора в событиях |
| SaveRecords | Сохранение игры |
| LeaderboardRecords | Таблица рекордов |

Все таблицы описываются в папке

```
lib/core/database/tables/
```

---

## DAO

Для каждой таблицы существует собственный DAO.

```
dao/
├── jobs_dao.dart
├── game_actions_dao.dart
├── game_action_categories_dao.dart
├── game_events_dao.dart
├── game_event_options_dao.dart
├── save_record_dao.dart
└── leaderboard_dao.dart
```

DAO работают **только** со своей таблицей и не выполняют преобразование в Domain-модели.

Пример обязанностей DAO:

- чтение;
- запись;
- удаление;
- обновление.

DAO не знают ничего о слоях Domain и Presentation.

---

## Mapper

Mapper располагаются в

```
lib/data/mapper/
```

Они выполняют только преобразование между Drift DataClass и Domain Entity.

Например:

```
GameAction
    ↓
GameActionEntity
```

или

```
GameActionEntity
    ↓
GameActionsCompanion
```

Mapper **не выполняет запросов к базе данных**.

Все связанные сущности должны быть переданы уже готовыми.

Например:

```dart
action.toEntity(
  category: categoryEntity,
);
```

или

```dart
event.toEntity(
  options: options,
);
```

---

## LocalDataSource

LocalDataSource является единственной точкой доступа к локальной базе данных.

Именно он:

- вызывает DAO;
- собирает связанные сущности;
- использует Mapper;
- возвращает готовые Domain Entity.


---

## Repository

Repository является границей между Data и Domain слоями.


Repository:

- вызывает LocalDataSource;
- преобразует исключения в Failure;
- возвращает Either<GameFailure, T>.
---

## Генерация Drift

После изменения таблиц необходимо пересоздать сгенерированный код.

Используйте команду:

```bash
dart run build_runner build --delete-conflicting-outputs
```

После генерации автоматически создаются:

- DataClass (`Job`, `GameEvent`, ...)
- Companion (`JobsCompanion`, `GameEventsCompanion`, ...)
- DAO mixin (`_$JobsDaoMixin`, ...)
- `app_database.g.dart`

Эти файлы изменять вручную нельзя.

---

## Добавление новой таблицы

Чтобы добавить новую сущность в базу данных необходимо:

1. Создать Table.
2. Добавить таблицу в `@DriftDatabase`.
3. Создать DAO.
4. Добавить DAO в `@DriftDatabase`.
5. Создать Mapper.
6. Использовать DAO в LocalDataSource.
7. При необходимости добавить методы в Repository.
8. Выполнить генерацию Drift.

После этого новая таблица будет доступна во всем приложении.

## Dependency Injection (GetIt)

Для управления зависимостями используется библиотека **GetIt**.

В отличие от `injectable`, регистрация выполняется **вручную**, поэтому весь граф зависимостей хорошо виден в одном месте.

Все зависимости регистрируются в файле

```
lib/core/di/service_locator.dart
```

### Порядок регистрации

Зависимости регистрируются от нижнего уровня к верхнему.

```
AppDatabase
      │
      ▼
DAO
      │
      ▼
LocalDataSource
      │
      ▼
Repository
```

Пример регистрации:

```dart
final sl = GetIt.instance;

Future<void> setupLocator() async {

  // Database
  sl.registerLazySingleton<AppDatabase>(
    () => AppDatabase(),
  );

  // DAO
  sl.registerLazySingleton(
    () => JobsDao(sl()),
  );

  sl.registerLazySingleton(
    () => GameActionsDao(sl()),
  );

  sl.registerLazySingleton(
    () => GameEventsDao(sl()),
  );

  // DataSource
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      jobsDao: sl(),
      actionsDao: sl(),
      eventsDao: sl(),
      ...
    ),
  );

  // Repository
  sl.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(sl()),
  );
}
```

---

### Как это работает

При регистрации

```dart
sl.registerLazySingleton(
  () => JobsDao(sl()),
);
```

происходит следующее:

1. GetIt видит, что `JobsDao` требует `AppDatabase`.

```dart
JobsDao(
    AppDatabase database,
)
```

2. Вызов

```dart
sl()
```

означает

```dart
sl<AppDatabase>()
```

3. GetIt находит ранее зарегистрированный `AppDatabase`.

4. Создает `JobsDao`.

Таким образом зависимости автоматически передаются через конструктор.

---

### Почему используется `registerLazySingleton`

Большинство объектов приложения создаются один раз и используются повторно.

```dart
sl.registerLazySingleton(
    () => AppDatabase(),
);
```

означает:

- объект **не создается сразу**;
- он будет создан **только при первом обращении**;
- затем GetIt будет возвращать один и тот же экземпляр.

Это особенно важно для:

- базы данных;
- DAO;
- репозиториев.

Создавать несколько экземпляров этих классов не требуется.

---

### Инициализация

Перед запуском приложения необходимо зарегистрировать все зависимости.

В `main()` вызывается:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(const MyApp());
}
```

После этого любая зарегистрированная зависимость доступна через GetIt во всем приложении.
