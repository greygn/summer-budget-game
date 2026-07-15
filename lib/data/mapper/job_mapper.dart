import 'package:drift/drift.dart' as drift;

import '../../core/database/app_database.dart';
import '../../domain/entity/job_entity.dart';

extension JobMapper on Job {
  JobEntity toEntity() {
    return JobEntity(
      ID: id,
      salary: salary,
      energyCost: energyCost,
      happinessCost: happinessCost,
      timeCost: timeCost,
      minFinIQ: minFinIQ,
      minPoints: minPoints,
    );
  }
}

extension JobEntityMapper on JobEntity {
  JobsCompanion toCompanion() {
    return JobsCompanion.insert(
      id: drift.Value(ID),
      salary: drift.Value(salary),
      energyCost: drift.Value(energyCost),
      happinessCost: drift.Value(happinessCost),
      timeCost: drift.Value(timeCost),
      minFinIQ: drift.Value(minFinIQ),
      minPoints: drift.Value(minPoints),
    );
  }
}
