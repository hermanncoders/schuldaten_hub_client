import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/confirmation_dialogue.dart';
import 'package:schuldaten_hub/common/widgets/display_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/download_decrypt_image.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_manager.dart';
import 'package:schuldaten_hub/features/admonitions/views/new_admonition_view/new_admonition_view.dart';
import 'package:schuldaten_hub/features/attendance/models/missed_class.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

admonitionListTiles(Pupil pupil, context) {
  List<Admonition> admonitions = List.from(pupil.pupilAdmonitions!);
  admonitions.sort((a, b) => a.admonishedDay.compareTo(b.admonishedDay));

  List<MissedClass> missedClasses = List.from(pupil.pupilMissedClasses!);
  // sort by missedDay
  missedClasses.sort((a, b) => a.missedDay.compareTo(b.missedDay));
  return ListTileTheme(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    horizontalTitleGap: 0.0,
    minLeadingWidth: 0,
    child: ExpansionTile(
        tilePadding: const EdgeInsets.all(0),
        title: const Row(
          children: [
            // Icon(
            //   Icons.calendar_month_rounded,
            //   color: accentColor,
            // ),
            // Gap(10),
            Text(
              'Vorfälle',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        children: [
          ListView.builder(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 15),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: admonitions.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    //- TO-DO: change missed class function
                  },
                  onLongPress: () async {
                    bool? confirm = await showConfirmationDialog(
                        context, 'Vorfall löschen', 'Den Vorfall löschen?');
                    if (confirm! == false) return;
                    await locator<AdmonitionManager>()
                        .deleteAdmonition(admonitions[index].admonitionId);
                    if (context.mounted) {
                      displayDialog(context, 'Vorfall gelöscht',
                          'Der Vorfall wurde gelöscht!');
                    }
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          DateFormat('dd.MM.yyyy')
                              .format(admonitions[index].admonishedDay)
                              .toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const Gap(5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Gap(5),
                                Text(admonitions[index].admonitionType),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Gap(5),
                                Text(
                                  admonitions[index].admonitionReason,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                final File? file = await uploadImage(context);
                                if (file == null) return;
                                await locator<AdmonitionManager>()
                                    .postAdmonitionFile(
                                  file,
                                  admonitions[index].admonitionId,
                                );
                                if (context.mounted) {
                                  displayDialog(context, 'Vorfall geändert',
                                      'Der Vorfall wurde geändert!');
                                }
                              },
                              child: admonitions[index].fileUrl != null
                                  ? documentImage(
                                      '${locator<EnvManager>().env.value.serverUrl}${Endpoints().getAdmonitionFile(admonitions[index].admonitionId)}',
                                      40)
                                  : Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: const BoxDecoration(
                                        color: backgroundColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt_rounded,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => NewAdmonitionView(
                    pupilId: pupil.internalId,
                  ),
                ));
              },
              child: const Text('neuer Vorfall')),
        ]),
  );
}
