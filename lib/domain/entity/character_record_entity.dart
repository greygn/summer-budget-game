import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:summer_budget_game/domain/entity/job_entity.dart';

part 'character_record_entity.freezed.dart';

@freezed
abstract class CharacterRecordEntity with _$CharacterRecordEntity {
  const CharacterRecordEntity._();

  const factory CharacterRecordEntity({
    @Default(0) int balance,
    @Default(0) int savings,
    @Default(0) int happiness,
    @Default(0) int energy,
    @Default(0) int finIQ,
    required JobEntity job,
    @Default(0) int score,
  }) = _CharacterRecordEntity;
}
