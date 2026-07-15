import 'package:flutter/material.dart';
import '../../../domain/entity/game_action_category_entity.dart';
import '../../../domain/entity/game_action_entity.dart';
import '../../../domain/entity/game_event_entity.dart';
import '../../../domain/entity/game_event_option_entity.dart';
import '../../../domain/entity/job_entity.dart';
import '../../../domain/failure/insufficient_job_skills_failure.dart';
import '../../../domain/failure/insufficient_time_failure.dart';
import '../../../domain/failure/unfolding_failure.dart';
import '../../../domain/failure/writing_failure.dart';
import '../../../core/failure/failure.dart';
import '../../../l10n/app_localizations.dart';

extension FailureLocalization on Failure {
  String getLocalizedMessage(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    
    if (this is InsufficientTimeFailure) {
      return t.insufficientTimeFailure;
    }
    if (this is WritingFailure) {
      return t.unfoldingFailure;
    }
    if (this is UnfoldingFailure) {
      return t.unfoldingFailure;
    }
    if (this is InsufficientJobSkillsFailure) {
      final f = this as InsufficientJobSkillsFailure;
      List<String> skills = [];
      if (f.missingFinIQ) skills.add(t.finIQ);
      if (f.missingScore) skills.add(t.score);
      return t.insufficientJobSkillsFailure(skills.join(', '));
    }
    
    return message;
  }
}

extension JobLocalization on JobEntity {
  String getName(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (ID) {
      case 0: return t.job_unemployed;
      case 1: return t.job_courier_walk;
      case 2: return t.job_barista;
      case 3: return t.job_shop_assistant;
      case 4: return t.job_club_admin;
      case 5: return t.job_content_maker;
      case 6: return t.job_marketing_ass;
      case 7: return t.job_qa_intern;
      case 8: return t.job_junior_qa;
      case 9: return t.job_junior_dev;
      case 10: return t.job_middle_dev;
      case 11: return t.job_senior_dev;
      case 12: return t.job_team_lead;
      default: return 'Job $ID';
    }
  }
}

extension CategoryLocalization on GameActionCategoryEntity {
  String getName(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (ID) {
      case 1: return t.action_category_food;
      case 2: return t.action_category_health;
      case 3: return t.action_category_leisure;
      case 4: return t.action_category_edu;
      case 5: return t.action_category_work;
      case 6: return t.action_category_style;
      case 7: return t.action_category_finance;
      default: return 'Category $ID';
    }
  }
}

extension ActionLocalization on GameActionEntity {
  String getName(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (ID) {
      case 1: return t.action_noodles;
      case 2: return t.action_canteen;
      case 3: return t.action_healthy_food;
      case 4: return t.action_restaurant;
      case 5: return t.action_vitamins;
      case 6: return t.action_home_workout;
      case 7: return t.action_massage;
      case 8: return t.action_checkup;
      case 9: return t.action_social;
      case 10: return t.action_nap;
      case 11: return t.action_movie_popcorn;
      case 12: return t.action_party;
      case 13: return t.action_spa;
      case 14: return t.action_article;
      case 15: return t.action_book;
      case 16: return t.action_webinar;
      case 17: return t.action_bootcamp;
      case 18: return t.action_haircut_eco;
      case 19: return t.action_sweatshirt;
      case 20: return t.action_barbershop;
      case 21: return t.action_sneakers;
      case 22: return t.action_suit;
      case 23: return t.action_deposit_1k;
      case 24: return t.action_deposit_5k;
      case 25: return t.action_deposit_20k;
      case 26: return t.action_withdraw_5k;
      case 100: return t.action_gig;
      case 101: return t.action_shift;
      case 102: return t.action_overtime;
      default: return 'Action $ID';
    }
  }
}

extension EventLocalization on GameEventEntity {
  String getTitle(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (ID) {
      case 1: return t.event_lucky_find_title;
      case 2: return t.event_breakdown_title;
      case 3: return t.event_tax_fine_title;
      case 4: return t.event_sickness_title;
      case 5: return t.event_gift_title;
      case 6: return t.event_arg_title;
      case 7: return t.event_chores_title;
      case 8: return t.event_insights_title;
      case 9: return t.event_cat_title;
      case 10: return t.event_conf_title;
      case 11: return t.event_fine_minor_title;
      case 12: return t.event_pride_title;
      case 13: return t.event_hangover_title;
      case 14: return t.event_friend_title;
      case 15: return t.event_steam_title;
      case 16: return t.event_tooth_title;
      case 17: return t.event_infobiz_title;
      case 18: return t.event_shopping_title;
      case 19: return t.event_grandma_title;
      case 20: return t.event_sub_title;
      case 21: return t.event_crypto_title;
      case 22: return t.event_hunger_title;
      case 23: return t.event_fam_debt_title;
      case 24: return t.event_test_task_title;
      case 25: return t.event_glasses_title;
      case 26: return t.event_board_games_title;
      default: return 'Event $ID';
    }
  }

  String getDescription(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    switch (ID) {
      case 1: return t.event_lucky_find_desc;
      case 2: return t.event_breakdown_desc;
      case 3: return t.event_tax_fine_desc;
      case 4: return t.event_sickness_desc;
      case 5: return t.event_gift_desc;
      case 6: return t.event_arg_desc;
      case 7: return t.event_chores_desc;
      case 8: return t.event_insights_desc;
      case 9: return t.event_cat_desc;
      case 10: return t.event_conf_desc;
      case 11: return t.event_fine_minor_desc;
      case 12: return t.event_pride_desc;
      case 13: return t.event_hangover_desc;
      case 14: return t.event_friend_desc;
      case 15: return t.event_steam_desc;
      case 16: return t.event_tooth_desc;
      case 17: return t.event_infobiz_desc;
      case 18: return t.event_shopping_desc;
      case 19: return t.event_grandma_desc;
      case 20: return t.event_sub_desc;
      case 21: return t.event_crypto_desc;
      case 22: return t.event_hunger_desc;
      case 23: return t.event_fam_debt_desc;
      case 24: return t.event_test_task_desc;
      case 25: return t.event_glasses_desc;
      case 26: return t.event_board_games_desc;
      default: return 'Event description $ID';
    }
  }
}

extension EventOptionLocalization on GameEventOptionEntity {
  String getLocalizedDescription(BuildContext context, int eventId, int optionIndex) {
    final t = AppLocalizations.of(context)!;
    // Map options to localization keys based on event and their index
    final key = 'event_${eventId}_opt${optionIndex + 1}';
    
    // We need a way to map these dynamically or via a large switch.
    // For simplicity and following the pattern:
    if (eventId == 1 && optionIndex == 0) return t.event_lucky_find_opt1;
    if (eventId == 2 && optionIndex == 0) return t.event_breakdown_opt1;
    if (eventId == 3 && optionIndex == 0) return t.event_tax_fine_opt1;
    if (eventId == 4 && optionIndex == 0) return t.event_sickness_opt1;
    if (eventId == 5 && optionIndex == 0) return t.event_gift_opt1;
    if (eventId == 6 && optionIndex == 0) return t.event_arg_opt1;
    if (eventId == 7 && optionIndex == 0) return t.event_chores_opt1;
    if (eventId == 8 && optionIndex == 0) return t.event_insights_opt1;
    if (eventId == 9 && optionIndex == 0) return t.event_cat_opt1;
    if (eventId == 10 && optionIndex == 0) return t.event_conf_opt1;
    if (eventId == 11 && optionIndex == 0) return t.event_fine_minor_opt1;
    if (eventId == 12 && optionIndex == 0) return t.event_pride_opt1;
    if (eventId == 13 && optionIndex == 0) return t.event_hangover_opt1;
    
    if (eventId == 14) {
      return optionIndex == 0 ? t.event_friend_opt1 : t.event_friend_opt2;
    }
    if (eventId == 15) {
      return optionIndex == 0 ? t.event_steam_opt1 : t.event_steam_opt2;
    }
    if (eventId == 16) {
      return optionIndex == 0 ? t.event_tooth_opt1 : t.event_tooth_opt2;
    }
    if (eventId == 17) {
      return optionIndex == 0 ? t.event_infobiz_opt1 : t.event_infobiz_opt2;
    }
    if (eventId == 18) {
      return optionIndex == 0 ? t.event_shopping_opt1 : t.event_shopping_opt2;
    }
    if (eventId == 19) {
      return optionIndex == 0 ? t.event_grandma_opt1 : t.event_grandma_opt2;
    }
    if (eventId == 20) {
      return optionIndex == 0 ? t.event_sub_opt1 : t.event_sub_opt2;
    }
    if (eventId == 21) {
      return optionIndex == 0 ? t.event_crypto_opt1 : t.event_crypto_opt2;
    }
    if (eventId == 22) {
      return optionIndex == 0 ? t.event_hunger_opt1 : t.event_hunger_opt2;
    }
    if (eventId == 23) {
      return optionIndex == 0 ? t.event_fam_debt_opt1 : t.event_fam_debt_opt2;
    }
    if (eventId == 24) {
      return optionIndex == 0 ? t.event_test_task_opt1 : t.event_test_task_opt2;
    }
    if (eventId == 25) {
      return optionIndex == 0 ? t.event_glasses_opt1 : t.event_glasses_opt2;
    }
    if (eventId == 26) {
      return optionIndex == 0 ? t.event_board_games_opt1 : t.event_board_games_opt2;
    }

    return 'Option $ID';
  }
}
