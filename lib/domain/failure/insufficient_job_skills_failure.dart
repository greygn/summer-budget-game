import 'package:summer_budget_game/core/failure/failure.dart';
import '../../generated/l10n.dart';

class InsufficientJobSkillsFailure extends Failure {
  final bool missingFinIQ;
  final bool missingScore;

  InsufficientJobSkillsFailure({
    this.missingFinIQ = false,
    this.missingScore = false,
    int code = 4,
  }) : super(code: code);

  @override
  String getLocalizedString() {
    List<String> skills = [];
    if (missingFinIQ) skills.add(S.current.finIQ);
    if (missingScore) skills.add(S.current.score);
    
    return S.current.insufficientJobSkillsFailure(skills.join(', '));
  }
}