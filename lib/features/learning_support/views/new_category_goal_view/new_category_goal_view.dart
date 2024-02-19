import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/learning_support/views/new_category_goal_view/controller/new_category_goal_controller.dart';
import 'package:schuldaten_hub/features/learning_support/views/selectable_category_tree_view/controller/selectable_category_tree_controller.dart';
import 'package:schuldaten_hub/features/learning_support/views/selectable_category_tree_view/selectable_category_tree_view.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_goal_card.dart';
import 'package:schuldaten_hub/features/learning_support/widgets/pupil_category_widgets/category_goal_card_banner.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';

class NewCategoryGoalView extends StatelessWidget {
  final NewCategoryGoalController controller;
  const NewCategoryGoalView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white,
        focusColor: backgroundColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text(controller.widget.appBarTitle),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: <Widget>[
                  const Row(
                    children: [
                      Text('Förderkategorie',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const Gap(10),
                  controller.goalCategoryId == null
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: backgroundColor,
                              minimumSize: const Size.fromHeight(60)),
                          onPressed: () async {
                            final int? categoryId = await Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (ctx) => SelectableCategoryTree(
                                        findPupilById(
                                            controller.widget.pupilId))));
                            if (categoryId == null) {
                              return;
                            }
                            controller.setGoalCategoryId(categoryId);
                          },
                          child: const Text('KATEGORIE AUSWÄHLEN'),
                        )
                      : categoryGoalCardBanner(controller.goalCategoryId!),
                  const Gap(15),
                  const Row(
                    children: [
                      Text('Förderziel',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const Gap(10),
                  TextField(
                    minLines: 1,
                    maxLines: 3,
                    controller: controller.textField1Controller,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: backgroundColor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: backgroundColor, width: 2),
                      ),
                      labelStyle: TextStyle(color: backgroundColor),
                      labelText: 'Beschreibung des Zieles',
                    ),
                  ),
                  const Gap(20),
                  const Row(
                    children: [
                      Text('Strategien',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const Gap(10),
                  TextField(
                    minLines: 3,
                    maxLines: 4,
                    controller: controller.textField2Controller,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: backgroundColor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: backgroundColor, width: 2),
                      ),
                      labelStyle: TextStyle(color: backgroundColor),
                      labelText: 'Hilfen für das Erreichen des Zieles',
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[800],
                        minimumSize: const Size.fromHeight(60)),
                    onPressed: () {
                      controller.postCategoryGoal();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'SENDEN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Gap(15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 235, 67, 67),
                        minimumSize: const Size.fromHeight(60)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'ABBRECHEN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
