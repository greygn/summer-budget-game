import 'package:summer_budget_game/core/failure/failure.dart';

import '../../generated/l10n.dart';

class UnfoldingFailure extends Failure{
  UnfoldingFailure({
    int code = 2,
    String? message,
  }) : super(
          code: code,
          message: message ?? S.current.unfoldingFailure,
        );
  
  @override
  String getLocalizedString() {
    return '$message ($code)';
  }
}