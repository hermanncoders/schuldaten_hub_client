import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/short_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_helper_functions.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_manager.dart';
import 'package:schuldaten_hub/features/admonitions/views/new_admonition_view/new_admonition_view.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

List<Widget> pupilAdmonitionsContentList(
  Pupil pupil,
  BuildContext context,
  List<Admonition> admonitions,
) {
  return <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        //margin: const EdgeInsets.only(bottom: 16),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonAppStyleColor,
              minimumSize: const Size.fromHeight(50)),
          onPressed: () async {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NewAdmonitionView(
                pupilId: pupil.internalId,
              ),
            ));
          },
          child: const Text(
            "NEUES EREIGNIS",
            style: TextStyle(fontSize: 17.0),
          ),
        ),
      ),
    ),
    ListView.builder(
      padding: const EdgeInsets.only(top: 5, bottom: 15),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: admonitions.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: GestureDetector(
            onTap: () {
              //- TO-DO: change admonition
            },
            onLongPress: () async {
              bool? confirm = await confirmationDialog(
                  context, 'Vorfall löschen', 'Den Vorfall löschen?');
              if (confirm! == false) return;
              await locator<AdmonitionManager>()
                  .deleteAdmonition(admonitions[index].admonitionId);
              if (context.mounted) {
                informationDialog(
                    context, 'Vorfall gelöscht', 'Der Vorfall wurde gelöscht!');
              }
            },
            child: Card(
              color: cardInCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    DateFormat('dd.MM.yyyy')
                                        .format(
                                            admonitions[index].admonishedDay)
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const Gap(5),
                                  admonitions[index]
                                          .admonitionType
                                          .contains('rk')
                                      ? const Icon(Icons.rectangle_rounded,
                                          color: Colors.red)
                                      : const SizedBox.shrink(),
                                  admonitions[index]
                                          .admonitionType
                                          .contains('rk')
                                      ? const Gap(5)
                                      : const SizedBox.shrink(),
                                  Text(
                                    getAdmonitionTypeText(
                                        admonitions[index].admonitionType),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Gap(5),
                              Wrap(
                                children: [
                                  const Gap(5),
                                  Text(
                                    getAdmonitionReasonText(
                                        admonitions[index].admonitionReason),
                                    style: const TextStyle(fontSize: 16),
                                    softWrap: true,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                              const Gap(10),
                              Row(
                                children: [
                                  const Text('Erstellt von:',
                                      style: TextStyle(fontSize: 16)),
                                  const Gap(5),
                                  locator<SessionManager>().isAdmin.value
                                      ? InkWell(
                                          onTap: () async {
                                            final String? admonishingUser =
                                                await shortTextfieldDialog(
                                                    context,
                                                    'Erstellt von:',
                                                    'Kürzel eingeben');
                                            if (admonishingUser != null) {
                                              await locator<AdmonitionManager>()
                                                  .patchAdmonition(
                                                admonitions[index].admonitionId,
                                                admonishingUser,
                                                null,
                                                null,
                                                null,
                                              );
                                            }
                                          },
                                          child: Text(
                                            admonitions[index].admonishingUser,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: backgroundColor),
                                          ),
                                        )
                                      : Text(
                                          admonitions[index].admonishingUser,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                  const Gap(10),
                                ],
                              ),
                              const Gap(5),
                            ],
                          ),
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
                                  informationDialog(context, 'Vorfall geändert',
                                      'Der Vorfall wurde geändert!');
                                }
                              },
                              onLongPress: () async {
                                bool? confirm = await confirmationDialog(
                                    context,
                                    'Dokument löschen',
                                    'Dokument löschen?');
                                if (confirm == null || confirm == false) {
                                  return;
                                }
                                await locator<AdmonitionManager>()
                                    .deleteAdmonitionFile(
                                        admonitions[index].admonitionId,
                                        admonitions[index].fileUrl!);
                                if (context.mounted) {
                                  informationDialog(context, 'Vorfall geändert',
                                      'Der Vorfall wurde geändert!');
                                }
                              },
                              child: admonitions[index].fileUrl != null
                                  ? documentImage(
                                      '${locator<EnvManager>().env.value.serverUrl}${EndpointsAdmonition().getAdmonitionFile(admonitions[index].admonitionId)}',
                                      admonitions[index].fileUrl,
                                      70)
                                  : SizedBox(
                                      height: 70,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                            'assets/document_camera.png'),
                                      ),
                                    ),
                            )
                          ],
                        )
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            bool? confirm = await confirmationDialog(
                                context,
                                'Vorfall bearbeitet?',
                                'Den Vorfall als erledigt markieren?');
                            if (confirm! == false) return;
                            await locator<AdmonitionManager>()
                                .patchAdmonitionAsProcessed(
                                    admonitions[index].admonitionId, true);
                            if (context.mounted) {
                              snackbarSuccess(context, 'Vorfall markiert');
                            }
                          },
                          onLongPress: () async {
                            bool? confirm = await confirmationDialog(
                                context,
                                'Vorfall bearbeitet?',
                                'Den Vorfall als unbearbeitet markieren?');
                            if (confirm! == false) return;
                            await locator<AdmonitionManager>()
                                .patchAdmonitionAsProcessed(
                                    admonitions[index].admonitionId, false);
                          },
                          child: Text(
                              !admonitions[index].processed
                                  ? 'Nicht bearbeitet'
                                  : 'Bearbeitet von',
                              style: const TextStyle(
                                  fontSize: 16, color: backgroundColor)),
                        ),
                        const Gap(10),
                        if (admonitions[index].processedBy != null)
                          Text(
                            admonitions[index].processedBy!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        if (admonitions[index].processedAt != null)
                          const Gap(10),
                        if (admonitions[index].processedAt != null)
                          Text(
                            'am ${admonitions[index].processedAt!.formatForUser()}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  ];
}
