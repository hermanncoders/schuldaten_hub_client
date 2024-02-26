import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/information_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';
import 'package:schuldaten_hub/features/workbooks/models/pupil_workbook.dart';

// ignore: unused_import
import 'package:schuldaten_hub/features/workbooks/models/workbook.dart';
import 'package:schuldaten_hub/features/workbooks/services/workbook_manager.dart';

Widget pupilWorkbookCard(
    BuildContext context, PupilWorkbook pupilWorkbook, int pupilId) {
  final Workbook workbook = locator<WorkbookManager>()
      .getWorkbookByIsbn(pupilWorkbook.workbookIsbn!)!;
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Card(
        child: InkWell(
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (ctx) => SchoolListPupils(
      //       workbook,
      //     ),
      //   ));
      // },
      onLongPress: () async {
        if (pupilWorkbook.createdBy !=
            locator<SessionManager>().credentials.value.username) {
          informationDialog(context, 'Keine Berechtigung',
              'Arbeitshefte können nur von der eintragenden Person bearbeitet werden!');
          return;
        }
        final bool? result = await confirmationDialog(
            context,
            'Arbeitsheft löschen',
            'Arbeitsheft "${workbook.name}" wirklich löschen?');
        if (result == true) {
          locator<WorkbookManager>()
              .deletePupilWorkbook(pupilId, workbook.isbn);
          if (context.mounted) {
            snackbarSuccess(context, 'Das Arbeitsheft wurde gelöscht!');
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 5),
        child: Row(
          children: [
            const Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(10),
                InkWell(
                  onTap: () async {
                    final File? file = await uploadImage(context);
                    if (file == null) return;
                    await locator<WorkbookManager>()
                        .postWorkbookFile(file, workbook.isbn);
                    if (context.mounted) {
                      snackbarSuccess(
                          context, 'Die Einwilligung wurde geändert!');
                    }
                  },
                  onLongPress: (workbook.imageUrl == null)
                      ? () {}
                      : () async {
                          if (workbook.imageUrl == null) {
                            return;
                          }
                          final bool? result = await confirmationDialog(
                              context, 'Bild löschen', 'Bild löschen?');
                          if (result != true) return;
                          // await locator<WorkbookManager>()
                          //     .deleteAuthorizationFile(
                          //   pupil.internalId,
                          //   authorizationId,
                          //   pupilAuthorization.fileUrl!,
                          // );
                          if (context.mounted) {
                            snackbarSuccess(
                                context, 'Die Einwilligung wurde geändert!');
                          }
                        },
                  child: workbook.imageUrl != null
                      ? documentImage(
                          '${locator<EnvManager>().env.value.serverUrl}${EndpointsWorkbook().getWorkbookImage(workbook.isbn)}',
                          workbook.imageUrl,
                          100)
                      : SizedBox(
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset('assets/document_camera.png'),
                          ),
                        ),
                ),
                const Gap(10),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              workbook.name!,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        const Text('ISBN:'),
                        const Gap(10),
                        Text(
                          workbook.isbn.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Text(workbook.subject!,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 14,
                            )),
                        const Spacer(),
                        Text(
                          workbook.level!,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                    const Gap(5),
                    Text(
                      pupilWorkbook.createdBy,
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )),
  );
}
