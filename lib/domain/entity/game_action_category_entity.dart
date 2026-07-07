import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_action_category_entity.freezed.dart';

@freezed
abstract class GameActionCategoryEntity with _$GameActionCategoryEntity{
  const GameActionCategoryEntity._();

  const factory GameActionCategoryEntity({
    required int ID,
    @Default('') String name
  }) = _GameActionCategoryEntity;
}