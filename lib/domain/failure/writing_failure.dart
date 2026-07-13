import 'package:summer_budget_game/core/failure/failure.dart';

import '../../generated/l10n.dart';

class WritingFailure extends Failure {
  WritingFailure({
    int code = 3,
    String? message,
  }) : super(
          code: code,
          message: message ?? S.current.writingFailure,
        );

  @override
  String getLocalizedString() {
    return '$message ($code)';
  }
}