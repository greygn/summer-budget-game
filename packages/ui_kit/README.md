# UI Kit

UI Kit — это набор переиспользуемых компонентов, тем и дизайн-токенов для проекта **Summer Budget Game**.

Основные возможности:

* Единый набор UI-компонентов.
* Поддержка светлой и темной темы.
* Адаптивный дизайн в соответствии с Material 3.
* Демонстрация и тестирование компонентов через Widgetbook.
* Изоляция UI-слоя от бизнес-логики приложения.

---

# Структура проекта

```text
ui_kit/
├── lib/
│   ├── ui_kit.dart
│     ├── widgets/      ← сами компоненты
│     └── adaptive/     ← адаптивные компоненты
├── widgetbook/
│    ├── usecases/      ← usecase компонентов для widgetbook
│   └── main.dart
├── pubspec.yaml
└── README.md
```

---

# Установка

Пакет подключен в основное приложение:

```yaml
dependencies:
  ui_kit:
    path: packages/ui_kit
```

Нужно выполнить:

```bash
flutter pub get
```

Использование в коде:

```dart
import 'package:ui_kit/ui_kit.dart';
```

---

# Widgetbook

## Что такое Widgetbook

Widgetbook — это каталог компонентов.

Он позволяет:

* Просматривать все виджеты в одном месте.
* Проверять работу светлой и темной темы.
* Проверять адаптивность на разных размерах экранов.
* Тестировать различные состояния компонентов.

---

# Запуск Widgetbook

Перейти в директорию UI Kit:

```bash
cd packages/ui_kit
```

Запустить Widgetbook:

```bash
flutter run -t widgetbook/main.dart
```

---

# Создание нового Use Case

Для каждого публичного компонента необходимо создать минимум один Use Case.

Пример для кнопки:

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Default',
  type: PrimaryButton,
)
Widget buildDefault(BuildContext context) {
  return PrimaryButton(
    onPressed: () {},
    child: const Text('Continue'),
  );
}
```

---

# Генерация Widgetbook

После добавления нового Use Case необходимо обновить сгенерированные файлы:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Для автоматической генерации во время разработки:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

---

# Темы

Все компоненты обязаны поддерживать:

* Light Theme
* Dark Theme

Темы переключаются через настройки Widgetbook.

Пример получения цветов:

```dart
final colorScheme = Theme.of(context).colorScheme;
```

Не использовать:

```dart
Colors.blue
Colors.red
```

внутри компонентов напрямую.

---

# Адаптивный дизайн

UI Kit следует рекомендациям Material 3 Adaptive Design.

Рекомендуемые точки перелома:

| Тип устройства | Ширина    |
| -------------- | --------- |
| Compact        | < 600dp   |
| Medium         | 600–840dp |
| Expanded       | > 840dp   |

Пример:

```dart
final width = MediaQuery.sizeOf(context).width;

if (width < 600) {
  return const MobileLayout();
}

if (width < 840) {
  return const TabletLayout();
}

return const DesktopLayout();
```

---

# Пример компонента

```dart
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
```
