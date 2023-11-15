import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:schuldaten_hub/features/goal/models/category/goal_category.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/goal/services/goal_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/goal/views/new_category_goal_view/new_category_goal_view.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/pupil_category_status_widgets/category_status_dialog.dart';

List<Widget> buildPupilCategoryTree(Pupil pupil, int? parentId,
    double indentation, Color? backGroundColor, BuildContext context) {
  List<Widget> goalCategoryWidgets = [];
  final goalLocator = locator<GoalManager>();
  List<GoalCategory> goalCategories = goalLocator.goalCategories.value;
  Color categoryBackgroundColor = backGroundColor ?? Colors.blue;

  for (var goalCategory in goalCategories) {
    if (backGroundColor == null) {
      if (goalCategory.categoryName == 'Körper, Wahrnehmung, Motorik') {
        categoryBackgroundColor = const Color.fromARGB(255, 156, 76, 149);
      } else if (goalCategory.categoryName ==
          'Sozialkompetenz / Emotionalität') {
        categoryBackgroundColor = const Color.fromARGB(255, 233, 127, 22);
      } else if (goalCategory.categoryName == 'Mathematik') {
        categoryBackgroundColor = const Color.fromARGB(255, 5, 118, 172);
      } else if (goalCategory.categoryName == 'Lernen und Leisten') {
        categoryBackgroundColor = const Color.fromARGB(255, 5, 155, 88);
      } else if (goalCategory.categoryName == 'Deutsch') {
        categoryBackgroundColor = const Color.fromARGB(255, 228, 70, 60);
      } else if (goalCategory.categoryName == 'Sprache und Sprechen') {
        categoryBackgroundColor = const Color.fromARGB(255, 244, 198, 17);
      }
    } else {
      categoryBackgroundColor = backGroundColor;
    }

    if (goalCategory.parentCategory == parentId) {
      final children = buildPupilCategoryTree(pupil, goalCategory.categoryId,
          indentation + 15, categoryBackgroundColor, context);

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
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.zero,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedTextColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        textColor: Colors.white,
                        maintainState: true,
                        backgroundColor: categoryBackgroundColor,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () => categoryStatusDialog(pupil,
                                          goalCategory.categoryId, context),
                                      onLongPress: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (ctx) => NewCategoryGoalView(
                                            pupilId: pupil.internalId,
                                            goalCategoryId:
                                                goalCategory.categoryId,
                                          ),
                                        ));
                                      },
                                      child: Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: BoxDecoration(
                                          color: locator<GoalManager>()
                                              .getCategoryStatusColor(pupil,
                                                  goalCategory.categoryId),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
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
