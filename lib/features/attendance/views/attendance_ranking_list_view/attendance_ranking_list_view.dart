import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/controller/attendance_ranking_list_controller.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/widgets/attendance_ranking_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/widgets/attendance_ranking_list_card.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_ranking_list_view/widgets/attendance_ranking_list_view_bottom_navbar.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingListView extends WatchingWidget {
  final AttendanceRankingListController controller;
  const AttendanceRankingListView(this.controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debug.info('Widget Build started!');

    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);

    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);

    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month_rounded),
            Gap(10),
            Text('Fehlzeiten'),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => locator<PupilManager>().getAllPupils(),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 15.0, right: 10.00),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.people_alt_rounded,
                        color: backgroundColor,
                      ),
                      const Gap(10),
                      Text(
                        pupils.length.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(15),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: searchTextField(
                          'Schüler*in suchen',
                          controller,
                          locator<PupilFilterManager>().refreshFilteredPupils,
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            showAttendanceRankingFilterBottomSheet(context),
                        onLongPress: () =>
                            locator<PupilFilterManager>().resetFilters(),
                        // onPressed: () => showBottomSheetFilters(context),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.filter_list,
                            color: filtersOn ? Colors.deepOrange : Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pupils.isEmpty
                    ? const Center(
                        child: Text('Keine Ergebnisse'),
                      )
                    : Expanded(
                        child: ListView.builder(
                            itemCount: pupils.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AttendanceRankingListCard(
                                  controller, pupils[index]);
                            })),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          attendanceRankingListViewBottomNavBar(context, filtersOn),
    );
  }
}
