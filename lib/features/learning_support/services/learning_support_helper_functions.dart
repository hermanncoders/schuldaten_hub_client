import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/goal_category.dart';
import 'package:schuldaten_hub/features/learning_support/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

List<Widget> categoryTreeAncestorsNames(int categoryId) {
  // Create an empty list to store ancestors
  List<Widget> ancestors = [];

  // Use a recursive helper function to collect ancestors
  void collectAncestors(int currentCategoryId) {
    final GoalCategory currentCategory =
        locator<GoalManager>().getGoalCategory(currentCategoryId);

    // Check if parent category exists before recursion
    if (currentCategory.parentCategory != null) {
      collectAncestors(currentCategory.parentCategory!);
    }

    // Add current category name to the list after recursion
    ancestors.add(
      Padding(
        padding: currentCategory.categoryId ==
                locator<GoalManager>().getRootCategory(categoryId).categoryId
            ? const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0)
            : currentCategory.categoryId == categoryId
                ? const EdgeInsets.only(left: 10.0, bottom: 10, right: 10.0)
                : const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text(
          currentCategory.categoryName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: currentCategory.categoryId == categoryId ||
                    currentCategory.categoryId ==
                        locator<GoalManager>()
                            .getRootCategory(categoryId)
                            .categoryId
                ? FontWeight.bold
                : FontWeight.normal,
            fontSize: currentCategory.categoryId == categoryId
                ? 13
                : currentCategory.categoryId ==
                        locator<GoalManager>()
                            .getRootCategory(categoryId)
                            .categoryId
                    ? 16
                    : 12,
          ),
        ),
      ),
    );
  }

  // Start the recursion from the input category
  collectAncestors(categoryId);

  // No need to reverse as recursion ensures root first order
  return ancestors;
}

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
