import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/constants/styles.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/widgets/standard_filters.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:watch_it/watch_it.dart';

class CreditFilterBottomSheet extends WatchingWidget {
  const CreditFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    Map<PupilSortMode, bool> sortMode =
        watchValue((PupilFilterManager x) => x.sortMode);
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

showCreditFilterBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    constraints: const BoxConstraints(maxWidth: 800),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    context: context,
    builder: (_) => const CreditFilterBottomSheet(),
  );
}
