import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';

class AdmonitionFilterManager {
  ValueListenable<Map<AdmonitionFilter, bool>> get admonitionsFilterState =>
      _admonitionsFilterState;
  ValueListenable<bool> get admonitionsFiltersOn => _admonitionsFiltersOn;

  final _admonitionsFilterState =
      ValueNotifier<Map<AdmonitionFilter, bool>>(initialAdmonitionFilterValues);
  final _admonitionsFiltersOn = ValueNotifier<bool>(false);
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
}
