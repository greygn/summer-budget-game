import 'package:drift/drift.dart';

import 'connection/unsupported.dart'
    if (dart.library.html) 'connection/web.dart'
    if (dart.library.io) 'connection/native.dart' as impl;

QueryExecutor openConnection() => impl.openConnection();
