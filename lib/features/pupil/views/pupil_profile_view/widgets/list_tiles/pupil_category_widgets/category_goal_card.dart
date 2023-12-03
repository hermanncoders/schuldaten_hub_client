import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/features/goal/services/goal_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

Widget categoryGoalCard(BuildContext context, Pupil pupil, int index) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(25.0),
    child: InkWell(
      onLongPress: () async {
        final bool? delete = await confirmationDialog(
            context, 'Förderziel löschen', 'Förderziel löschen?');
        if (delete == true) {
          await locator<GoalManager>()
              .deleteGoal(pupil.pupilGoals![index].goalId);
          return;
        }
        return;
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 17.0,
                    height: 17.0,
                    decoration: BoxDecoration(
                      color: locator<GoalManager>().getRootCategoryColor(
                          locator<GoalManager>().getRootCategory(
                              pupil.pupilGoals![index].goalCategoryId)),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    locator<GoalManager>()
                        .getRootCategory(
                            pupil.pupilGoals![index].goalCategoryId)
                        .categoryName,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Gap(5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      width: 17.0,
                      height: 17.0,
                      decoration: BoxDecoration(
                        color: locator<GoalManager>().getCategoryStatusColor(
                            pupil, pupil.pupilGoals![index].goalCategoryId),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Flexible(
                    child: Text(
                      locator<GoalManager>()
                          .getGoalCategory(
                              pupil.pupilGoals![index].goalCategoryId)
                          .categoryName,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
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
                      pupil.pupilGoals![index].description!,
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
                      pupil.pupilGoals![index].strategies!,
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
                    pupil.pupilGoals![index].createdBy,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(15),
                  const Text('am'),
                  const Gap(10),
                  Text(
                    pupil.pupilGoals![index].createdAt.formatForUser(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
