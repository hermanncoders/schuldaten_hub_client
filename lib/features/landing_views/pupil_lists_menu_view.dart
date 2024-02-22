import 'dart:io';

import 'package:flutter/material.dart';

import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/features/landing_views/pupil_lists_buttons.dart';

class PupilMenuView extends StatefulWidget {
  const PupilMenuView({super.key});

  @override
  State<PupilMenuView> createState() => _PupilMenuViewState();
}

class _PupilMenuViewState extends State<PupilMenuView> {
  double screenWidth = 0;
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
          width: Platform.isWindows ? 750 : 380,
          height: Platform.isWindows ? 400 : 800,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: Platform.isWindows ? 4 : 2,
              padding: const EdgeInsets.all(20),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ...pupilListButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
