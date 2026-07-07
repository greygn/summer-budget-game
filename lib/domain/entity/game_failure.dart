import 'package:summer_budget_game/core/failure/failure.dart';

class GameFailure extends Failure {
  GameFailure({required super.code, super.message});

  @override
  String getLocalizedString() {
    // TODO: implement getLocalizedString
    return 'err';
  }
}
