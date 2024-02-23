import 'dart:io';

import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/landing_views/pupil_lists_buttons.dart';

class PupilMenuView extends StatelessWidget {
  const PupilMenuView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Kinderlisten', style: appBarTextStyle),
      ),
      body: Center(
        child: SizedBox(
          width: Platform.isWindows ? 750 : 380,
          height: Platform.isWindows ? 400 : 800,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: screenWidth < 400
                  ? 2
                  : screenWidth < 700
                      ? 3
                      : 4,
              padding: const EdgeInsets.all(20),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...pupilListButtons(context, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
