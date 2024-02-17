import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_content_view.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_profile_navigation.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/pupil_set_avatar.dart';
import 'package:watch_it/watch_it.dart';

class PupilDetailsView extends WatchingWidget {
  final PupilProfileController controller;
  const PupilDetailsView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int pupilProfileNavState =
        watchValue((BottomNavManager x) => x.pupilProfileNavState);
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    final passedPupil = controller.widget.pupil;
    final pupil = pupils
        .firstWhere((element) => element.internalId == passedPupil.internalId);
    final List<Admonition> admonitions = List.from(pupil.pupilAdmonitions!);
    admonitions.sort((a, b) => b.admonishedDay.compareTo(a.admonishedDay));

    return Scaffold(
      backgroundColor: canvasColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 5, right: 5),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                onLongPressStart: (details) {
                                  final offset = details.globalPosition;
                                  final position = RelativeRect.fromLTRB(
                                      offset.dx,
                                      offset.dy,
                                      offset.dx,
                                      offset.dy);
                                  showMenu(
                                    context: context,
                                    position: position,
                                    items: [
                                      PopupMenuItem(
                                        child: const Text('Foto ersetzen'),
                                        onTap: () => setAvatar(context, pupil),
                                      ),
                                      if (pupil.avatarUrl != null)
                                        PopupMenuItem(
                                          child: const Text('Bild löschen'),
                                          onTap: () async {
                                            await controller.deleteAvatar();
                                          },
                                        ),
                                    ],
                                  );
                                },
                                child: avatarWithBadges(pupil, 100),
                              ),
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
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'FE  ${pupil.individualDevelopmentPlan}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                    const Gap(15),
                                    pupil.specialNeeds != null
                                        ? Text(
                                            '${pupil.schoolyear}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: schoolyearColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0),
                                          )
                                        : const SizedBox.shrink(),
                                    const Gap(15),
                                    if (pupil.specialInformation != null)
                                      const Icon(
                                        Icons.warning_rounded,
                                        color: Colors.red,
                                      ),
                                    if (locator<SessionManager>()
                                            .isAdmin
                                            .value ==
                                        true) ...<Widget>[
                                      const Gap(10),
                                      Text(
                                        '${pupil.internalId}',
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      )
                                    ]
                                  ],
                                ),
                                const Gap(2),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money),
                                    const Gap(5),
                                    Text(
                                      pupil.credit.toString(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    )
                                  ],
                                ),
                                const Gap(2),
                              ],
                            ),
                          )
                        ],
                      ),
                      //const Gap(10),
                      pupilProfileContentView(
                          pupil, admonitions, context, controller),
                      const Gap(60),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: pupilProfileNavigation(
                      controller,
                      pupilProfileNavState,
                      MediaQuery.of(context).size.width / 5)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: pupilProfileBottomNavBar(context)),
    );
  }
}
