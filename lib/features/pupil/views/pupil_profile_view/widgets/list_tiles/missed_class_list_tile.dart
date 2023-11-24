import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/confirmation_dialogue.dart';
import 'package:schuldaten_hub/common/widgets/display_dialog.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/badges.dart';

missedClassMissedTiles(Pupil pupil, context) {
  List<MissedClass> missedClasses = List.from(pupil.pupilMissedClasses!);
  // sort by missedDay
  missedClasses.sort((a, b) => a.missedDay.compareTo(b.missedDay));
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
            itemCount: missedClasses.length,
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
                    bool? confirm = await showConfirmationDialog(
                        context, 'Fehlzeit löschen', 'Die Fehlzeit löschen?');
                    if (confirm! == false) return;
                    await locator<AttendanceManager>().deleteMissedClass(
                        pupil.internalId, missedClasses[index].missedDay);
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
                              .format(missedClasses[index].missedDay)
                              .toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Gap(5),
                        missedTypeBadge(missedClasses[index].missedType),
                        excusedBadge(missedClasses[index].excused),
                        contactedDayBadge(missedClasses[index].contacted),
                        returnedBadge(missedClasses[index].returned),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Gap(5),
                                if (missedClasses[index].missedType == 'late')
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RichText(
                                        text: TextSpan(
                                      text: 'Verspätung: ',
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                            text:
                                                '${missedClasses[index].minutesLate ?? 0} min')
                                      ],
                                    )),
                                  ),
                                if (missedClasses[index].returned == true)
                                  RichText(
                                      text: TextSpan(
                                    text: 'abgeholt um: ',
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: missedClasses[index].returnedAt)
                                    ],
                                  )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Gap(5),
                                const Text('erstellt von: '),
                                const Gap(5),
                                Text(
                                  missedClasses[index].createdBy,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Gap(5),
                                if (missedClasses[index].modifiedBy != null)
                                  const Text('zuletzt geändert von: '),
                                if (missedClasses[index].modifiedBy != null)
                                  Text(
                                    missedClasses[index].createdBy,
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
