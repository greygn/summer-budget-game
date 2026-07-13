import 'package:summer_budget_game/core/failure/failure.dart';

class UnfoldingFailure extends Failure{
  UnfoldingFailure({
    int code = 2,
    String? message,
  }) : super(
          code: code,
          message: message ?? 'Data processing error',
        );
  
  @override
  String getLocalizedString() {
    return '$message ($code)';
  }
}