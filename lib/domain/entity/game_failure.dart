import 'package:summer_budget_game/core/failure/failure.dart';

class GameFailure extends Failure {
  static const int unknown = 0;

  // Database
  static const int database = 1000;
  static const int saveNotFound = 1001;
  static const int readError = 1002;
  static const int writeError = 1003;

  GameFailure({
    required super.code,
    super.message,
  });

  @override
  String getLocalizedString() {
    switch (code) {
      case database:
        return 'Ошибка базы данных';

      case saveNotFound:
        return 'Сохранение не найдено';

      case readError:
        return 'Ошибка чтения данных';

      case writeError:
        return 'Ошибка записи данных';

      case unknown:
      default:
        return message.isNotEmpty
            ? message
            : 'Неизвестная ошибка';
    }
  }
}
