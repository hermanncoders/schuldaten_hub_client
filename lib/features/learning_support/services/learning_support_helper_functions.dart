import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    if (currentCategory.categoryId ==
        locator<GoalManager>().getRootCategory(categoryId).categoryId) {
      ancestors.add(
        Row(
          children: [
            const Gap(10),
            Text(
                locator<GoalManager>().getRootCategory(categoryId).categoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      );
    }
    // Add current category name to the list after recursion
    if (currentCategory.categoryId !=
        locator<GoalManager>().getRootCategory(categoryId).categoryId) {
      if (currentCategory.categoryId != categoryId) {
        ancestors.add(
          Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 5),
            child: Flexible(
              child: Text(
                currentCategory.categoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      }
    }
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
