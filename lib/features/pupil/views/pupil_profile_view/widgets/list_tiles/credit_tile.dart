import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'package:schuldaten_hub/features/pupil/models/credit_history_log.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

creditTiles(Pupil pupil, context) {
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        title: const Text(
          'Guthaben',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: pupil.creditHistoryLogs!.length,
            itemBuilder: (BuildContext context, int index) {
              CreditHistoryLog creditHistoryLog =
                  pupil.creditHistoryLogs![index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    //- TO-DO: change missed class function
                    //- like _changeMissedClassHermannpupilPage
                  },
                  onLongPress: () async {},
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          DateFormat('dd.MM.yyyy')
                              .format(creditHistoryLog.createdAt)
                              .toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Gap(5),
                        const Text('Betrag:'),
                        const Gap(10),
                        Text(
                          creditHistoryLog.operation.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Gap(10),
                        const Text('von:'),
                        const Gap(10),
                        Text(
                          creditHistoryLog.createdBy,
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
