import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/learning_support/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/features/learning_support/services/learning_support_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

List<Widget> pupilCategoryStatusesList(Pupil pupil, BuildContext context) {
  if (pupil.pupilCategoryStatuses != null) {
    List<Widget> statusesWidgetList = [];

    Map<int, List<PupilCategoryStatus>> statusesWithDuplicateGoalCategory = {};
    for (PupilCategoryStatus status in pupil.pupilCategoryStatuses!) {
      if (pupil.pupilCategoryStatuses!.any((element) =>
          element.goalCategoryId == status.goalCategoryId &&
          pupil.pupilCategoryStatuses!.indexOf(element) !=
              pupil.pupilCategoryStatuses!.indexOf(status))) {
        //- This one is duplicate. Adding a key / widget in the map
        if (!statusesWithDuplicateGoalCategory
            .containsKey(status.goalCategoryId)) {
          statusesWithDuplicateGoalCategory[(status.goalCategoryId)] =
              List<PupilCategoryStatus>.empty(growable: true);
          statusesWithDuplicateGoalCategory[(status.goalCategoryId)]!
              .add(status);
        } else {
          statusesWithDuplicateGoalCategory[(status.goalCategoryId)]!
              .add(status);
        }
        debug.warning('Adding ${status.comment}');
      } else {
        //- GECHECKT
        //- This one is returning a unique status category
        statusesWidgetList.add(
          Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: locator<GoalManager>().getRootCategoryColor(
                              locator<GoalManager>().getRootCategory(
                                status.goalCategoryId,
                              ),
                            ),
                          ),
                          child: Wrap(
                            children: [
                              ...categoryTreeAncestorsNames(
                                status.goalCategoryId,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: const BoxDecoration(
                            color: interactiveColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              getGoalsForCategory(pupil, status.goalCategoryId)
                                  .length
                                  .toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                  ],
                ),
                statusEntry(pupil, status),
              ],
            ),
          ),
        );
      }
    }
    //- Now let's build the statuses with multiple entries for a category
    if (statusesWithDuplicateGoalCategory.isNotEmpty) {
      for (int key in statusesWithDuplicateGoalCategory.keys) {
        debug.warning('KEY: $key');
        List<PupilCategoryStatus> mappedStatusesWithSameGoalCategory = [];

        mappedStatusesWithSameGoalCategory =
            statusesWithDuplicateGoalCategory[key]!;

        statusesWidgetList.add(
          Card(
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: locator<GoalManager>().getRootCategoryColor(
                            locator<GoalManager>().getRootCategory(
                              key,
                            ),
                          ),
                        ),
                        child: Wrap(
                          children: [
                            ...categoryTreeAncestorsNames(
                              key,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: const BoxDecoration(
                          color: interactiveColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            getGoalsForCategory(pupil, key).length.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                ],
              ),
              for (int i = 0;
                  i < mappedStatusesWithSameGoalCategory.length;
                  i++) ...<Widget>[
                statusEntry(pupil, mappedStatusesWithSameGoalCategory[i]),
              ]
            ]),
          ),
        );
      }
    }
    return statusesWidgetList;
  }
  return [];
}

Widget statusEntry(Pupil pupil, PupilCategoryStatus status) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                color: locator<GoalManager>()
                    .getCategoryStatusColor(pupil, status.goalCategoryId),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(status.comment),
            Row(
              children: [
                Text(status.createdBy,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const Gap(5),
                Text(status.createdAt.formatForUser()),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
