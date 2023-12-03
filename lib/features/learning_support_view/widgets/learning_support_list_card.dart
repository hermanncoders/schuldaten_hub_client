import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/goal/services/goal_manager.dart';
import 'package:schuldaten_hub/features/learning_support_view/controller/learning_support_list_controller.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:watch_it/watch_it.dart';

class LearningSupportCard extends WatchingWidget {
  final LearningSupportListController controller;
  final Pupil passedPupil;
  const LearningSupportCard(this.controller, this.passedPupil, {super.key});
  @override
  Widget build(BuildContext context) {
    Pupil pupil = watchValue((PupilFilterManager x) => x.filteredPupils)
        .where((element) => element.internalId == passedPupil.internalId)
        .first;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.white,
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          avatarWithBadges(pupil, 80),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(15),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PupilProfile(
                                pupil,
                              ),
                            ));
                          },
                          child: Text(
                            '${pupil.firstName!} ${pupil.lastName!}',
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Text('FörderSchwerpunkt:'),
                    const Gap(10),
                    Text(
                      pupil.specialNeeds != null
                          ? pupil.specialNeeds!.length == 4
                              ? '${pupil.specialNeeds!.substring(0, 2)} ${pupil.specialNeeds!.substring(2, 4)}'
                              : pupil.specialNeeds!.substring(0, 2)
                          : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Text('ärztl. U.:'),
                    const Gap(10),
                    Text(
                      controller.preschoolRevision(pupil.preschoolRevision!),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                if (pupil.pupilGoals!.isNotEmpty) const Gap(5),
                if (pupil.pupilGoals!.isNotEmpty)
                  Row(
                    children: [
                      const Text('Ziele:'),
                      const Gap(10),
                      Container(
                        width: 12.0,
                        height: 12.0,
                        decoration: BoxDecoration(
                          color: locator<GoalManager>().getRootCategoryColor(
                              locator<GoalManager>().getRootCategory(
                                  pupil.pupilGoals![0].goalCategoryId)),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Gap(5),
                      Text(
                        pupil.pupilGoals![0].description ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                if (pupil.pupilGoals!.isNotEmpty) const Gap(10),
              ],
            ),
          ),
          const Gap(20),
          Column(
            children: [
              const Gap(20),
              const Text('Ebene'),
              Center(
                child: Text(
                  pupil.individualDevelopmentPlan.toString(),
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
