import 'package:summer_budget_game/core/failure/failure.dart';

class InsufficientJobSkillsFailure extends Failure {
  final bool missingFinIQ;
  final bool missingScore;

  InsufficientJobSkillsFailure({
    this.missingFinIQ = false,
    this.missingScore = false,
    int code = 4,
  }) : super(code: code, message: 'Insufficient skills');

  @override
  String getLocalizedString() {
    List<String> skills = [];
    if (missingFinIQ) skills.add('Financial IQ');
    if (missingScore) skills.add('Points');
    
    return 'Insufficient: ${skills.join(', ')} ($code)';
  }
}