import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';

double boxHeight = 35;
Widget pupilProfileNavigation(
    PupilProfileController controller, double boxWidth) {
  return Theme(
    data: Theme.of(controller.context).copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ))),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //- Information Button - top left border radius
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                      ),
                    ),
                    backgroundColor: controller.navigationBackgroundColor(0),
                  ),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 0) return;
                    controller.changeNavState(0);
                  },
                  child: Icon(
                    Icons.info_rounded,
                    color: controller.pupilProfileNavState == 0
                        ? backgroundColor
                        : Colors.white,
                  ),
                ),
              ),
              //- Language Button
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: controller.navigationBackgroundColor(1),
                  ),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 1) return;
                    controller.changeNavState(1);
                  },
                  child: Icon(
                    Icons.language_rounded,
                    color: controller.pupilProfileNavState == 1
                        ? groupColor
                        : Colors.white,
                  ),
                ),
              ),
              //- Credit Button
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: controller.navigationBackgroundColor(2),
                  ),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 2) return;
                    controller.changeNavState(2);
                  },
                  child: Icon(
                    Icons.attach_money_rounded,
                    color: controller.pupilProfileNavState == 2
                        ? accentColor
                        : Colors.white,
                  ),
                ),
              ),
              //- Attendance Button
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: controller.navigationBackgroundColor(3),
                  ),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 3) return;
                    controller.changeNavState(3);
                  },
                  child: Icon(
                    Icons.calendar_month_rounded,
                    color: controller.pupilProfileNavState == 3
                        ? Colors.grey[800]
                        : Colors.white,
                  ),
                ),
              ),
              //- Admonition Button - bottom right border radius
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            10.0), // Adjust the radius as needed
                      ),
                    ),
                    backgroundColor: controller.navigationBackgroundColor(4),
                  ),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 4) return;
                    controller.changeNavState(4);
                  },
                  child: Icon(
                    Icons.warning_rounded,
                    color: controller.pupilProfileNavState == 4
                        ? accentColor
                        : Colors.white,
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //- OGS Button
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero),
                    backgroundColor: controller.navigationBackgroundColor(5),
                  ),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 5) return;
                    controller.changeNavState(5);
                  },
                  child: Text(
                    'OGS',
                    style: TextStyle(
                        color: controller.pupilProfileNavState == 5
                            ? backgroundColor
                            : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //- Lists Button
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor: controller.navigationBackgroundColor(6)),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 6) return;
                    controller.changeNavState(6);
                  },
                  child: Icon(
                    Icons.rule,
                    color: controller.pupilProfileNavState == 6
                        ? Colors.grey[600]
                        : Colors.white,
                  ),
                ),
              ),
              //- Authorization Button
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor: controller.navigationBackgroundColor(7)),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 7) return;
                    controller.changeNavState(7);
                  },
                  child: Icon(
                    Icons.fact_check_rounded,
                    color: controller.pupilProfileNavState == 7
                        ? Colors.grey[600]
                        : Colors.white,
                  ),
                ),
              ),
              //- Learning supporn button
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor: controller.navigationBackgroundColor(8)),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 8) return;
                    controller.changeNavState(8);
                  },
                  child: Icon(
                    Icons.support_rounded,
                    color: controller.pupilProfileNavState == 8
                        ? const Color.fromARGB(255, 245, 75, 75)
                        : Colors.white,
                  ),
                ),
              ),
              //- Learning Button - bottom right border radius
              SizedBox(
                width: boxWidth,
                height: boxHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      backgroundColor: controller.navigationBackgroundColor(9)),
                  onPressed: () {
                    if (controller.pupilProfileNavState == 9) return;
                    controller.changeNavState(9);
                  },
                  child: Icon(
                    Icons.lightbulb,
                    color: controller.pupilProfileNavState == 9
                        ? accentColor
                        : Colors.white,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );

  // return SegmentedButton(segments: [
  //   ButtonSegment(
  //     value: 1,
  //     label: Text(
  //       'Info',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  //   ButtonSegment(
  //     value: 2,
  //     label: Text(
  //       'Sprache',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  //   ButtonSegment(
  //     value: 3,
  //     label: Text(
  //       'Guthaben',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  //   ButtonSegment(
  //     value: 4,
  //     label: Text(
  //       'Vorfälle',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  //   ButtonSegment(
  //     value: 5,
  //     label: Text(
  //       'Fehlzeiten',
  //       style: _buttonTextStyle,
  //     ),
  //     icon: const Icon(
  //       Icons.info_rounded,
  //       color: backgroundColor,
  //     ),
  //   ),
  // ], selected: const {
  //   2
  // });
}
