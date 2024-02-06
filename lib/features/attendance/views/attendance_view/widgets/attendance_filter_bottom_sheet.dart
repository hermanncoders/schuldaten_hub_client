import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceFilterBottomSheet extends WatchingWidget {
  const AttendanceFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    bool valuePresent = activeFilters[PupilFilter.present]!;
    bool valueNotPresent = activeFilters[PupilFilter.notPresent]!;
    bool valueUnexcused = activeFilters[PupilFilter.unexcused]!;
    bool valueOgs = activeFilters[PupilFilter.ogs]!;
    bool valueNotOgs = activeFilters[PupilFilter.notOgs]!;

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
                'Anwesenheit',
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
                  'anwesend',
                  style: filterItemsTextStyle,
                ),
                selected: valuePresent,
                onSelected: (val) {
                  filterLocator.setFilter(PupilFilter.present, val);

                  valuePresent =
                      filterLocator.filterState.value[PupilFilter.present]!;
                  if (valuePresent == true) {
                    //_valueNotPresent = false;
                    filterLocator.setFilter(PupilFilter.notPresent, false);
                    filterLocator.setFilter(PupilFilter.unexcused, false);
                  }
                },
              ),
              FilterChip(
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'nicht da',
                  style: filterItemsTextStyle,
                ),
                selected: valueNotPresent,
                onSelected: (val) {
                  filterLocator.setFilter(PupilFilter.notPresent, val);
                  valueNotPresent =
                      filterLocator.filterState.value[PupilFilter.notPresent]!;
                  if (valueNotPresent == true) {
                    //_valuePresent = false;
                    filterLocator.setFilter(PupilFilter.present, false);
                  }
                },
              ),
              FilterChip(
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'nicht da unent.',
                  style: filterItemsTextStyle,
                ),
                selected: valueUnexcused,
                onSelected: (val) {
                  filterLocator.setFilter(PupilFilter.unexcused, val);
                  valueUnexcused =
                      filterLocator.filterState.value[PupilFilter.unexcused]!;
                  if (valueUnexcused == true) {
                    filterLocator.setFilter(PupilFilter.present, false);
                  }
                },
              ),
              FilterChip(
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'OGS',
                  style: filterItemsTextStyle,
                ),
                selected: valueOgs,
                onSelected: (val) {
                  if (val == true) {
                    filterLocator.setFilter(PupilFilter.notOgs, false);
                    filterLocator.setFilter(PupilFilter.ogs, val);
                  } else {
                    filterLocator.setFilter(PupilFilter.ogs, val);
                  }
                },
              ),
              FilterChip(
                selectedColor: filterChipSelectedColor,
                checkmarkColor: filterChipSelectedCheckColor,
                backgroundColor: filterChipUnselectedColor,
                label: const Text(
                  'nicht OGS',
                  style: filterItemsTextStyle,
                ),
                selected: valueNotOgs,
                onSelected: (val) {
                  if (val == true) {
                    filterLocator.setFilter(PupilFilter.ogs, false);
                    filterLocator.setFilter(PupilFilter.notOgs, val);
                  } else {
                    filterLocator.setFilter(PupilFilter.notOgs, val);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

showAttendanceFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const AttendanceFilterBottomSheet(),
  );
}
