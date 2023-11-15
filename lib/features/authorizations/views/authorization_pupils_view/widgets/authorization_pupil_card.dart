import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/widgets/pupil_list_comment_dialog.dart';
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
        pupils.where((pupil) => pupil.internalId == internalId).first;
    final PupilAuthorization pupilAuthorization = pupil.authorizations!
        .where((authorization) =>
            authorization.originAuthorization == authorizationId)
        .first;

    // Report attendanceReport =
    //     watchValue((AttendanceManager x) => x.operationReport);
    // if (attendanceReport.message != null) {
    //   snackbar(context, attendanceReport.type, attendanceReport.message);
    // }

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            avatarWithBadges(pupil, 80),
            const SizedBox(width: 10), // Add some spacing
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
                      child: Text(
                        '${pupil.firstName!} ${pupil.lastName!}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(5),
                    InkWell(
                      onTap: () async {
                        final authorizationComment =
                            await pupilAuthorizationCommentDialog(context);
                        await locator<AuthorizationManager>()
                            .patchPupilAuthorization(
                          pupil.internalId,
                          authorizationId,
                          null,
                          authorizationComment,
                        );
                      },
                      child: Text(
                        pupilAuthorization.comment != null
                            ? pupilAuthorization.comment!
                            : 'kein Kommentar',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10), // Add some spacing
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Gap(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('nein'),
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
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('ja'),
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
      ),
    );
  }
}
