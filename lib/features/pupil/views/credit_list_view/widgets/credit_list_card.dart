import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/credit_list_view/controller/credit_list_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/credit_list_view/widgets/change_credit_dialog.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:watch_it/watch_it.dart';

class CreditListCard extends StatelessWidget with WatchItMixin {
  final CreditListController controller;
  final Pupil passedPupil;
  CreditListCard(this.controller, this.passedPupil, {super.key});
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
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Text('bisjetzt verdient:'),
                            const Gap(10),
                            Text(
                              pupil.creditEarned.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(20),
          InkWell(
            onTap: () async => changeCreditDialog(context, pupil),
            child: Column(
              children: [
                const Gap(20),
                const Text('Credit'),
                Center(
                  child: Text(
                    pupil.credit.toString(),
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
