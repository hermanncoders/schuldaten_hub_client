import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/display_dialog.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/badges.dart';

missedClassMissedTiles(Pupil pupil, context) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        title: const Text(
          'Fehlzeiten',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupil.pupilMissedClasses!.length,
            itemBuilder: (BuildContext context, int index) {
              // pupil.pupilMissedClasses.sort(
              //     (a, b) => a.missedDay.compareTo(b.missedDay));

              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    //- TO-DO: change missed class function
                    //- like _changeMissedClassHermannpupilPage
                  },
                  onLongPress: () async {
                    await locator<AttendanceManager>().deleteMissedClass(
                        pupil.internalId,
                        pupil.pupilMissedClasses![index].missedDay);
                    if (context.mounted) {
                      displayDialog(context, 'Fehlzeit gelöscht',
                          'Die Fehlzeit wurden gelöscht!');
                    }
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          DateFormat('dd.MM.yyyy')
                              .format(
                                  pupil.pupilMissedClasses![index].missedDay)
                              .toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Gap(5),
                        missedTypeBadge(
                            pupil.pupilMissedClasses![index].missedType),
                        excusedBadge(pupil.pupilMissedClasses![index].excused),
                        contactedDayBadge(
                            pupil.pupilMissedClasses![index].contacted),
                        returnedBadge(
                            pupil.pupilMissedClasses![index].returned),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Gap(5),
                                if (pupil.pupilMissedClasses![index]
                                        .missedType ==
                                    'late')
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                        text: TextSpan(
                                      text: 'Verspätung: ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '${pupil.pupilMissedClasses![index].minutesLate!} min')
                                      ],
                                    )),
                                  ),
                                if (pupil.pupilMissedClasses![index].returned ==
                                    true)
                                  RichText(
                                      text: TextSpan(
                                    text: 'abgeholt um: ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: pupil.pupilMissedClasses![index]
                                              .returnedAt)
                                    ],
                                  )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Gap(5),
                                const Text('erstellt von'),
                                const Gap(5),
                                Text(
                                  pupil.pupilMissedClasses![index].createdBy,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Gap(5),
                                if (pupil.pupilMissedClasses![index]
                                        .modifiedBy !=
                                    null)
                                  const Text('zuletzt geändert von'),
                                if (pupil.pupilMissedClasses![index]
                                        .modifiedBy !=
                                    null)
                                  Text(
                                    pupil.pupilMissedClasses![index].createdBy,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ]),
  );
}
