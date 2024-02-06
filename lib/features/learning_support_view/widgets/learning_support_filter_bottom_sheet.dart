import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class LearningSupportFilterBottomSheet extends WatchingWidget {
  const LearningSupportFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    bool valueSpecialNeeds = activeFilters[PupilFilter.specialNeeds]!;
    bool valueDevelopmentPlan1 = activeFilters[PupilFilter.developmentPlan1]!;
    bool valueDevelopmentPlan2 = activeFilters[PupilFilter.developmentPlan2]!;
    bool valueDevelopmentPlan3 = activeFilters[PupilFilter.developmentPlan3]!;
    bool valueMigrationSupport = activeFilters[PupilFilter.migrationSupport]!;
    final filterLocator = locator<PupilFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Filter',
                style: title,
              ),
              const Spacer(),
              IconButton.filled(
                  iconSize: 35,
                  color: Colors.amber,
                  onPressed: () {
                    locator<PupilFilterManager>().resetFilters();
                    //Navigator.pop(context);
                  },
                  icon: const Icon(Icons.restart_alt_rounded)),
            ],
          ),
          standardFilters(activeFilters),
          const Row(
            children: [
              Text(
                'Förderebene',
                style: subtitle,
              )
            ],
          ),
          const Gap(5),
          Wrap(
            spacing: 5,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FilterChip(
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'Ebene 1',
                  style: filterItemsTextStyle,
                ),
                selected: valueDevelopmentPlan1,
                onSelected: (val) {
                  filterLocator.setFilter(PupilFilter.developmentPlan1, val);

                  valueDevelopmentPlan1 = filterLocator
                      .filterState.value[PupilFilter.developmentPlan1]!;
                  // if (valueDevelopmentPlan1 == true) {
                  //   //_valueNotPresent = false;
                  //   filterLocator.setFilter(PupilFilter.notPresent, false);
                  //   filterLocator.setFilter(PupilFilter.unexcused, false);
                  // }
                },
              ),
              FilterChip(
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'Ebene 2',
                  style: filterItemsTextStyle,
                ),
                selected: valueDevelopmentPlan2,
                onSelected: (val) {
                  filterLocator.setFilter(PupilFilter.developmentPlan2, val);

                  valueDevelopmentPlan2 = filterLocator
                      .filterState.value[PupilFilter.developmentPlan2]!;
                  // if (valueDevelopmentPlan1 == true) {
                  //   //_valueNotPresent = false;
                  //   filterLocator.setFilter(PupilFilter.notPresent, false);
                  //   filterLocator.setFilter(PupilFilter.unexcused, false);
                  // }
                },
              ),
              FilterChip(
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'Ebene 3',
                  style: filterItemsTextStyle,
                ),
                selected: valueDevelopmentPlan3,
                onSelected: (val) {
                  filterLocator.setFilter(PupilFilter.developmentPlan3, val);

                  valueDevelopmentPlan3 = filterLocator
                      .filterState.value[PupilFilter.developmentPlan3]!;
                  // if (valueDevelopmentPlan1 == true) {
                  //   //_valueNotPresent = false;
                  //   filterLocator.setFilter(PupilFilter.notPresent, false);
                  //   filterLocator.setFilter(PupilFilter.unexcused, false);
                  // }
                },
              ),
              FilterChip(
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'AO-SF',
                  style: filterItemsTextStyle,
                ),
                selected: valueSpecialNeeds,
                onSelected: (val) {
                  filterLocator.setFilter(PupilFilter.specialNeeds, val);

                  valueSpecialNeeds = filterLocator
                      .filterState.value[PupilFilter.specialNeeds]!;
                  // if (valueDevelopmentPlan1 == true) {
                  //   //_valueNotPresent = false;
                  //   filterLocator.setFilter(PupilFilter.notPresent, false);
                  //   filterLocator.setFilter(PupilFilter.unexcused, false);
                  // }
                },
              ),
              FilterChip(
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'EF',
                  style: filterItemsTextStyle,
                ),
                selected: valueMigrationSupport,
                onSelected: (val) {
                  filterLocator.setFilter(PupilFilter.migrationSupport, val);

                  valueMigrationSupport = filterLocator
                      .filterState.value[PupilFilter.migrationSupport]!;
                  // if (valueDevelopmentPlan1 == true) {
                  //   //_valueNotPresent = false;
                  //   filterLocator.setFilter(PupilFilter.notPresent, false);
                  //   filterLocator.setFilter(PupilFilter.unexcused, false);
                  // }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

showLearningSupportFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const LearningSupportFilterBottomSheet(),
  );
}
