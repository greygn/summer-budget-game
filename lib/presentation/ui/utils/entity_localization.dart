import 'package:flutter/material.dart';
import '../../../domain/entity/game_action_category_entity.dart';
import '../../../domain/entity/game_action_entity.dart';
import '../../../domain/entity/game_event_entity.dart';
import '../../../domain/entity/game_event_option_entity.dart';
import '../../../domain/entity/job_entity.dart';

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
