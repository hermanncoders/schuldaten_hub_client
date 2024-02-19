import 'package:flutter/material.dart';

import 'package:schuldaten_hub/features/learning_support/services/goal_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/learning_support/views/new_category_goal_view/new_category_goal_view.dart';

class NewCategoryGoal extends StatefulWidget {
  final String appBarTitle;
  final int pupilId;
  final int goalCategoryId;

  const NewCategoryGoal(
      {super.key,
      required this.appBarTitle,
      required this.pupilId,
      required this.goalCategoryId});

  @override
  NewCategoryGoalController createState() => NewCategoryGoalController();
}

class NewCategoryGoalController extends State<NewCategoryGoal> {
  final TextEditingController textField1Controller = TextEditingController();
  final TextEditingController textField2Controller = TextEditingController();
  int? goalCategoryId;
  void setGoalCategoryId(int id) {
    setState(() {
      goalCategoryId = id;
    });
  }

  Future postCategoryGoal() async {
    if (goalCategoryId == null) {
      return;
    }
    String text1 = textField1Controller.text;
    String text2 = textField2Controller.text;

    await locator<GoalManager>()
        .postNewCategoryGoal(goalCategoryId!, widget.pupilId, text1, text2);
  }

  @override
  Widget build(BuildContext context) {
    return NewCategoryGoalView(this);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the tree
    textField1Controller.dispose();
    textField2Controller.dispose();
    super.dispose();
  }
}
