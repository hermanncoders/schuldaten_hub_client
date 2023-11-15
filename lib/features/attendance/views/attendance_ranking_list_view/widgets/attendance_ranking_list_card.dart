import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/controller/attendance_ranking_list_controller.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/badges.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingListCard extends WatchingWidget {
  final AttendanceRankingListController controller;
  final Pupil passedPupil;
  const AttendanceRankingListCard(this.controller, this.passedPupil,
      {super.key});
  @override
  Widget build(BuildContext context) {
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    final Pupil pupil = pupils
        .where((element) => element.internalId == passedPupil.internalId)
        .first;

    return Card(
      elevation: 1.0,
      margin:
          const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PupilProfile(pupil),
            )),
            child: Column(
              children: [
                avatarWithBadges(pupil, 80),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      '${pupil.firstName!} ${pupil.lastName!}',
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Row(children: [
                    missedTypeBadge('missed'),
                    const Gap(5),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        locator<AttendanceManager>()
                            .missedclassSum(pupil)
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const Gap(5),
                    excusedBadge(true),
                    const Gap(5),
                    Text(
                      locator<AttendanceManager>()
                          .missedclassUnexcusedSum(pupil)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(5),
                    missedTypeBadge('late'),
                    const Gap(5),
                    Text(
                      locator<AttendanceManager>()
                          .lateUnexcusedSum(pupil)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(5),
                    contactedBadge(1),
                    const Gap(5),
                    Text(
                      locator<AttendanceManager>()
                          .contactedSum(pupil)
                          .toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Gap(10),
                  ]),
                ],
              )),
        ],
      ),
    );
  }
}
