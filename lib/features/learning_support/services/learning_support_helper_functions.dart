import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

List<PupilGoal> getGoalsForCategory(Pupil pupil, int categoryId) {
  List<PupilGoal> goals = [];
  if (pupil.pupilGoals != null) {
    for (PupilGoal goal in pupil.pupilGoals!) {
      if (goal.goalCategoryId == categoryId) {
        goals.add(goal);
      }
      return goals;
    }
  }
  return [];
}
