import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class AdmonitionFilterBottomSheet extends WatchingWidget {
  const AdmonitionFilterBottomSheet({super.key});

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
    bool valueSortByCredit = sortMode[PupilSortMode.sortByCredit]!;
    bool valueSortByCreditEarned = sortMode[PupilSortMode.sortByCreditEarned]!;

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
                      valueSortByName = filterLocator
                          .sortMode.value[PupilSortMode.sortByName]!;
                      filterLocator.sortPupils();
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'nach Guthaben',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByCredit,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByCredit, val);
                      valueSortByCredit = filterLocator
                          .sortMode.value[PupilSortMode.sortByCredit]!;
                      filterLocator.sortPupils();
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'nach Verdienst',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByCreditEarned,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByCreditEarned, val);
                      valueSortByCreditEarned = filterLocator
                          .sortMode.value[PupilSortMode.sortByCreditEarned]!;
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

showAdmonitionFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const AdmonitionFilterBottomSheet(),
  );
}
