import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/search_text_field.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_helper_functions.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/controller/admonition_list_controller.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

Widget admonitionListSearchBar(BuildContext context, List<Pupil> pupils,
    AdmonitionListController controller, bool filtersOn) {
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
                  const Gap(10),
                  const Text(
                    'Vorfälle:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    getAdmonitionCount(pupils).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    'Schule:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    getSchoolAdmonitionCount(pupils).toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    'OGS:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                  const Gap(10),
                  Text(getOgsAdmonitionCount(pupils).toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
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
