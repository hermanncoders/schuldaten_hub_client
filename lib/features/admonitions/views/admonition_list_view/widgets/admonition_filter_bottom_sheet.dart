import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
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
    bool valueSortByName = sortMode[PupilSortMode.sortByName]!;
    bool valueSortByAdmonitions = sortMode[PupilSortMode.sortByAdmonitions]!;
    bool valueSortByLastAdmonition =
        sortMode[PupilSortMode.sortByLastAdmonition]!;
    final filterLocator = locator<PupilFilterManager>();
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 5),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Filter',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
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
                      'A-Z',
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
                      'Anzahl',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByAdmonitions,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByAdmonitions, val);
                      valueSortByAdmonitions = filterLocator
                          .sortMode.value[PupilSortMode.sortByAdmonitions]!;
                      filterLocator.sortPupils();
                    },
                  ),
                  FilterChip(
                    selectedColor: filterChipSelectedColor,
                    checkmarkColor: filterChipSelectedCheckColor,
                    backgroundColor: filterChipUnselectedColor,
                    label: const Text(
                      'zuletzt',
                      style: filterItemsTextStyle,
                    ),
                    selected: valueSortByLastAdmonition,
                    onSelected: (val) {
                      filterLocator.setSortMode(
                          PupilSortMode.sortByLastAdmonition, val);
                      valueSortByAdmonitions = filterLocator
                          .sortMode.value[PupilSortMode.sortByLastAdmonition]!;
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
