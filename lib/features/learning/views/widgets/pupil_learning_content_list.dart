import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/competence/models/competence_goal.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/learning/views/widgets/pupil_competence_tree.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

List<Widget> pupilLearningContentList(Pupil pupil, BuildContext context) {
  return [
    const Row(
      children: [
        Text(
          'Lernziele',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    const Gap(10),
    ElevatedButton(
      style: actionButtonStyle,
      onPressed: () async {},
      child: const Text(
        "NEUES LERNZIEL",
        style: TextStyle(fontSize: 17.0),
      ),
    ),
    pupil.competenceGoals!.isNotEmpty ? const Gap(15) : const SizedBox.shrink(),
    pupil.competenceGoals!.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupil.competenceGoals!.length,
            itemBuilder: (context, int index) {
              List<CompetenceGoal> pupilGoals = pupil.competenceGoals!;
              return ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            locator<GoalManager>()
                                .getRootCategory(pupilGoals[index].competenceId)
                                .categoryName,
                            style: const TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          locator<GoalManager>().getLastCategoryStatusImage(
                              pupil, pupilGoals[index].competenceId),
                          const Gap(10),
                          Flexible(
                            child: Text(
                              locator<GoalManager>()
                                  .getGoalCategory(
                                      pupilGoals[index].competenceId)
                                  .categoryName,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          const Text('Ziel:'),
                          const Gap(10),
                          Flexible(
                            child: Text(
                              pupilGoals[index].description,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const Gap(5),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              pupilGoals[index].strategies,
                            ),
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          const Text('Erstellt von:'),
                          const Gap(10),
                          Text(
                            pupilGoals[index].createdBy,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Gap(15),
                          const Text('am'),
                          const Gap(10),
                          Text(
                            pupilGoals[index].createdAt.formatForUser(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            })
        : const SizedBox.shrink(),
    const Gap(20),
    const Row(
      children: [
        Text(
          'Status Kompetenzen',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    ...buildPupilCompetenceTree(pupil, null, 0, null, context),
    const Gap(15),
  ];
}
