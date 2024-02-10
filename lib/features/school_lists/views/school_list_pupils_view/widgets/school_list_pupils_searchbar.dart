import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/controller/school_list_pupils_controller.dart';

Widget schoolListPupilsSearchBar(BuildContext context, List<Pupil> pupils,
    SchoolListPupilsController controller, bool filtersOn) {
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
                children: [
                  Row(
                    children: [
                      const Text(
                        'Beschreibung:',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      Text(
                        controller.widget.schoolList.listDescription,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
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
                      const Gap(10),
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      const Gap(5),
                      Text(
                        controller
                            .totalShownPupilsMarkedWithYesNoOrNull(
                                pupils, false)
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(10),
                      const Icon(
                        Icons.done,
                        color: Colors.green,
                      ),
                      const Gap(5),
                      Text(
                        controller
                            .totalShownPupilsMarkedWithYesNoOrNull(pupils, true)
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(10),
                      const Icon(
                        Icons.question_mark_rounded,
                        color: accentColor,
                      ),
                      const Gap(5),
                      Text(
                        controller
                            .totalShownPupilsMarkedWithYesNoOrNull(pupils, null)
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(10),
                      const Icon(
                        Icons.create,
                        color: backgroundColor,
                      ),
                      const Gap(5),
                      Text(
                        controller
                            .totalShownPupilsWithComment(pupils)
                            .toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const Gap(10),
                      const Icon(
                        Icons.school_rounded,
                        color: backgroundColor,
                      ),
                      const Gap(10),
                      controller.widget.schoolList.visibility != 'public'
                          ? Text(
                              controller.widget.schoolList.createdBy,
                              style: const TextStyle(
                                  color: backgroundColor,
                                  fontWeight: FontWeight.bold),
                            )
                          : const SizedBox.shrink(),
                      Text(
                        controller.listOwners(),
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
