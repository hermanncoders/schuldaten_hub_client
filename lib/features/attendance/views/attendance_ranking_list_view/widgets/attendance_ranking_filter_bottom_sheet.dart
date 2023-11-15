import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class AttendanceRankingFilterBottomSheet extends WatchingWidget {
  const AttendanceRankingFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    Map<PupilSortMode, bool> sortMode =
        watchValue((PupilFilterManager x) => x.sortMode);
    bool valueA1 = activeFilters[PupilFilter.A1]!;
    bool valueA2 = activeFilters[PupilFilter.A2]!;
    bool valueA3 = activeFilters[PupilFilter.A3]!;
    bool valueB1 = activeFilters[PupilFilter.B1]!;
    bool valueB2 = activeFilters[PupilFilter.B2]!;
    bool valueB3 = activeFilters[PupilFilter.B3]!;
    bool valueB4 = activeFilters[PupilFilter.B4]!;
    bool valueC1 = activeFilters[PupilFilter.C1]!;
    bool valueC2 = activeFilters[PupilFilter.C2]!;
    bool valueC3 = activeFilters[PupilFilter.C3]!;
    bool valueE1 = activeFilters[PupilFilter.E1]!;
    bool valueE2 = activeFilters[PupilFilter.E2]!;
    bool valueE3 = activeFilters[PupilFilter.E3]!;
    bool valueS3 = activeFilters[PupilFilter.S3]!;
    bool valueS4 = activeFilters[PupilFilter.S4]!;
    bool valueSortByName = sortMode[PupilSortMode.sortByName]!;

    bool valueSortByMissedExcused =
        sortMode[PupilSortMode.sortByMissedExcused]!;
    bool valueSortByMissedUnexcused =
        sortMode[PupilSortMode.sortByMissedUnexcused]!;
    bool valueSortByContacted = sortMode[PupilSortMode.sortByContacted]!;
    bool valueSortByLate = sortMode[PupilSortMode.sortByLate]!;

    final filterLocator = locator<PupilFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
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
              const Row(
                children: [
                  Text(
                    'Jahrgang',
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
                      'E1',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueE1,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.E1, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'E2',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueE2,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.E2, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'E3',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueE3,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.E3, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'S3',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueS3,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.S3, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'S4',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueS4,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.S4, val);
                    },
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Klasse',
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
                      'A1',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueA1,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.A1, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'A2',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueA2,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.A2, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'A3',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueA3,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.A3, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'B1',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueB1,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.B1, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'B2',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueB2,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.B2, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'B3',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueB3,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.B3, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'B4',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueB4,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.B4, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'C1',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueC1,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.C1, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'C2',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueC2,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.C2, val);
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'C3',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueC3,
                    onSelected: (val) {
                      filterLocator.setFilter(PupilFilter.C3, val);
                    },
                  ),
                ],
              ),
              const Row(
                children: [
                  Text(
                    'Sortieren',
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
                      'alphabetisch',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByName,
                    onSelected: (val) {
                      filterLocator.setSortMode(PupilSortMode.sortByName, val);
                      valueSortByMissedExcused = filterLocator
                          .sortMode.value[PupilSortMode.sortByName]!;
                      filterLocator.sortPupils();
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'entschuldigt',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByMissedExcused,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByMissedExcused, val);
                      valueSortByMissedExcused = filterLocator
                          .sortMode.value[PupilSortMode.sortByMissedExcused]!;
                      filterLocator.sortPupils();
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'unentschuldigt',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByMissedUnexcused,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByMissedUnexcused, val);
                      valueSortByMissedUnexcused = filterLocator
                          .sortMode.value[PupilSortMode.sortByMissedExcused]!;
                      filterLocator.sortPupils();
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'verspätet',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByLate,
                    onSelected: (val) {
                      filterLocator.setSortMode(PupilSortMode.sortByLate, val);
                      valueSortByLate = filterLocator
                          .sortMode.value[PupilSortMode.sortByLate]!;
                      filterLocator.sortPupils();
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'kontaktiert',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByContacted,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByContacted, val);
                      valueSortByContacted = filterLocator
                          .sortMode.value[PupilSortMode.sortByContacted]!;
                      filterLocator.sortPupils();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showAttendanceRankingFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
    ),
    context: context,
    builder: (_) => const AttendanceRankingFilterBottomSheet(),
  );
}
