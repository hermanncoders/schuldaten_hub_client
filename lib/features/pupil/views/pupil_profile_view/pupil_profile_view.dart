import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/authorization_tile.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/credit_tile.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/info_list_tile.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/language_list_tile.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/learning_support_tile.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/learning_tile.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/missed_class_list_tile.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/ogs_list_tile.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/list_tiles/school_list_tile.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_set_avatar.dart';
import 'package:watch_it/watch_it.dart';

class PupilDetailsView extends WatchingWidget {
  final PupilProfileController controller;
  const PupilDetailsView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    final passedPupil = controller.widget.pupil;
    final pupil = pupils
        .firstWhere((element) => element.internalId == passedPupil.internalId);
    List<MissedClass> missedClasses = pupil.pupilMissedClasses!;
    return Scaffold(
      backgroundColor: canvasColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 5, right: 15),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          InkWell(
                              onLongPress: () => setAvatar(context, pupil),
                              // onTap: () => showImageViewer(
                              //     context,
                              //     Image.network(
                              //             "https://picsum.photos/id/1001/4912/3264")
                              //         .image,
                              //     swipeDismissible: true,
                              //     doubleTapZoomable: true),
                              child: avatarWithBadges(pupil, 140)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Align(
                                  child: Text(
                                    '${pupil.firstName}',
                                    //textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${pupil.lastName} ',
                                  //textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${pupil.group}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: groupColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                const Gap(15),
                                Text(
                                  '${pupil.schoolyear}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: schoolyearColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                const Gap(15),
                                const Text('id:'),
                                const Gap(5),
                                Text(
                                  '${pupil.internalId}',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                )
                              ],
                            ),
                            const Gap(2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Guthaben: ${pupil.credit}',
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const Gap(2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'verdient: ${pupil.creditEarned}',
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                  pupil.specialInformation != null
                      ? Row(
                          children: [
                            const Icon(
                              Icons.warning_rounded,
                              color: Colors.red,
                              size: 40,
                            ),
                            const Gap(5),
                            Flexible(
                              child: Text(
                                '${pupil.specialInformation}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          infoListTiles(pupil, context),
                          languageListTiles(pupil),
                          creditTiles(pupil, context),
                          missedClasses.isNotEmpty
                              ? missedClassMissedTiles(pupil, context)
                              : const Text(
                                  'Keine Fehlzeiten!',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                          pupil.ogs == true
                              ? ogsListTiles(pupil, context)
                              : const SizedBox.shrink(),
                          pupilSchoolListTiles(pupil),
                          pupilAuthorizationListTiles(pupil),
                          learningSupportTiles(pupil, context),
                          learningTiles(pupil, context),
                          const Gap(50)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: pupilProfileBottomNavBar(context),
    );
  }
}
