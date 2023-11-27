import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/controller/attendance_list_controller.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/atendance_list_card.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/attendance_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/attendance_view_bottom_navbar.dart';
import 'package:schuldaten_hub/common/widgets/date_picker.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceListView extends WatchingWidget {
  final AttendanceListController controller;
  const AttendanceListView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime thisDate = watchValue((SchooldayManager x) => x.thisDate);
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    // bool _isRunning = watchValue((PupilFilterManager x) => x.isRunning);

    List<Pupil> pupils = watchValue((PupilFilterManager x) => x.filteredPupils);
    // Report attendanceReport =
    //     watchValue((AttendanceManager x) => x.operationReport);
    // if (attendanceReport.message != null) {
    //   registerHandler(
    //       handler: snackbar(
    //           context, attendanceReport.type, attendanceReport.message));
    // }
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: InkWell(
          onTap: () async {
            final DateTime newDate = await selectDate(context, thisDate);
            locator<SchooldayManager>().setThisDate(newDate);
          },
          child: Text(
              '${DateFormat('EEEE', Localizations.localeOf(context).toString()).format(thisDate)}, ${thisDate.formatForUser()}'),
        ),
        automaticallyImplyLeading: false,
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
                      const Text(
                        'Gesamt:',
                        style: TextStyle(
                          fontSize: 13,
                        ),
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
                      const Text(
                        'Anwesend: ',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        (pupils.length -
                                controller.missedPupils(pupils, thisDate))
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(15),
                      const Text(
                        'Unent. ',
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        controller.unexcusedPupils(pupils, thisDate).toString(),
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
                              locator<PupilFilterManager>()
                                  .refreshFilteredPupils)),
                      InkWell(
                        onTap: () => showAttendanceFilterBottomSheet(context),
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
                            itemCount: pupils.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AttendanceCard(controller, pupils[index]);
                            })),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:
          attendanceViewBottomNavBar(context, filtersOn, thisDate),
    );
  }
}
