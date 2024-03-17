import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:watch_it/watch_it.dart';

class BirthdaysView extends WatchingWidget {
  const BirthdaysView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Pupil> pupils = pupilsWithBirthdayInTheLastSevenDays();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Text('Geburtstage'),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                      padding:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 15),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pupils.length,
                      itemBuilder: (context, int index) {
                        Pupil listedPupil = pupils[index];
                        return Column(
                          children: [
                            const Gap(5),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => PupilProfile(
                                    listedPupil,
                                  ),
                                ));
                              },
                              child: Row(
                                children: [
                                  avatarImage(listedPupil, 30),
                                  const Gap(10),
                                  Text(
                                    listedPupil.firstName!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Gap(10),
                                  Text(
                                    listedPupil.lastName!,
                                    style: const TextStyle(),
                                  ),
                                  const Gap(20),
                                  Text(
                                    listedPupil.group!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: groupColor),
                                  ),
                                  const Gap(20),
                                  Text(
                                    listedPupil.schoolyear!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: schoolyearColor),
                                  ),
                                  const Gap(20),
                                  Text(
                                    listedPupil.birthday!.formatForUser(),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
          )
        ]));
  }
}
