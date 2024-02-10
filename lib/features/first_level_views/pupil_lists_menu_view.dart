import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/controller/admonition_list_controller.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/controller/attendance_ranking_list_controller.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/controller/attendance_list_controller.dart';
import 'package:schuldaten_hub/features/learning_support_view/controller/learning_support_list_controller.dart';
import 'package:schuldaten_hub/features/ogs_view/controller/ogs_list_controller.dart';

import 'package:schuldaten_hub/features/pupil/views/credit_list_view/controller/credit_list_controller.dart';
import 'package:schuldaten_hub/features/special_info_view/controller/special_info_controller.dart';

class PupilMenuView extends StatelessWidget {
  const PupilMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Kinderlisten'),
      ),
      body: Center(
        child: SizedBox(
          width: Platform.isWindows ? 570 : 380,
          height: Platform.isWindows ? 380 : 800,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: Platform.isWindows ? 3 : 2,
              padding: const EdgeInsets.all(20),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const AdmonitionList(),
                      ));
                    },
                    child: Card(
                      color: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning_rounded,
                            size: 50,
                            color: gridViewColor,
                          ),
                          Gap(10),
                          Text(
                            'Vorfälle',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const AttendanceRankingList(),
                      ));
                    },
                    child: Card(
                      color: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 50,
                            color: gridViewColor,
                          ),
                          Gap(10),
                          Text(
                            'Fehlzeiten',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const AttendanceList(),
                      ));
                    },
                    child: Card(
                      color: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.rule,
                            size: 50,
                            color: gridViewColor,
                          ),
                          Gap(10),
                          Text(
                            'Anwesenheit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const CreditList(),
                      ));
                    },
                    child: Card(
                      color: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            size: 50,
                            color: gridViewColor,
                          ),
                          Gap(10),
                          Text(
                            'Konto',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (ctx) => CategoryList(),
                        // ));
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lightbulb,
                            size: 50,
                            color: gridViewColor,
                          ),
                          Gap(10),
                          Text(
                            'Lernen',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    color: backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const LearningSupportList(),
                        ));
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.support_rounded,
                            size: 50,
                            color: gridViewColor,
                          ),
                          Gap(10),
                          Text(
                            'Fördern',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const SpecialInfoList(),
                      ));
                    },
                    child: Card(
                      color: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emergency_rounded,
                            size: 50,
                            color: gridViewColor,
                          ),
                          Gap(10),
                          Text(
                            'Besondere Infos',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const OgsList(),
                      ));
                    },
                    child: Card(
                      color: backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'OGS',
                            style: TextStyle(
                                fontSize: 35,
                                color: gridViewColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Gap(10),
                          Text(
                            'OGS',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
