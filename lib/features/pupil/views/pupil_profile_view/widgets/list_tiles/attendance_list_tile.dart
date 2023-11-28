import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/display_dialog.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/widgets/badges.dart';

attendanceListTiles(Pupil pupil, context) {
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
        title: Row(
          children: [
            const Icon(
              Icons.calendar_month_rounded,
              color: backgroundColor,
            ),
            const Gap(10),
            const Text(
              'Fehlzeiten',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            excusedBadge(false),
            const Gap(3),
            Text(
              locator<AttendanceManager>().missedclassSum(pupil).toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Gap(5),
            excusedBadge(true),
            const Gap(3),
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
            const Gap(3),
            Text(
              locator<AttendanceManager>().lateUnexcusedSum(pupil).toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Gap(5),
            contactedBadge(1),
            const Gap(3),
            Text(
              locator<AttendanceManager>().contactedSum(pupil).toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Gap(5),
          ],
        ),
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(top: 5, bottom: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: missedClasses.length,
            itemBuilder: (BuildContext context, int index) {
              // pupil.pupilMissedClasses.sort(
              //     (a, b) => a.missedDay.compareTo(b.missedDay));

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      //- TO-DO: change missed class function
                      //- like _changeMissedClassHermannpupilPage
                    },
                    onLongPress: () async {
                      bool? confirm = await confirmationDialog(context,
                          'Fehlzeit löschen', 'Die Fehlzeit löschen?');
                      if (confirm! == false) return;
                      await locator<AttendanceManager>().deleteMissedClass(
                          pupil.internalId, missedClasses[index].missedDay);
                      if (context.mounted) {
                        informationDialog(context, 'Fehlzeit gelöscht',
                            'Die Fehlzeit wurden gelöscht!');
                      }
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            const Gap(3),
                            excusedBadge(missedClasses[index].excused),
                            const Gap(3),
                            contactedDayBadge(missedClasses[index].contacted),
                            const Gap(3),
                            returnedBadge(missedClasses[index].returned),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Gap(3),
                                    if (missedClasses[index].missedType ==
                                        'late')
                                      Row(
                                        children: [
                                          const Text('Verspätung:'),
                                          const Gap(5),
                                          Text(
                                              '${missedClasses[index].minutesLate ?? 0} min',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    if (missedClasses[index].returned == true)
                                      RichText(
                                          text: TextSpan(
                                        text: 'abgeholt um: ',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: missedClasses[index]
                                                  .returnedAt)
                                        ],
                                      )),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('erstellt von:'),
                            const Gap(5),
                            Text(
                              missedClasses[index].createdBy,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                  ),
                ),
              );
            },
          ),
        ]),
  );
}
