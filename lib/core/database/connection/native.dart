import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

QueryExecutor openConnection() {
  return LazyDatabase(() async {
    final supportDir = await getApplicationSupportDirectory();
    await supportDir.create(recursive: true);

    final file = File(
      p.join(
        supportDir.path,
        'summer_budget_game.sqlite',
      ),
    );

    final legacyDir = await getApplicationDocumentsDirectory();
    final legacyFile = File(
      p.join(
        legacyDir.path,
        'summer_budget_game.sqlite',
      ),
    );

    if (!await file.exists() && await legacyFile.exists()) {
      await legacyFile.copy(file.path);
    }

    return NativeDatabase.createInBackground(
      file,
      setup: (database) {
        database.execute('PRAGMA foreign_keys = ON;');
      },
    );
  });
}
