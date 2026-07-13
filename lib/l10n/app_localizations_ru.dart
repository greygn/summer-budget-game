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
}
