import 'package:flutter/material.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/controller/school_list_pupils_controller.dart';

schoolListPupilTiles(Pupil pupil) {
  final schoolListLocator = locator<SchoolListManager>();
  List<PupilList> pupilLists =
      locator<SchoolListManager>().getVisibleSchoolLists(pupil);
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
          //   Icons.list_alt_rounded,
          //   color: backgroundColor,
          // ),
          // Gap(10),
          Text(
            'Listeneinträge',
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
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pupilLists.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {},
                onLongPress: () async {},
                child: ListTile(
                  title: InkWell(
                    onTap: () {
                      final schoolList = schoolListLocator
                          .getSchoolList(pupilLists[index].originList);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => SchoolListPupils(
                          schoolList,
                        ),
                      ));
                    },
                    child: Text(
                      schoolListLocator
                          .getSchoolList(pupilLists[index].originList)
                          .listName
                        ..characters,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  subtitle: Text(
                    maxLines: 2,
                    schoolListLocator
                        .getSchoolList(pupilLists[index].originList)
                        .listDescription,
                    style: const TextStyle(fontSize: 15),
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.red,
                          value: (schoolListLocator
                                          .getPupilSchoolListEntry(
                                              pupil.internalId,
                                              pupilLists[index].originList)
                                          .pupilListStatus ==
                                      true ||
                                  schoolListLocator
                                          .getPupilSchoolListEntry(
                                              pupil.internalId,
                                              pupilLists[index].originList)
                                          .pupilListStatus ==
                                      null)
                              ? false
                              : true,
                          onChanged: (value) async {
                            await schoolListLocator.patchSchoolListPupil(
                                pupil.internalId,
                                pupilLists[index].originList,
                                false,
                                null);
                          },
                        ),
                        Checkbox(
                          activeColor: Colors.green,
                          value: (schoolListLocator
                                      .getPupilSchoolListEntry(pupil.internalId,
                                          pupilLists[index].originList)
                                      .pupilListStatus ==
                                  true)
                              ? true
                              : false,
                          onChanged: (value) async {
                            await schoolListLocator.patchSchoolListPupil(
                                pupil.internalId,
                                pupilLists[index].originList,
                                true,
                                null);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
