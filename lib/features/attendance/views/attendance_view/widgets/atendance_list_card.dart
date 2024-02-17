import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/controller/attendance_list_controller.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/attendance_dropdown_menu_items.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/dialogues/late_in_minutes_dialog.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/dialogues/multiple_entries_dialog.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/dialogues/returned_time_picker.dart';
import 'package:schuldaten_hub/features/first_level_views/bottom_nav_bar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

import 'package:schuldaten_hub/common/services/schoolday_manager.dart';

import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceCard extends WatchingWidget {
  final AttendanceListController controller;
  final Pupil passedPupil;
  const AttendanceCard(this.controller, this.passedPupil, {super.key});
  @override
  Widget build(BuildContext context) {
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    final Pupil pupil = pupils
        .where((element) => element.internalId == passedPupil.internalId)
        .first;
    final attendanceManager = locator<AttendanceManager>();
    DateTime thisDate = watchValue((SchooldayManager x) => x.thisDate);
    String dropdownMissedValue =
        attendanceManager.setMissedTypeValue(pupil.internalId, thisDate);
    bool? excusedValue =
        attendanceManager.setExcusedValue(pupil.internalId, thisDate);
    String dropdownContactedValue =
        attendanceManager.setContactedValue(pupil.internalId, thisDate);
    bool? returnedValue =
        attendanceManager.setReturnedValue(pupil.internalId, thisDate);
    String? createdModifiedValue(pupilId) {
      return attendanceManager.setCreatedModifiedValue(pupilId, thisDate);
    }

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
            child: GestureDetector(
              onLongPress: () => createMissedClassList(context, pupil),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => PupilProfile(
                    pupil,
                  ),
                ));
              },
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Gap(15),
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: InkWell(
                          onTap: () {
                            locator<BottomNavManager>()
                                .setPupilProfileNavPage(3);
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(20),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        icon: const Visibility(
                            visible: false, child: Icon(Icons.arrow_downward)),
                        onTap: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        value: dropdownMissedValue,
                        items: missedTypeMenuItems,
                        onChanged: (newValue) async {
                          FocusManager.instance.primaryFocus!.unfocus();
                          if (dropdownMissedValue == newValue) {
                            return;
                          }
                          if (newValue == 'late') {
                            final int minutesLate =
                                await minutesLateDialog(context);
                            attendanceManager.changeLateTypeValue(
                                pupil.internalId,
                                newValue!,
                                thisDate,
                                minutesLate);
                          } else {
                            attendanceManager.changeMissedTypeValue(
                                pupil.internalId, newValue!, thisDate);
                          }
                        },
                      ),
                    ),
                    const Gap(5),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: excusedCheckColor,
                      value: excusedValue,
                      onChanged: (bool? newvalue) {
                        attendanceManager.changeExcusedValue(
                            pupil.internalId, thisDate, newvalue!);
                      },
                    ),
                    (dropdownMissedValue == 'missed' && excusedValue == true) ||
                            dropdownContactedValue != '0' ||
                            returnedValue == true
                        ? DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward)),
                                onTap: () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                },
                                value: dropdownContactedValue,
                                items: dropdownContactedMenuItems,
                                onChanged: (newValue) {
                                  if (dropdownContactedValue == newValue ||
                                      excusedValue == false) {
                                    return;
                                  }
                                  attendanceManager.changeContactedValue(
                                      pupil.internalId, newValue!, thisDate);
                                }),
                          )
                        : Container(
                            height: 45,
                            width: 30,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                          ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: goneHomeColor,
                      value: returnedValue ?? false,
                      onChanged: (bool? newValue) async {
                        if (newValue == true) {
                          final String? returnedTime =
                              await returnedDayTime(context);
                          debug.warning('returned time : $returnedTime');
                          if (returnedTime == null) {
                            return;
                          }
                          attendanceManager.changeReturnedValue(
                              pupil.internalId,
                              newValue!,
                              thisDate,
                              returnedTime);
                          return;
                        }
                        attendanceManager.changeReturnedValue(
                            pupil.internalId, newValue!, thisDate, null);
                      },
                    ),
                  ],
                ),
                Row(children: [
                  SizedBox(
                    width: 70,
                    child: Center(
                      child: createdModifiedValue(pupil.internalId) != null
                          ? Text(
                              createdModifiedValue(pupil.internalId)!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: const BoxDecoration(
                          color: excusedCheckColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'U',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const Gap(18),
                      Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Colors.red[900],
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'K',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const Gap(19),
                      Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: const BoxDecoration(
                          color: homeColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'H',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(10),
                ])
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
