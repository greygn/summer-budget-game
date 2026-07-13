// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Cheapy!';

  @override
  String get languageIntroduction => 'This app is in English';

  @override
  String get welcome_text => 'Welcome!';

  @override
  String get insufficientTimeFailure =>
      'Not enough time to complete the action';

  @override
  String get unfoldingFailure => 'Error processing data';

  @override
  String insufficientJobSkillsFailure(Object skills) {
    return 'Insufficient: $skills';
  }

  @override
  String get finIQ => 'Financial IQ';

  @override
  String get score => 'Score';
}
