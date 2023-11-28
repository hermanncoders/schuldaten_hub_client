import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/confirmation_dialog.dart';
import 'package:schuldaten_hub/features/competence/services/competence_manager.dart';
import 'package:schuldaten_hub/features/goal/models/goal/pupil_goal.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/goal/services/goal_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/dialogs/individual_development_plan_dialog.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/dialogs/preschool_revision_dialog.dart';

import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/pupil_category_status_widgets/pupil_category_tree.dart';

learningSupportTiles(Pupil pupil, context) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      iconColor: backgroundColor,
      tilePadding: const EdgeInsets.all(0),
      title: const Row(
        children: [
          // Icon(
          //   Icons.support_rounded,
          //   color: backgroundColor,
          // ),
          // Gap(10),
          Text(
            'Förderung',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      children: [
        const Row(
          children: [
            Text(
              'Eingangsuntersuchung: ',
              style: TextStyle(fontSize: 15.0),
            ),
            Gap(5),
          ],
        ),
        const Gap(10),
        Row(
          children: [
            InkWell(
              onTap: () => preschoolRevisionDialog(
                  context, pupil, pupil.preschoolRevision!),
              child: Text(
                locator<PupilManager>()
                    .preschoolRevisionPredicate(pupil.preschoolRevision!),
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const Gap(10),
        Row(
          children: [
            const Text('Förderplan:', style: TextStyle(fontSize: 15.0)),
            const Gap(10),
            InkWell(
              onTap: () => individualDevelopmentPlanDialog(
                  context, pupil, pupil.individualDevelopmentPlan),
              child: Text(
                pupil.individualDevelopmentPlan == 0
                    ? 'kein Eintrag'
                    : pupil.individualDevelopmentPlan == 1
                        ? 'Förderebene 1'
                        : pupil.individualDevelopmentPlan == 2
                            ? 'Förderebene 2'
                            : 'Förderebene 3',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const Gap(10),
        Row(
          children: [
            const Text('Förderschwerpunkt: ', style: TextStyle(fontSize: 15.0)),
            const Gap(5),
            pupil.specialNeeds == '' || pupil.specialNeeds == null
                ? const Text(
                    'keins',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : Text(
                    '${pupil.specialNeeds}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )
          ],
        ),
        const Gap(10),
        pupil.pupilGoals!.isNotEmpty
            ? const Row(
                children: [
                  Text(
                    'Förderziele',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        pupil.pupilGoals!.isNotEmpty ? const Gap(15) : const SizedBox.shrink(),
        pupil.pupilGoals!.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pupil.pupilGoals!.length,
                itemBuilder: (context, int index) {
                  List<PupilGoal> pupilGoals = pupil.pupilGoals!;
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: InkWell(
                      onLongPress: () async {
                        final bool? delete = await confirmationDialog(context,
                            'Förderziel löschen', 'Förderziel löschen?');
                        if (delete == true) {
                          await locator<GoalManager>()
                              .deleteGoal(pupil.pupilGoals![index].goalId);
                          return;
                        }
                        return;
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 10, bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    locator<GoalManager>().getRootCategoryName(
                                        pupilGoals[index].goalCategoryId),
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  Container(
                                    width: 20.0,
                                    height: 20.0,
                                    decoration: BoxDecoration(
                                      color: locator<GoalManager>()
                                          .getCategoryStatusColor(pupil,
                                              pupilGoals[index].goalCategoryId),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const Gap(10),
                                  Flexible(
                                    child: Text(
                                      locator<GoalManager>()
                                          .getGoalCategory(
                                              pupilGoals[index].goalCategoryId)
                                          .categoryName,
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
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
                                      pupilGoals[index].description!,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      pupilGoals[index].strategies!,
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
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Gap(15),
                                  const Text('am'),
                                  const Gap(10),
                                  Text(
                                    pupilGoals[index].createdAt.formatForUser(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : const SizedBox.shrink(),
        const Gap(20),
        const Row(
          children: [
            Text(
              'Status Förderkategorien',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        ...buildPupilCategoryTree(context, pupil, null, 0, null),
        const Gap(15),
      ],
    ),
  );
}
