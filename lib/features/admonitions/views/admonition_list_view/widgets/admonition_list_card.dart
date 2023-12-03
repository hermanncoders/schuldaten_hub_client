import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/controller/admonition_list_controller.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:watch_it/watch_it.dart';

class AdmonitionListCard extends StatelessWidget with WatchItMixin {
  final AdmonitionListController controller;
  final Pupil passedPupil;
  AdmonitionListCard(this.controller, this.passedPupil, {super.key});
  @override
  Widget build(BuildContext context) {
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    final Pupil pupil = pupils
        .where((element) => element.internalId == passedPupil.internalId)
        .first;

    return Card(
        child: Row(
      children: [
        avatarWithBadges(pupil, 80),
        Expanded(
          child: Column(
            children: [
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
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Gap(5),
              // Row(
              //   children: [
              //     const Text('Vorfälle:'),
              //     const Gap(10),
              //     Text(
              //       pupil.pupilAdmonitions?.length.toString() ?? 0.toString(),
              //       style: const TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 18,
              //       ),
              //     )
              //   ],
              // )
            ],
          ),
        ),
        SizedBox(
          width: 80,
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                const Text('Vorfälle'),
                Center(
                  child: Text(
                    pupil.pupilAdmonitions?.length.toString() ?? 0.toString(),
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
