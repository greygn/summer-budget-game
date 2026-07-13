import 'package:summer_budget_game/core/failure/failure.dart';

import '../../generated/l10n.dart';

class InsufficientTimeFailure extends Failure {
  InsufficientTimeFailure({
    int code = 1,
    String? message,
  }) : super(
          code: code,
          message: message ?? S.current.insufficientTimeFailure,
        );

  @override
  String getLocalizedString() {
    return '$message ($code)';
  }
}