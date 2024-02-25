import 'package:collection/collection.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
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

PupilCategoryStatus? getCategoryStatus(Pupil pupil, int goalCategoryId) {
  if (pupil.pupilCategoryStatuses != null) {
    if (pupil.pupilCategoryStatuses!.isNotEmpty) {
      final PupilCategoryStatus? categoryStatus = pupil.pupilCategoryStatuses!
          .lastWhereOrNull(
              (element) => element.goalCategoryId == goalCategoryId);
      return categoryStatus;
    }
  }
  return null;
}

PupilGoal? getGoalForCategory(Pupil pupil, int goalCategoryId) {
  if (pupil.pupilGoals != null) {
    if (pupil.pupilGoals!.isNotEmpty) {
      final PupilGoal? goal = pupil.pupilGoals!.lastWhereOrNull(
          (element) => element.goalCategoryId == goalCategoryId);
      return goal;
    }
    return null;
  }
  return null;
}
