import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/list_tiles/enrollment_list_tiles.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/list_tiles/group_list_tiles.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/list_tiles/languages_list_tiles.dart';
// ignore: directives_ordering
import 'package:schuldaten_hub/features/statistics/statistics_view/controller/statistics.dart';

class StatisticsView extends StatelessWidget {
  final StatisticsController controller;
  const StatisticsView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text('Statistik'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: Column(
              children: [
                const Gap(15),
                const Row(
                  children: [
                    Text(
                      'Schulzahlen',
                      style: title,
                    )
                  ],
                ),
                const Gap(10),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(children: [
                    groupListTiles(context, controller),
                    languagesListTiles(context, controller),
                    enrollmentListTiles(context, controller)
                  ]),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
