import 'package:summer_budget_game/core/failure/failure.dart';

class InsufficientTimeFailure extends Failure {
  InsufficientTimeFailure({
    int code = 1,
    String? message,
  }) : super(
          code: code,
          message: message ?? 'Not enough time',
        );

  @override
  String getLocalizedString() {
    return '$message ($code)';
  }
}