import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:summer_budget_game/domain/entity/character_record_entity.dart';
import 'package:summer_budget_game/domain/entity/game_record_entity.dart';

part 'save_record_entity.freezed.dart';

@freezed
abstract class SaveRecordEntity with _$SaveRecordEntity {
  const SaveRecordEntity._();

  const factory SaveRecordEntity({
    @Default('') String name,
    required CharacterRecordEntity characterRecord,
    required GameRecordEntity gameRecord
  }) = _SaveRecordEntity;
}