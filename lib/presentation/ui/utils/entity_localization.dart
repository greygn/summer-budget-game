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
    final locale = Localizations.localeOf(context).languageCode;
    return locale == 'ru' ? nameRu : nameEn;
  }
}

extension CategoryLocalization on GameActionCategoryEntity {
  String getName(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return locale == 'ru' ? nameRu : nameEn;
  }
}

extension ActionLocalization on GameActionEntity {
  String getName(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return locale == 'ru' ? nameRu : nameEn;
  }
}

extension EventLocalization on GameEventEntity {
  String getTitle(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return locale == 'ru' ? titleRu : titleEn;
  }

  String getDescription(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return locale == 'ru' ? descriptionRu : descriptionEn;
  }
}

extension EventOptionLocalization on GameEventOptionEntity {
  String getDescription(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return locale == 'ru' ? descriptionRu : descriptionEn;
  }
}
