import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_entity.freezed.dart';

@freezed
abstract class JobEntity with _$JobEntity{
  const JobEntity._();

  const factory JobEntity({
    required int ID,
    @Default(0) int salary,
    @Default(0) int energyCost,
    @Default(0) int happinessCost,
    @Default(0) int timeCost,
    @Default(0) int minFinIQ,
    @Default(0) int minPoints
  }) = _JobEntity;
}