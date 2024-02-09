// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/common/widgets/group_schoolyear_filter_bottom_sheet.dart';

import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/controller/school_list_pupils_controller.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/widgets/school_list_pupil_card.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/widgets/school_list_pupils_bottom_navbar.dart';

import 'package:watch_it/watch_it.dart';

class SchoolListPupilsView extends WatchingWidget {
  final SchoolListPupilsController controller;
  final SchoolList schoolList;

  const SchoolListPupilsView(this.controller, this.schoolList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    List<Pupil> filteredPupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);
    List<Pupil> pupilsInList = locator<SchoolListManager>()
        .filteredPupilsInSchoolList(schoolList.listId, filteredPupils);
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.list),
            const Gap(10),
            Text(schoolList.listName),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().getAllPupils(),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                children: [
                  const Gap(15),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 10.0, right: 10.00),
                    child: Text(
                      schoolList.listDescription.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 10.0, right: 10.00),
                    child: Row(
                      children: [
                        const Text(
                          'Kinder in der Liste:',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const Gap(10),
                        Text(
                          pupilsInList.length.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: searchTextField(
                          'Schüler/in suchen',
                          controller,
                          locator<PupilFilterManager>().refreshFilteredPupils,
                        )),
                        //---------------------------------
                        InkWell(
                          onTap: () => showGroupYearFilterBottomSheet(
                              context, activeFilters),
                          onLongPress: () =>
                              locator<PupilFilterManager>().resetFilters(),
                          // onPressed: () => showBottomSheetFilters(context),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.filter_list,
                              color:
                                  _filtersOn ? Colors.deepOrange : Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  pupilsInList.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Keine Ergebnisse',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              itemCount: pupilsInList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SchoolListPupilCard(
                                    pupilsInList[index].internalId,
                                    schoolList.listId);
                              }),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: schoolListPupilsBottomNavBar(
          context, schoolList.listId, pupilIdsFromPupils(pupilsInList)),
    );
  }
}
