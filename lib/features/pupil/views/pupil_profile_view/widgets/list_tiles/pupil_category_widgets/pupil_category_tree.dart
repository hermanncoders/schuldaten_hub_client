import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';

import 'package:schuldaten_hub/features/goal/models/category/goal_category.dart';
import 'package:schuldaten_hub/features/goal/models/category/pupil_category_status.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/goal/services/goal_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/goal/views/new_category_goal_view/new_category_goal_view.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/pupil_category_widgets/category_status_dialog.dart';

List<Widget> buildPupilCategoryTree(
  BuildContext context,
  Pupil pupil,
  int? parentId,
  double indentation,
  Color? backGroundColor,
) {
  List<Widget> goalCategoryWidgets = [];
  final goalLocator = locator<GoalManager>();
  List<GoalCategory> goalCategories = goalLocator.goalCategories.value;
  Color categoryBackgroundColor;

  for (var goalCategory in goalCategories) {
    if (backGroundColor == null) {
      categoryBackgroundColor =
          locator<GoalManager>().getRootCategoryColor(goalCategory) ??
              Colors.red;
    } else {
      categoryBackgroundColor = backGroundColor;
    }

    if (goalCategory.parentCategory == parentId) {
      final children = buildPupilCategoryTree(
        context,
        pupil,
        goalCategory.categoryId,
        indentation + 15,
        categoryBackgroundColor,
      );

      goalCategoryWidgets.add(
        Padding(
          padding: EdgeInsets.only(top: 10, left: indentation),
          child: children.isNotEmpty
              ? Wrap(
                  children: [
                    Card(
                      color: categoryBackgroundColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        textColor: Colors.white,
                        maintainState: false,
                        backgroundColor: categoryBackgroundColor,
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 10),
                          child: InkWell(
                            onTap: () => categoryStatusDialog(
                                pupil, goalCategory.categoryId, context),
                            onLongPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => NewCategoryGoalView(
                                  pupilId: pupil.internalId,
                                  goalCategoryId: goalCategory.categoryId,
                                ),
                              ));
                            },
                            child: Container(
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                color: locator<GoalManager>()
                                    .getCategoryStatusColor(
                                        pupil, goalCategory.categoryId),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      goalCategory.categoryName,
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              locator<GoalManager>().getCategoryStatusComment(
                                  pupil, goalCategory.categoryId),
                            ],
                          ),
                        ),
                        collapsedBackgroundColor: categoryBackgroundColor,
                        children: children,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () => categoryStatusDialog(
                                  pupil, goalCategory.categoryId, context),
                              onLongPress: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => NewCategoryGoalView(
                                    pupilId: pupil.internalId,
                                    goalCategoryId: goalCategory.categoryId,
                                  ),
                                ));
                              },
                              child: Container(
                                width: 20.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  color: locator<GoalManager>()
                                      .getCategoryStatusColor(
                                          pupil, goalCategory.categoryId),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          const Gap(5),
                          Flexible(
                            child: InkWell(
                              onLongPress: () async {
                                if (pupil.pupilCategoryStatuses!.isEmpty) {
                                  return;
                                }
                                final bool? delete = await confirmationDialog(
                                    context,
                                    'Kategoriestatus löschen',
                                    'Kategoriestatus löschen?');
                                if (delete == true) {
                                  final PupilCategoryStatus? categoryStatus =
                                      pupil.pupilCategoryStatuses!
                                          .lastWhereOrNull((element) =>
                                              element.goalCategoryId ==
                                              goalCategory.categoryId);
                                  await locator<GoalManager>()
                                      .deleteCategoryStatus(
                                          categoryStatus!.statusId);
                                }
                                return;
                              },
                              child: Text(
                                goalCategory.categoryName,
                                maxLines: 4,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      locator<GoalManager>().getCategoryStatusComment(
                          pupil, goalCategory.categoryId),
                    ],
                  ),
                ),
        ),
      );
    }
  }

  return goalCategoryWidgets;
}
