import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

@module
abstract class ThirdPartyModule {
  @lazySingleton
  Talker get talker => Talker();
}
