import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/controller/statistics.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/list_tiles/group_tiles.dart';

groupListTiles(context, StatisticsController controller) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        title: Row(
          children: [
            const Text(
              'Schüler*innen insgesamt:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const Gap(10),
            Text(
              controller.pupils.length.toString(),
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
              controller.pupilsInOGS(controller.pupils).length.toString(),
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
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Row(
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
                          .schoolyearInaGivenGroup(controller.pupils, 'E1')
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
                          .schoolyearInaGivenGroup(controller.pupils, 'E2')
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
                          .schoolyearInaGivenGroup(controller.pupils, 'E3')
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
                          .schoolyearInaGivenGroup(controller.pupils, 'S3')
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
                          .schoolyearInaGivenGroup(controller.pupils, 'S4')
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
              ],
            ),
          ),
          const Gap(5),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
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
                  controller
                      .pupilsWithLanguageSupport(controller.pupils)
                      .length
                      .toString(),
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
                  controller
                      .pupilsHadLanguageSupport(controller.pupils)
                      .length
                      .toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('A1')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('A2')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('A3')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('B1')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('B2')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('B3')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('B4')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('C1')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('C2')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: groupTiles(
                context, controller, controller.pupilsInaGivenGroup('C3')),
          ),
        ]),
  );
}
