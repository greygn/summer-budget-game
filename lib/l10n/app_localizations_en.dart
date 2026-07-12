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

  @override
  String get continue_game => 'Continue Game';

  @override
  String get start_new_game => 'Start New Game';

  @override
  String get leaderboard => 'Leaderboard';

  @override
  String get sprint_mode => 'Sprint';

  @override
  String get sprint_mode_desc => 'Earn 100,000 in 30 days';

  @override
  String get marathon_mode => 'Endless';

  @override
  String get marathon_mode_desc => 'Accumulate a million in minimum time';

  @override
  String get balance => 'Balance';

  @override
  String get savings => 'Savings';

  @override
  String get happiness => 'Happiness';

  @override
  String get energy => 'Energy';

  @override
  String get job => 'Job';

  @override
  String get next_day => 'Next Day';

  @override
  String get choose_job => 'Choose Job';

  @override
  String get choose_action => 'What to do?';

  @override
  String salary(Object amount) {
    return 'Salary: $amount';
  }

  @override
  String cost(Object amount) {
    return 'Cost: $amount';
  }

  @override
  String happiness_gain(Object amount) {
    return '+$amount happiness';
  }

  @override
  String energy_cost(Object amount) {
    return '-$amount energy';
  }

  @override
  String time_cost(Object amount) {
    return '$amount h.';
  }

  @override
  String get jobs_title => 'Available Jobs';

  @override
  String get actions_title => 'Activities';

  @override
  String get no_jobs_available => 'No jobs available';

  @override
  String get no_actions_available => 'No activities available';

  @override
  String get action_category_leisure => 'Leisure';

  @override
  String get action_category_food => 'Food';

  @override
  String get action_category_health => 'Health';

  @override
  String get action_coffee => 'Buy Coffee';

  @override
  String get action_gym => 'Go to Gym';

  @override
  String get action_movie => 'Watch Movie';

  @override
  String get job_courier => 'Courier';

  @override
  String get job_waiter => 'Waiter';

  @override
  String get job_programmer => 'Intern Programmer';

  @override
  String get accept => 'Accept';

  @override
  String get event_title => 'Event';

  @override
  String day_count(Object day) {
    return 'Day $day';
  }

  @override
  String day_left(Object count) {
    return 'Left: $count';
  }

  @override
  String savings_goal(Object goal) {
    return 'Goal: $goal';
  }

  @override
  String get wallet => 'In Wallet';

  @override
  String total_assets(Object amount) {
    return 'Total Assets: $amount';
  }

  @override
  String get currency => '\$';

  @override
  String get victory_title => 'Victory!';

  @override
  String get defeat_title => 'Game Over';

  @override
  String get victory_desc =>
      'Congratulations! You reached your goal and saved enough money.';

  @override
  String get defeat_desc =>
      'Unfortunately, it didn\'t work out this time. Try again!';

  @override
  String get back_to_menu => 'Back to Menu';

  @override
  String get final_stats => 'Final Stats';
}
