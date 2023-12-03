import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/statistics/statistics_view/controller/statistics.dart';

Widget statisticsGroupCard(StatisticsController controller, List<Pupil> group) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  const Text(
                    'E1:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const Gap(5),
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
                  const Gap(5),
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
                  const Gap(5),
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
                  const Gap(5),
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
                  const Gap(5),
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
            ],
          ),
          const Gap(5),
          Row(
            children: [
              const Text(
                'Erstförderung:',
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
                'ehem. Erstförderung:',
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
          const Gap(5),
          Row(
            children: [
              const Text(
                'a. Familiensprache:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              Text(
                controller.pupilsNotSpeakingGerman(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                'unterjährig:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              Text(
                controller.pupilsNotEnrolledOnDate(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
          const Gap(5),
          Row(
            children: [
              const Text(
                'Förderebene 1:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              Text(
                controller
                    .developmentPlan1InAGivenGroup(group)
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
                '2:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              Text(
                controller
                    .developmentPlan2InAGivenGroup(group)
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
                '3:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              Text(
                controller
                    .developmentPlan3InAGivenGroup(group)
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
                'AO-SF:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Gap(5),
              Text(
                controller.specialNeedsInAGivenGroup(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
          const Gap(5),
          Row(
            children: [
              const Text(
                'schulärzt. U.:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text('n.v.'),
              const Gap(5),
              Text(
                controller
                    .preschoolRevisionNotAvailable(group)
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text('o.B.:'),
              const Gap(5),
              Text(
                controller.preschoolRevisionOk(group).length.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(10),
              const Text(
                'Förd:',
              ),
              const Gap(5),
              Text(
                controller
                    .preschoolRevisionSupportInaGivenGroup(group)
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
                'AO-SF:',
              ),
              const Gap(5),
              Text(
                controller
                    .preschoolRevisionSpecialNeedsInaGivenGroup(group)
                    .length
                    .toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
