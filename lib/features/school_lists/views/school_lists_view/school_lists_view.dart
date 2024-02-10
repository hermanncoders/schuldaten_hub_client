import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/common/models/session_models/session.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_manager.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';

import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_lists_view/controller/school_lists_controller.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_lists_view/widgets/school_list_card.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_lists_view/widgets/school_lists_bottom_navbar.dart';
import 'package:watch_it/watch_it.dart';

class SchoolListsView extends WatchingWidget {
  final SchoolListsController controller;
  const SchoolListsView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);

    Session session = watchValue((SessionManager x) => x.credentials);
    List<SchoolList> schoolLists =
        watchValue((SchoolListManager x) => x.schoolLists);
    List<SchoolList> visibleSchoolLists = schoolLists
        .where((element) =>
            element.visibility == 'public' ||
            element.createdBy == session.username ||
            element.visibility.contains(session.username!))
        .toList();

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Eintragelisten'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<SchoolListManager>().fetchSchoolLists(),
        child: visibleSchoolLists.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Es wurden noch keine Eintragelisten angelegt!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 15.0, right: 10.00),
                        child: Row(
                          children: [
                            const Text(
                              'Gesamt:',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            const Gap(10),
                            Text(
                              visibleSchoolLists.length.toString(),
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
                                  'Liste suchen',
                                  controller,
                                  locator<SchoolListManager>()
                                      .fetchSchoolLists),
                            ),
                            //---------------------------------
                            InkWell(
                              onTap: () {},

                              onLongPress: () =>
                                  locator<PupilFilterManager>().resetFilters(),
                              // onPressed: () => showBottomSheetFilters(context),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.filter_list,
                                  color: filtersOn
                                      ? Colors.deepOrange
                                      : Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      visibleSchoolLists.isEmpty
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
                                itemCount: visibleSchoolLists.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return schoolListCard(
                                      context, visibleSchoolLists[index]);
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: schoolListsBottomNavBar(context),
    );
  }
}
