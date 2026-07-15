import '../../core/database/app_database.dart';
import '../../domain/entity/game_action_category_entity.dart';

extension GameActionCategoryMapper on GameActionCategory {
  GameActionCategoryEntity toEntity() {
    return GameActionCategoryEntity(
      ID: id,
    );
  }
}
