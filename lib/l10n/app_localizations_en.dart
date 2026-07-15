// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Budget It!';

  @override
  String get languageIntroduction => 'This app is in English';

  @override
  String get welcome_text => 'Welcome to the game!';

  @override
  String get insufficientTimeFailure =>
      'There are only 24 hours in a day, not enough time for this action';

  @override
  String get unfoldingFailure => 'An error occurred while loading data';

  @override
  String insufficientJobSkillsFailure(Object skills) {
    return 'You lack the experience: $skills';
  }

  @override
  String get finIQ => 'Fin. IQ';

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
  String get marathon_mode => 'Marathon';

  @override
  String get marathon_mode_desc => 'Save a million in minimum time';

  @override
  String get balance => 'Cash';

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
  String get choose_action => 'What is the plan for today?';

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
    return '$amount hours';
  }

  @override
  String get jobs_title => 'Job Market';

  @override
  String get actions_title => 'Available Actions';

  @override
  String get no_jobs_available => 'No suitable jobs available';

  @override
  String get no_actions_available => 'No available actions';

  @override
  String get action_category_leisure => 'Leisure';

  @override
  String get action_category_food => 'Food';

  @override
  String get action_category_health => 'Health';

  @override
  String get action_category_edu => 'Education';

  @override
  String get action_category_work => 'Work';

  @override
  String get action_category_style => 'Style';

  @override
  String get action_category_finance => 'Finance';

  @override
  String get job_unemployed => 'Unemployed';

  @override
  String get job_courier_walk => 'Walking Courier';

  @override
  String get job_barista => 'Barista';

  @override
  String get job_shop_assistant => 'Shop Assistant';

  @override
  String get job_club_admin => 'Internet Cafe Administrator';

  @override
  String get job_content_maker => 'Content Manager';

  @override
  String get job_marketing_ass => 'Marketing Assistant';

  @override
  String get job_qa_intern => 'QA Intern';

  @override
  String get job_junior_qa => 'Junior QA Engineer';

  @override
  String get job_junior_dev => 'Junior Developer';

  @override
  String get job_middle_dev => 'Middle Developer';

  @override
  String get job_senior_dev => 'Senior Developer / Architect';

  @override
  String get job_team_lead => 'Team Lead';

  @override
  String get action_gig => 'Quick Gig';

  @override
  String get action_shift => 'Work Shift';

  @override
  String get action_overtime => 'Overtime Work';

  @override
  String get action_noodles => 'Instant Noodles';

  @override
  String get action_canteen => 'Canteen Lunch';

  @override
  String get action_healthy_food => 'Healthy Food Delivery';

  @override
  String get action_restaurant => 'Restaurant Dinner';

  @override
  String get action_vitamins => 'Vitamin Course';

  @override
  String get action_home_workout => 'Home Workout';

  @override
  String get action_massage => 'Massage Session';

  @override
  String get action_checkup => 'Medical Check-up';

  @override
  String get action_social => 'Social Media';

  @override
  String get action_nap => 'Day Nap';

  @override
  String get action_movie_popcorn => 'Go to the Movies';

  @override
  String get action_party => 'Club Party';

  @override
  String get action_spa => 'SPA Hotel Visit';

  @override
  String get action_article => 'Read an Article';

  @override
  String get action_book => 'Professional Literature';

  @override
  String get action_webinar => 'Educational Webinar';

  @override
  String get action_bootcamp => 'Intensive Course (Bootcamp)';

  @override
  String get action_haircut_eco => 'Simple Haircut';

  @override
  String get action_sweatshirt => 'Buy a New Sweatshirt';

  @override
  String get action_barbershop => 'Barbershop Visit';

  @override
  String get action_sneakers => 'Branded Sneakers';

  @override
  String get action_suit => 'Business Suit';

  @override
  String get action_deposit_1k => 'Put 1,000 in Savings';

  @override
  String get action_deposit_5k => 'Put 5,000 in Savings';

  @override
  String get action_deposit_20k => 'Put 20,000 in Savings';

  @override
  String get action_withdraw_5k => 'Withdraw 5,000 from Savings';

  @override
  String get event_lucky_find_title => 'Lucky Strike!';

  @override
  String get event_lucky_find_desc =>
      'Wait, something is shining on the pavement! Looks like someone dropped some cash.';

  @override
  String get event_lucky_find_opt1 => 'Put it in your wallet';

  @override
  String get event_breakdown_title => 'Tech Betrayal';

  @override
  String get event_breakdown_desc =>
      'Your favorite gadget breathed its last and died. Repair will be expensive.';

  @override
  String get event_breakdown_opt1 => 'Pay for the repair';

  @override
  String get event_tax_fine_title => 'Letter of Joy';

  @override
  String get event_tax_fine_desc =>
      'The tax office or police remembered you exist. Time to pay the bills.';

  @override
  String get event_tax_fine_opt1 => 'Pay all bills';

  @override
  String get event_sickness_title => 'A-choo!';

  @override
  String get event_sickness_desc =>
      'Looks like your body decided to take an unplanned vacation. You are sick.';

  @override
  String get event_sickness_opt1 => 'Buy medicine';

  @override
  String get event_gift_title => 'Unexpected Windfall';

  @override
  String get event_gift_desc =>
      'Someone sent you money just because! It\'s nice to be remembered.';

  @override
  String get event_gift_opt1 => 'Accept with gratitude';

  @override
  String get event_arg_title => 'Comment Section Battle';

  @override
  String get event_arg_desc =>
      'The whole evening flew by in a pointless argument. Someone is wrong again!';

  @override
  String get event_arg_opt1 => 'Stick to your opinion';

  @override
  String get event_chores_title => 'Household Trap';

  @override
  String get event_chores_desc =>
      'Many chores have piled up and attacked in a group. Time to deal with them.';

  @override
  String get event_chores_opt1 => 'Make everything perfect';

  @override
  String get event_insights_title => 'Financial Epiphany';

  @override
  String get event_insights_desc =>
      'Watched that video about compound interest. You\'re starting to get it!';

  @override
  String get event_insights_opt1 => 'Apply knowledge in practice';

  @override
  String get event_cat_title => 'Kitten Karma';

  @override
  String get event_cat_desc =>
      'You couldn\'t pass by the shelter and decided to help the furry friends.';

  @override
  String get event_cat_opt1 => 'Donate and pet a cat';

  @override
  String get event_conf_title => 'On a Roll';

  @override
  String get event_conf_desc =>
      'Today you feel absolutely magnificent! You could move mountains.';

  @override
  String get event_conf_opt1 => 'Enjoy the moment';

  @override
  String get event_fine_minor_title => 'Minor Inconvenience';

  @override
  String get event_fine_minor_desc =>
      'Forgot to pay for parking. The cameras saw everything.';

  @override
  String get event_fine_minor_opt1 => 'Pay with a discount';

  @override
  String get event_pride_title => 'Moment of Glory';

  @override
  String get event_pride_desc =>
      'Your efforts were finally noticed by others. Feels good!';

  @override
  String get event_pride_opt1 => 'Bask in the glory';

  @override
  String get event_hangover_title => 'Rough Morning';

  @override
  String get event_hangover_desc =>
      'Yesterday\'s fun turned into a ringing head today. This will be a long day.';

  @override
  String get event_hangover_opt1 => 'Never do that again';

  @override
  String get event_friend_title => 'Old Friend Calling';

  @override
  String get event_friend_desc =>
      'A friend wants to go to a cafe and catch up. You in?';

  @override
  String get event_friend_opt1 => 'Let\'s go out! (Minus cash, plus joy)';

  @override
  String get event_friend_opt2 => 'Stay home and save money';

  @override
  String get event_steam_title => 'Gamer\'s Temptation';

  @override
  String get event_steam_desc =>
      'A Steam sale started for the games on your wishlist! Wallet in danger!';

  @override
  String get event_steam_opt1 => 'Buy a few games (for later)';

  @override
  String get event_steam_opt2 => 'Show iron will and close the tab';

  @override
  String get event_tooth_title => 'Tooth Trouble';

  @override
  String get event_tooth_desc =>
      'Your tooth decided now is the perfect time for sharp pain. Time for a dentist.';

  @override
  String get event_tooth_opt1 => 'Go to a public clinic';

  @override
  String get event_tooth_opt2 => 'Book a private appointment';

  @override
  String get event_infobiz_title => 'Successful Success';

  @override
  String get event_infobiz_desc =>
      'Offered a course to become a billionaire in a week. Do we believe the marketing?';

  @override
  String get event_infobiz_opt1 => 'Take the risk and buy it';

  @override
  String get event_infobiz_opt2 => 'Laugh at it and save money';

  @override
  String get event_shopping_title => 'Wardrobe Update';

  @override
  String get event_shopping_desc =>
      'It got cold outside, and your old jacket isn\'t cutting it anymore.';

  @override
  String get event_shopping_opt1 => 'Buy a budget version';

  @override
  String get event_shopping_opt2 => 'Buy a high-quality coat';

  @override
  String get event_grandma_title => 'Visit to Grandma';

  @override
  String get event_grandma_desc =>
      'Grandma fed you well and is determined to slip some cash into your pocket.';

  @override
  String get event_grandma_opt1 => 'Take treats and help';

  @override
  String get event_grandma_opt2 => 'Take only the treats';

  @override
  String get event_sub_title => 'Invisible Spending';

  @override
  String get event_sub_desc =>
      'Money deducted for a subscription you forgot to cancel. Classic.';

  @override
  String get event_sub_opt1 => 'Leave it as it is';

  @override
  String get event_sub_opt2 => 'Cancel it immediately';

  @override
  String get event_crypto_title => 'Crypto Fever';

  @override
  String get event_crypto_desc =>
      'A friend promises \'mooning\' on a new coin. Risk it or stay safe?';

  @override
  String get event_crypto_opt1 => 'Risk your savings';

  @override
  String get event_crypto_opt2 => 'Decline the risk';

  @override
  String get event_hunger_title => 'Midnight Munchies';

  @override
  String get event_hunger_desc =>
      'Evening hunger caught you off guard. Too lazy to cook, but very hungry.';

  @override
  String get event_hunger_opt1 => 'Order food delivery';

  @override
  String get event_hunger_opt2 => 'Make a simple snack';

  @override
  String get event_fam_debt_title => 'Brotherly Help';

  @override
  String get event_fam_debt_desc =>
      'A relative needs a loan urgently. Will you help out?';

  @override
  String get event_fam_debt_opt1 => 'Help family and lend money';

  @override
  String get event_fam_debt_opt2 => 'Say you can\'t afford it';

  @override
  String get event_test_task_title => 'Chance of a Lifetime';

  @override
  String get event_test_task_desc =>
      'Sent a test task for a dream job. It looks complex and time-consuming.';

  @override
  String get event_test_task_opt1 => 'Put in the effort and do it';

  @override
  String get event_test_task_opt2 => 'Decline due to lack of time';

  @override
  String get event_glasses_title => 'Fashion Victim';

  @override
  String get event_glasses_desc =>
      'Everyone is wearing those silly glasses. Maybe you need some too for the hype?';

  @override
  String get event_glasses_opt1 => 'Buy them to be on-trend';

  @override
  String get event_glasses_opt2 => 'Keep the money';

  @override
  String get event_board_games_title => 'Board Game Night';

  @override
  String get event_board_games_desc =>
      'Friends dragged you into a long session. This will take forever!';

  @override
  String get event_board_games_opt1 => 'Stay and play until the end';

  @override
  String get event_board_games_opt2 => 'Leave early to rest';

  @override
  String get accept => 'Accept';

  @override
  String get event_title => 'Something Happened!';

  @override
  String day_count(Object day) {
    return 'Day $day';
  }

  @override
  String days_goal(Object count) {
    return 'Goal: $count days';
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
  String get wallet => 'Wallet';

  @override
  String total_assets(Object amount) {
    return 'Total Assets: $amount';
  }

  @override
  String get victory_title => 'Victory!';

  @override
  String get defeat_title => 'Game Over';

  @override
  String get victory_desc =>
      'Congratulations! You reached your goal and saved the money.';

  @override
  String get defeat_desc =>
      'Unfortunately, you didn\'t make it this time. Try again!';

  @override
  String get back_to_menu => 'Back to Menu';

  @override
  String get final_stats => 'Final Stats';

  @override
  String get enter_name => 'Enter your name';

  @override
  String get record_result => 'Record Result';
}
