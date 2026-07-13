import 'package:summer_budget_game/core/failure/failure.dart';

class WritingFailure extends Failure {
  WritingFailure({
    int code = 3,
    String? message,
  }) : super(
          code: code,
          message: message ?? 'Error writing data',
        );

  @override
  String getLocalizedString() {
    return '$message ($code)';
  }
}