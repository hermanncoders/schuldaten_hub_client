import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/confirmation_dialog.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';
import 'package:schuldaten_hub/common/widgets/document_image.dart';
import 'package:schuldaten_hub/common/widgets/snackbars.dart';
import 'package:schuldaten_hub/common/widgets/upload_image.dart';

import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';

import 'package:watch_it/watch_it.dart';

class AuthorizationPupilCard extends StatelessWidget with WatchItMixin {
  final int internalId;
  final String authorizationId;
  AuthorizationPupilCard(this.internalId, this.authorizationId, {super.key});
  @override
  Widget build(BuildContext context) {
    final schoolListLocator = locator<AuthorizationManager>();
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    final Pupil pupil =
        pupils.firstWhere((pupil) => pupil.internalId == internalId);
    final PupilAuthorization pupilAuthorization = pupil.authorizations!
        .where((authorization) =>
            authorization.originAuthorization == authorizationId)
        .first;

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatarWithBadges(pupil, 80),
                //const SizedBox(width: 10), // Add some spacing
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PupilProfile(
                                pupil,
                              ),
                            ));
                          },
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              pupil.firstName!,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            pupil.lastName!,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(15),
                    InkWell(
                      onTap: () async {
                        final File? file = await uploadImage(context);
                        if (file == null) return;
                        await locator<AuthorizationManager>()
                            .postAuthorizationFile(
                                file, pupil.internalId, authorizationId);
                        if (context.mounted) {
                          snackbarSuccess(
                              context, 'Die Einwilligung wurde geändert!');
                        }
                      },
                      onLongPress: (pupilAuthorization.fileUrl == null)
                          ? () {}
                          : () async {
                              if (pupilAuthorization.fileUrl == null) return;
                              final bool? result = await confirmationDialog(
                                  context,
                                  'Dokument löschen',
                                  'Dokument für die Einwilligung von ${pupil.firstName} ${pupil.lastName} löschen?');
                              if (result != true) return;
                              await locator<AuthorizationManager>()
                                  .deleteAuthorizationFile(
                                pupil.internalId,
                                authorizationId,
                                pupilAuthorization.fileUrl!,
                              );
                              if (context.mounted) {
                                snackbarSuccess(context,
                                    'Die Einwilligung wurde geändert!');
                              }
                            },
                      child: pupilAuthorization.fileUrl != null
                          ? documentImage(
                              '${locator<EnvManager>().env.value.serverUrl}${Endpoints().getPupilAuthorizationFile(pupil.internalId, authorizationId)}',
                              pupilAuthorization.fileUrl,
                              70)
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
                ),
                const SizedBox(width: 5), // Add some spacing
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                        Checkbox(
                          activeColor: Colors.red,
                          value: (pupilAuthorization.status == null ||
                                  pupilAuthorization.status == true)
                              ? false
                              : true,
                          onChanged: (value) async {
                            await schoolListLocator.patchPupilAuthorization(
                              pupil.internalId,
                              authorizationId,
                              false,
                              null,
                            );
                          },
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                        Checkbox(
                          activeColor: Colors.green,
                          value: (pupilAuthorization.status != true ||
                                  pupilAuthorization.status == null)
                              ? false
                              : true,
                          onChanged: (value) async {
                            await schoolListLocator.patchPupilAuthorization(
                              pupil.internalId,
                              authorizationId,
                              true,
                              null,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(10),
                Text('Kommentar: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Gap(5),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(10),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final String? authorizationComment =
                          await longTextFieldDialog('Kommentar ändern',
                              pupilAuthorization.comment, context);
                      if (authorizationComment == null) return;
                      if (authorizationComment == '') {}
                      await locator<AuthorizationManager>()
                          .patchPupilAuthorization(
                        pupil.internalId,
                        authorizationId,
                        null,
                        authorizationComment == ''
                            ? null
                            : authorizationComment,
                      );
                    },
                    child: Text(
                      pupilAuthorization.comment != null
                          ? pupilAuthorization.comment!
                          : 'kein Kommentar',
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
