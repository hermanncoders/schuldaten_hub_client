import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/widgets/dialogues/long_textfield_dialog.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';

import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/common/widgets/avatar.dart';
import 'package:schuldaten_hub/features/pupil/views/pupil_profile_view/controller/pupil_profile_controller.dart';

import 'package:watch_it/watch_it.dart';

class SchoolListPupilCard extends StatelessWidget with WatchItMixin {
  final int internalId;
  final String originList;
  SchoolListPupilCard(this.internalId, this.originList, {super.key});
  @override
  Widget build(BuildContext context) {
    final schoolListLocator = locator<SchoolListManager>();
    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    final Pupil pupil =
        pupils.where((pupil) => pupil.internalId == internalId).first;
    final PupilList pupilList = pupil.pupilLists!
        .where((pupilList) => pupilList.originList == originList)
        .first;

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
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Gap(5),
                    InkWell(
                      onTap: () async {
                        final listComment = await longTextFieldDialog(
                            'Kommentar ändern',
                            pupilList.pupilListComment,
                            context);
                        await locator<SchoolListManager>().patchPupilSchoolList(
                          pupil.internalId,
                          originList,
                          null,
                          listComment == '' ? null : listComment,
                        );
                      },
                      child: Text(
                        pupilList.pupilListComment != null
                            ? pupilList.pupilListComment!
                            : 'kein Kommentar',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 5), // Add some spacing
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('nein'),
                    Checkbox(
                      activeColor: Colors.red,
                      value: (pupilList.pupilListStatus == null ||
                              pupilList.pupilListStatus == true)
                          ? false
                          : true,
                      onChanged: (value) async {
                        await schoolListLocator.patchPupilSchoolList(
                          pupil.internalId,
                          originList,
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
                    const Text('ja'),
                    Checkbox(
                      activeColor: Colors.green,
                      value: (pupilList.pupilListStatus != true ||
                              pupilList.pupilListStatus == null)
                          ? false
                          : true,
                      onChanged: (value) async {
                        await schoolListLocator.patchPupilSchoolList(
                          pupil.internalId,
                          originList,
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
