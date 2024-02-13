import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/features/school_lists/services/school_list_helper_functions.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/controller/school_list_pupils_controller.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/widgets/school_list_stats_row.dart';

Widget schoolListPupilsSearchBar(
    BuildContext context,
    List<Pupil> pupils,
    SchoolList schoolList,
    SchoolListPupilsController controller,
    bool filtersOn) {
  return Container(
    decoration: BoxDecoration(
      color: canvasColor,
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Column(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.00),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schoolList.listDescription,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      schoolListStatsRow(schoolList, pupils),
                      const Gap(10),
                      const Icon(
                        Icons.school_rounded,
                        color: backgroundColor,
                      ),
                      const Gap(10),
                      schoolList.visibility != 'public'
                          ? Text(
                              schoolList.createdBy,
                              style: const TextStyle(
                                  color: backgroundColor,
                                  fontWeight: FontWeight.bold),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        listOwners(schoolList),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(10),
                    ],
                  ),
                ],
              ),
            ),
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
                onTap: () => showAdmonitionFilterBottomSheet(context),
                onLongPress: () => locator<PupilFilterManager>().resetFilters(),
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
