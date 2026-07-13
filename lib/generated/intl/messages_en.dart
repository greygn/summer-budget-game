// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(day) => "Day ${day}";

  static String m1(count) => "Left: ${count}";

  static String m2(count) => "Goal: ${count} days";

  static String m3(amount) => "-${amount} energy";

  static String m4(amount) => "+${amount} happiness";

  static String m5(skills) => "Insufficient: ${skills}";

  static String m6(goal) => "Goal: ${goal}";

  static String m7(amount) => "${amount} h.";

  static String m8(amount) => "Total Assets: ${amount}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accept": MessageLookupByLibrary.simpleMessage("Accept"),
    "action_category_food": MessageLookupByLibrary.simpleMessage("Food"),
    "action_category_health": MessageLookupByLibrary.simpleMessage("Health"),
    "action_category_leisure": MessageLookupByLibrary.simpleMessage("Leisure"),
    "action_coffee": MessageLookupByLibrary.simpleMessage("Buy Coffee"),
    "action_gym": MessageLookupByLibrary.simpleMessage("Go to Gym"),
    "action_movie": MessageLookupByLibrary.simpleMessage("Watch Movie"),
    "actions_title": MessageLookupByLibrary.simpleMessage("Activities"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Cheapy!"),
    "back_to_menu": MessageLookupByLibrary.simpleMessage("Back to Menu"),
    "balance": MessageLookupByLibrary.simpleMessage("Balance"),
    "choose_action": MessageLookupByLibrary.simpleMessage("What to do?"),
    "choose_job": MessageLookupByLibrary.simpleMessage("Choose Job"),
    "continue_game": MessageLookupByLibrary.simpleMessage("Continue Game"),
    "day_count": m0,
    "day_left": m1,
    "days_goal": m2,
    "defeat_desc": MessageLookupByLibrary.simpleMessage(
      "Unfortunately, it didn\'t work out this time. Try again!",
    ),
    "defeat_title": MessageLookupByLibrary.simpleMessage("Game Over"),
    "energy": MessageLookupByLibrary.simpleMessage("Energy"),
    "energy_cost": m3,
    "enter_name": MessageLookupByLibrary.simpleMessage("Enter your name"),
    "event_title": MessageLookupByLibrary.simpleMessage("Event"),
    "finIQ": MessageLookupByLibrary.simpleMessage("Financial IQ"),
    "final_stats": MessageLookupByLibrary.simpleMessage("Final Stats"),
    "happiness": MessageLookupByLibrary.simpleMessage("Happiness"),
    "happiness_gain": m4,
    "insufficientJobSkillsFailure": m5,
    "insufficientTimeFailure": MessageLookupByLibrary.simpleMessage(
      "Not enough time to complete the action",
    ),
    "job": MessageLookupByLibrary.simpleMessage("Job"),
    "job_courier": MessageLookupByLibrary.simpleMessage("Courier"),
    "job_programmer": MessageLookupByLibrary.simpleMessage("Intern Programmer"),
    "job_waiter": MessageLookupByLibrary.simpleMessage("Waiter"),
    "jobs_title": MessageLookupByLibrary.simpleMessage("Available Jobs"),
    "languageIntroduction": MessageLookupByLibrary.simpleMessage(
      "This app is in English",
    ),
    "leaderboard": MessageLookupByLibrary.simpleMessage("Leaderboard"),
    "marathon_mode": MessageLookupByLibrary.simpleMessage("Endless"),
    "marathon_mode_desc": MessageLookupByLibrary.simpleMessage(
      "Accumulate a million in minimum time",
    ),
    "next_day": MessageLookupByLibrary.simpleMessage("Next Day"),
    "no_actions_available": MessageLookupByLibrary.simpleMessage(
      "No activities available",
    ),
    "no_jobs_available": MessageLookupByLibrary.simpleMessage(
      "No jobs available",
    ),
    "record_result": MessageLookupByLibrary.simpleMessage("Record Result"),
    "savings": MessageLookupByLibrary.simpleMessage("Savings"),
    "savings_goal": m6,
    "score": MessageLookupByLibrary.simpleMessage("Score"),
    "sprint_mode": MessageLookupByLibrary.simpleMessage("Sprint"),
    "sprint_mode_desc": MessageLookupByLibrary.simpleMessage(
      "Earn 100,000 in 30 days",
    ),
    "start_new_game": MessageLookupByLibrary.simpleMessage("Start New Game"),
    "time_cost": m7,
    "total_assets": m8,
    "unfoldingFailure": MessageLookupByLibrary.simpleMessage(
      "Error processing data",
    ),
    "victory_desc": MessageLookupByLibrary.simpleMessage(
      "Congratulations! You reached your goal and saved enough money.",
    ),
    "victory_title": MessageLookupByLibrary.simpleMessage("Victory!"),
    "wallet": MessageLookupByLibrary.simpleMessage("In Wallet"),
    "welcome_text": MessageLookupByLibrary.simpleMessage("Welcome!"),
    "writingFailure": MessageLookupByLibrary.simpleMessage(
      "Error writing data",
    ),
  };
}
