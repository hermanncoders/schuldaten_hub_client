import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/controller/school_list_pupils_controller.dart';

List<Widget> pupilSchoolListContentList(Pupil pupil) {
  final schoolListLocator = locator<SchoolListManager>();
  List<PupilList> pupilLists =
      locator<SchoolListManager>().getVisibleSchoolLists(pupil);
  List<Widget> addCheckByTeacher(int index, bool response) {
    if (response) {
      return [
        Text(
          pupilLists[index].pupilListEntryBy!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Gap(5),
      ];
    }
    return [const SizedBox.shrink()];
  }

  return [
    ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: pupilLists.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          onLongPress: () async {},
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, top: 10, bottom: 15, right: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
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
                              .listName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Gap(5),
                      Text(
                        maxLines: 2,
                        schoolListLocator
                            .getSchoolList(pupilLists[index].originList)
                            .listDescription,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ...addCheckByTeacher(
                              index,
                              (schoolListLocator
                                          .getPupilSchoolListEntry(
                                              pupil.internalId,
                                              pupilLists[index].originList)
                                          .pupilListStatus ==
                                      false)
                                  ? true
                                  : false),
                          Icon(Icons.close, color: Colors.red[400]),
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Checkbox(
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
                          ),
                        ],
                      ),
                      const Gap(10),
                      Row(children: [
                        ...addCheckByTeacher(
                            index,
                            (schoolListLocator
                                        .getPupilSchoolListEntry(
                                            pupil.internalId,
                                            pupilLists[index].originList)
                                        .pupilListStatus ==
                                    true)
                                ? true
                                : false),
                        Icon(Icons.done, color: Colors.green[400]),
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            activeColor: Colors.green,
                            value: (schoolListLocator
                                        .getPupilSchoolListEntry(
                                            pupil.internalId,
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
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ]),
                    ]),
              ]),
            ),
          ),
        );
      },
    ),
    const Gap(10)
  ];
}
