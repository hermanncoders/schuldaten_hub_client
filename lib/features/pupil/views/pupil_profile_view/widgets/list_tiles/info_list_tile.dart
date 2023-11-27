import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';

infoListTiles(Pupil pupil, context) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
      iconColor: backgroundColor,
      tilePadding: const EdgeInsets.all(0),
      title: const Row(
        children: [
          // Icon(
          //   Icons.info_rounded,
          //   color: backgroundColor,
          // ),
          Gap(10),
          Text(
            'Infos',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      children: [
        Row(
          children: [
            const Text('Geschlecht:', style: TextStyle(fontSize: 18.0)),
            const Gap(10),
            Text(pupil.gender! == 'm' ? 'männlich' : 'weiblich',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold))
          ],
        ),
        const Gap(10),
        Row(
          children: [
            const Text('Geburtsdatum:', style: TextStyle(fontSize: 18.0)),
            const Gap(10),
            Text(pupil.birthday!.formatForUser(),
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold))
          ],
        ),
        const Gap(10),
        Row(
          children: [
            const Text('Aufnahmedatum:', style: TextStyle(fontSize: 18.0)),
            const Gap(10),
            Text(pupil.pupilSince!.formatForUser(),
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold))
          ],
        ),
        const Gap(10),
        locator<PupilManager>().siblings(pupil).isNotEmpty
            ? const Row(
                children: [
                  Text(
                    'Geschwister:',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        locator<PupilManager>().siblings(pupil).isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(left: 10, top: 5, bottom: 15),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: locator<PupilManager>().siblings(pupil).length,
                itemBuilder: (context, int index) {
                  Pupil sibling =
                      locator<PupilManager>().siblings(pupil)[index];
                  return Column(
                    children: [
                      const Gap(5),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => PupilProfile(
                              sibling,
                            ),
                          ));
                        },
                        child: Row(
                          children: [
                            avatarImage(sibling, 30),
                            const Gap(10),
                            Text(
                              sibling.firstName!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap(10),
                            Text(
                              sibling.lastName!,
                              style: const TextStyle(),
                            ),
                            const Gap(20),
                            Text(
                              sibling.group!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: groupColor),
                            ),
                            const Gap(20),
                            Text(
                              sibling.schoolyear!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: schoolyearColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                })
            : const SizedBox.shrink(),
      ],
    ),
  );
}
