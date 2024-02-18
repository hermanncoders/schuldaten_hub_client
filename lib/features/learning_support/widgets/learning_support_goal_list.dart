import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_goal_card.dart';

List<Widget> learningSupportGoalList(BuildContext context, Pupil pupil) {
  return [
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: accentColor,
            minimumSize: const Size.fromHeight(50)),
        onPressed: () async {},
        child: const Text(
          "NEUES FÖRDERZIEL",
          style: TextStyle(fontSize: 17.0),
        ),
      ),
    ),
    const Gap(5),
    pupil.pupilGoals!.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupil.pupilGoals!.length,
            itemBuilder: (context, int index) {
              return categoryGoalCard(context, pupil, index);
            })
        : const SizedBox.shrink(),
    const Gap(10),
  ];
}
