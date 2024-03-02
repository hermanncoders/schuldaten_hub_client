import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

class AdmonitionFilterManager {
  ValueListenable<Map<AdmonitionFilter, bool>> get admonitionsFilterState =>
      _admonitionsFilterState;
  ValueListenable<bool> get admonitionsFiltersOn => _admonitionsFiltersOn;
  ValueListenable<int> get filteredAdmonitionsCount =>
      _filteredAdmonitionsCount;

  final _admonitionsFilterState =
      ValueNotifier<Map<AdmonitionFilter, bool>>(initialAdmonitionFilterValues);
  final _admonitionsFiltersOn = ValueNotifier<bool>(false);
  final _filteredAdmonitionsCount = ValueNotifier<int>(
      getAdmonitionCount(locator<PupilFilterManager>().filteredPupils.value));
  AdmonitionFilterManager() {
    debug.info('AdmonitionFilterManager says hello!');
  }

  resetFilters() {
    _admonitionsFilterState.value = {...initialAdmonitionFilterValues};
    _admonitionsFiltersOn.value = false;
  }

  void setFilter(AdmonitionFilter filter, bool isActive) {
    _admonitionsFilterState.value = {
      ..._admonitionsFilterState.value,
      filter: isActive,
    };
  }

  List<Admonition> admonitionsInTheLastSevenDays(Pupil pupil) {
    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    List<Admonition> admonitions = [];
    if (pupil.pupilAdmonitions != null) {
      for (Admonition admonition in pupil.pupilAdmonitions!) {
        if (admonition.admonishedDay.isBefore(sevenDaysAgo)) {
          admonitions.add(admonition);
        }
      }
    }
    return admonitions;
  }

  List<Admonition> admonitionsNotProcessed(Pupil pupil) {
    List<Admonition> admonitions = [];
    if (pupil.pupilAdmonitions != null) {
      for (Admonition admonition in pupil.pupilAdmonitions!) {
        if (admonition.processedBy == null) {
          admonitions.add(admonition);
        }
      }
    }
    return admonitions;
  }

  List<Admonition> admonitionsInTheLastFourteenDays(Pupil pupil) {
    DateTime fourteenDaysAgo =
        DateTime.now().subtract(const Duration(days: 14));
    List<Admonition> admonitions = [];
    if (pupil.pupilAdmonitions != null) {
      for (Admonition admonition in pupil.pupilAdmonitions!) {
        if (admonition.admonishedDay.isBefore(fourteenDaysAgo)) {
          admonitions.add(admonition);
        }
      }
    }
    return admonitions;
  }

  List<Admonition> filteredAdmonitions(Pupil pupil) {
    List<Admonition> filteredAdmonitions = [];
    DateTime sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    if (pupil.pupilAdmonitions != null) {
      final activeFilters = _admonitionsFilterState.value;
      for (Admonition admonition in pupil.pupilAdmonitions!) {
        bool toList = true;
        if (activeFilters[AdmonitionFilter.sevenDays]! &&
            admonition.admonishedDay.isBefore(sevenDaysAgo)) {
          continue;
        }
        // we keep the not processed ones
        if (activeFilters[AdmonitionFilter.processed]! &&
            admonition.processed == true) {
          continue;
        }
        if (activeFilters[AdmonitionFilter.redCard]! &&
            admonition.admonitionType != 'rk') {
          continue;
        }
        if (activeFilters[AdmonitionFilter.redCardOgs]! &&
            admonition.admonitionType != 'rkogs') {
          continue;
        }
        if (activeFilters[AdmonitionFilter.redCardsentHome]! &&
            admonition.admonitionType != 'rkabh') {
          continue;
        }
        if (activeFilters[AdmonitionFilter.otherEvent]! &&
            admonition.admonitionType == 'other') {
          continue;
        }
        if (activeFilters[AdmonitionFilter.parentsMeeting]! &&
            admonition.admonitionType != 'Eg') {
          continue;
        }
        if (activeFilters[AdmonitionFilter.violenceAgainstPersons]! &&
            !admonition.admonitionReason.contains('gm')) {
          continue;
        }

        filteredAdmonitions.add(admonition);
      }
    }
    return filteredAdmonitions;
  }
}
