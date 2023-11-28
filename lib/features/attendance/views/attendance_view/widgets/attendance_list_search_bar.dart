import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/controller/attendance_list_controller.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/widgets/attendance_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

Widget attendanceListSearchBar(BuildContext context, List<Pupil> pupils,
    AttendanceListController controller, DateTime thisDate, bool filtersOn) {
  return Container(
    decoration: BoxDecoration(
      color: canvasColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Column(
      children: [
        const Gap(5),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Row(
            children: [
              const Text(
                'Gesamt:',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              const Gap(5),
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
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              const Gap(5),
              Text(
                (pupils.length - controller.missedPupils(pupils, thisDate))
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
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
              const Gap(5),
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
          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          child: Row(
            children: [
              Expanded(
                  child: searchTextField('Schüler/in suchen', controller,
                      locator<PupilFilterManager>().refreshFilteredPupils)),
              InkWell(
                onTap: () => showAttendanceFilterBottomSheet(context),
                onLongPress: () => locator<PupilFilterManager>().resetFilters(),
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
      ],
    ),
  );
}
