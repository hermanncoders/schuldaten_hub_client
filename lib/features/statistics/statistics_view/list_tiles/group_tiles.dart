import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/controller/statistics.dart';

groupTiles(context, StatisticsController controller, List<Pupil> group) {
  String groupString = group[0].group!;
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        title: Row(
          children: [
            Text(
              groupString,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Gap(10),
            const Text(
              'insgesamt:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const Gap(10),
            Text(
              group.length.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Gap(20),
            const Text(
              'davon OGS:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const Gap(10),
            Text(
              controller.pupilsInOGS(group).length.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Row(
              children: [
                const Text(
                  'davon E1:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Gap(10),
                Text(
                  controller
                      .schoolyearInaGivenGroup(group, 'E1')
                      .length
                      .toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Gap(20),
                const Text(
                  'E2:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Gap(10),
                Text(
                  controller
                      .schoolyearInaGivenGroup(group, 'E2')
                      .length
                      .toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Gap(20),
                const Text(
                  'E3:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Gap(10),
                Text(
                  controller
                      .schoolyearInaGivenGroup(group, 'E3')
                      .length
                      .toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Gap(20),
                const Text(
                  'S3:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Gap(10),
                Text(
                  controller
                      .schoolyearInaGivenGroup(group, 'S3')
                      .length
                      .toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Gap(20),
                const Text(
                  'S4:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Gap(10),
                Text(
                  controller
                      .schoolyearInaGivenGroup(group, 'S4')
                      .length
                      .toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          const Gap(5),
          Padding(
            padding: const EdgeInsets.only(left: 35.0),
            child: Row(
              children: [
                const Text(
                  'in Erstförderung:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Gap(10),
                Text(
                  controller.pupilsWithLanguageSupport(group).length.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Gap(10),
                const Text(
                  'waren in Erstförderung:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Gap(10),
                Text(
                  controller.pupilsHadLanguageSupport(group).length.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          )
        ]),
  );
}
