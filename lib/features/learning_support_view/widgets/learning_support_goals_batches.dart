import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/goal/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/goal/services/goal_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

List<Widget> learningSupportGoalsBatches(Pupil pupil) {
  List<Widget> list = [];
  for (PupilGoal goal in pupil.pupilGoals!) {}
  return [
    Container(
      width: 21.0,
      height: 21.0,
      decoration: BoxDecoration(
        color: locator<GoalManager>().getRootCategoryColor(
            locator<GoalManager>()
                .getRootCategory(pupil.pupilGoals![0].goalCategoryId)),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          '3',
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    const Gap(5),
    Container(
      width: 21.0,
      height: 21.0,
      decoration: BoxDecoration(
        color: locator<GoalManager>().getRootCategoryColor(
            locator<GoalManager>()
                .getRootCategory(pupil.pupilGoals![0].goalCategoryId)),
        shape: BoxShape.circle,
      ),
    ),
    const Gap(5),
    Container(
      width: 21.0,
      height: 21.0,
      decoration: BoxDecoration(
        color: locator<GoalManager>().getRootCategoryColor(
            locator<GoalManager>()
                .getRootCategory(pupil.pupilGoals![0].goalCategoryId)),
        shape: BoxShape.circle,
      ),
    ),
    const Gap(5),
    Container(
      width: 21.0,
      height: 21.0,
      decoration: BoxDecoration(
        color: locator<GoalManager>().getRootCategoryColor(
            locator<GoalManager>()
                .getRootCategory(pupil.pupilGoals![0].goalCategoryId)),
        shape: BoxShape.circle,
      ),
    ),
    const Gap(5),
    Container(
      width: 21.0,
      height: 21.0,
      decoration: BoxDecoration(
        color: locator<GoalManager>().getRootCategoryColor(
            locator<GoalManager>()
                .getRootCategory(pupil.pupilGoals![0].goalCategoryId)),
        shape: BoxShape.circle,
      ),
    ),
    const Gap(5),
    Container(
      width: 21.0,
      height: 21.0,
      decoration: BoxDecoration(
        color: locator<GoalManager>().getRootCategoryColor(
            locator<GoalManager>()
                .getRootCategory(pupil.pupilGoals![0].goalCategoryId)),
        shape: BoxShape.circle,
      ),
    ),
    const Gap(10),
  ];
}
