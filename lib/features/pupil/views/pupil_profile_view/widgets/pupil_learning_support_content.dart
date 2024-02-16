import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/dialogs/individual_development_plan_dialog.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/dialogs/preschool_revision_dialog.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/pupil_category_widgets/category_goal_card.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/pupil_category_widgets/pupil_category_tree.dart';

List<Widget> pupilLearningSupportContentList(
    Pupil pupil, BuildContext context) {
  return [
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
          onTap: () =>
              preschoolRevisionDialog(context, pupil, pupil.preschoolRevision!),
          child: Text(
            preschoolRevisionPredicate(pupil.preschoolRevision!),
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        )
      ],
    ),
    const Gap(10),
    Row(
      children: [
        const Text('Förderebene:', style: TextStyle(fontSize: 15.0)),
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
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: backgroundColor),
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              return categoryGoalCard(context, pupil, index);
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
  ];
}
