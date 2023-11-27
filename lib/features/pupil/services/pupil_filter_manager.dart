import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/models/manager_report.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/common/utils/extensions.dart';
import 'package:schuldaten_hub/features/attendance/services/attendance_manager.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/common/services/schoolday_manager.dart';

class PupilFilterManager {
  ValueListenable<bool> get filtersOn => _filtersOn;
  ValueListenable<String> get searchText => _searchText;
  ValueListenable<List<Pupil>> get filteredPupils => _filteredPupils;
  ValueListenable<Map<PupilFilter, bool>> get filterState => _filterState;
  ValueListenable<Map<PupilSortMode, bool>> get sortMode => _sortMode;
  ValueListenable<Report> get operationReport => _operationReport;
  ValueListenable<bool> get isRunning => _isRunning;

  final _filtersOn = ValueNotifier<bool>(false);
  final _searchText = ValueNotifier<String>('');
  final _filteredPupils =
      ValueNotifier<List<Pupil>>(locator<PupilManager>().pupils.value);
  final _filterState =
      ValueNotifier<Map<PupilFilter, bool>>(initialFilterValues);
  final _sortMode =
      ValueNotifier<Map<PupilSortMode, bool>>(initialSortModeValues);
  final _operationReport = ValueNotifier<Report>(Report(null, null));
  final _isRunning = ValueNotifier<bool>(false);

  PupilFilterManager() {
    debug.warning('PupilFilterManager says hello!');
  }
  changeSwitch(bool value) {
    _isRunning.value = value;
  }

  filtersOnSwitch(value) {
    if (_filterState.value == initialFilterValues) {
      _filtersOn.value = value;
    }
  }

  deleteFilteredPupils() {
    _filteredPupils.value = [];
  }

  refreshFilteredPupils() {
    //var updatedFilteredPupils = <Pupil>[];
    final List<Pupil> filteredPupils = List.from(_filteredPupils.value);
    final List<Pupil> pupils = locator<PupilManager>().pupils.value;

    for (Pupil filteredPupil in filteredPupils) {
      Pupil pupil = pupils
          .where((pupil) => pupil.internalId == filteredPupil.internalId)
          .single;

      filteredPupil = pupil.copyWith();
    }
    _filteredPupils.value = filteredPupils;
  }

  cloneToFilteredPupil(Pupil pupil) {
    List<Pupil> filteredPupils = _filteredPupils.value;

    int index = filteredPupils
        .indexWhere((element) => element.internalId == pupil.internalId);
    List<Pupil> updatedPupils = List<Pupil>.from(filteredPupils);
    updatedPupils[index] = pupil;

    _filteredPupils.value = updatedPupils;
  }

  updateFilteredPupils() {
    _filteredPupils.value = locator<PupilManager>().pupils.value;
  }

  resetFilters() {
    updateFilteredPupils();
    _filterState.value = {...initialFilterValues};
    _filtersOn.value = false;
  }

  // Set modified filter value
  void setFilter(PupilFilter filter, bool isActive) {
    _filterState.value = {
      ..._filterState.value,
      filter: isActive,
    };
    filterPupils();
  }

  void setSortMode(PupilSortMode sortMode, bool isActive) {
    if (sortMode == PupilSortMode.sortByName || isActive == false) {
      _sortMode.value = initialSortModeValues;
    } else {
      _sortMode.value = initialSortModeValues;
      _sortMode.value = {
        ..._sortMode.value,
        PupilSortMode.sortByName: false,
        sortMode: isActive,
      };
    }
    sortPupils();
  }

  setSearchText(String? text) {
    if (text!.isEmpty) {
      _filteredPupils.value = locator<PupilManager>().pupils.value;
      _searchText.value = '';
      _filtersOn.value = false;
      return;
    }

    _searchText.value = text;
    _filtersOn.value = true;
    List<Pupil> filteredPupils = [];
    List<Pupil> filteredPupilsState = List.from(_filteredPupils.value);
    filteredPupils = filteredPupilsState
        .where((Pupil pupil) =>
            pupil.firstName!.toLowerCase().contains(text.toLowerCase()))
        .toList();
    _filteredPupils.value = filteredPupils;
  }

  filterPupils() {
    _filtersOn.value = false;
    final pupils = locator<PupilManager>().pupils.value;
    final activeFilters = _filterState.value;

    final thisDate = locator<SchooldayManager>().thisDate.value;
    if (_filterState.value == initialFilterValues) {
      _filtersOn.value = false;
      _filteredPupils.value = pupils;
    }

    List<Pupil> filteredPupils = [];
    for (Pupil pupil in pupils) {
      bool toList = true;
      // first we make sure that common group and schoolyear filters work
      if (((activeFilters[PupilFilter.E1]! && pupil.schoolyear == 'E1') ||
              (activeFilters[PupilFilter.E2]! && pupil.schoolyear == 'E2') ||
              (activeFilters[PupilFilter.E3]! && pupil.schoolyear == 'E3') ||
              (activeFilters[PupilFilter.S3]! && pupil.schoolyear == 'S3') ||
              (activeFilters[PupilFilter.S4]! && pupil.schoolyear == 'S4') ||
              (!activeFilters[PupilFilter.E1]! &&
                  !activeFilters[PupilFilter.E2]! &&
                  !activeFilters[PupilFilter.E3]! &&
                  !activeFilters[PupilFilter.S3]! &&
                  !activeFilters[PupilFilter.S4]!)) &&
          ((activeFilters[PupilFilter.A1]! && pupil.group == 'A1') ||
              (activeFilters[PupilFilter.A2]! && pupil.group == 'A2') ||
              (activeFilters[PupilFilter.A3]! && pupil.group == 'A3') ||
              (activeFilters[PupilFilter.B1]! && pupil.group == 'B1') ||
              (activeFilters[PupilFilter.B2]! && pupil.group == 'B2') ||
              (activeFilters[PupilFilter.B3]! && pupil.group == 'B3') ||
              (activeFilters[PupilFilter.B4]! && pupil.group == 'B4') ||
              (activeFilters[PupilFilter.C1]! && pupil.group == 'C1') ||
              (activeFilters[PupilFilter.C2]! && pupil.group == 'C2') ||
              (activeFilters[PupilFilter.C3]! && pupil.group == 'C3') ||
              (activeFilters[PupilFilter.A1] == false &&
                  activeFilters[PupilFilter.A2] == false &&
                  activeFilters[PupilFilter.A3] == false &&
                  activeFilters[PupilFilter.B1] == false &&
                  activeFilters[PupilFilter.B2] == false &&
                  activeFilters[PupilFilter.B3] == false &&
                  activeFilters[PupilFilter.B4] == false &&
                  activeFilters[PupilFilter.C1] == false &&
                  activeFilters[PupilFilter.C2] == false &&
                  activeFilters[PupilFilter.C3] == false))) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }
      // Now apply the rest of the filters!

      //- Attendance filters -//

      // Filter pupils present
      if ((activeFilters[PupilFilter.present]! &&
                  pupil.pupilMissedClasses!.any((missedClass) =>
                      missedClass.missedDay.isSameDate(thisDate) &&
                          missedClass.missedType == 'late' ||
                      (pupil.pupilMissedClasses!.firstWhereOrNull(
                              (missedClass) => missedClass.missedDay
                                  .isSameDate(thisDate))) ==
                          null) ||
              pupil.pupilMissedClasses!.isEmpty) &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.present] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      // Filter pupils not present
      if (activeFilters[PupilFilter.notPresent]! &&
          pupil.pupilMissedClasses!.any((missedClass) =>
              missedClass.missedDay.isSameDate(thisDate) &&
              (missedClass.missedType == 'missed' ||
                  missedClass.missedType == 'home' ||
                  missedClass.returned == true)) &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.notPresent] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      // Filter unexcused pupils
      if (activeFilters[PupilFilter.unexcused]! &&
          pupil.pupilMissedClasses!.any((missedClass) =>
              missedClass.missedDay.isSameDate(thisDate) &&
              missedClass.excused == true &&
              missedClass.missedType == 'missed' &&
              toList == true)) {
        toList = true;
      } else if (activeFilters[PupilFilter.unexcused] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      // Filter ogs
      if (activeFilters[PupilFilter.ogs]! &&
          pupil.ogs == true &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.ogs] == false && toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      // Filter not ogs
      if (activeFilters[PupilFilter.notOgs]! &&
          pupil.ogs == false &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.notOgs] == false && toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      //- Development filters -//

      // Filter special needs
      if (activeFilters[PupilFilter.specialNeeds]! &&
          pupil.specialNeeds != null &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.specialNeeds] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }
      // Filter pupils with a development goal

      // Filter pupils with special needs

      //- Learning filters -//

      // Filter migrationSupport
      if (activeFilters[PupilFilter.migrationSupport]! &&
          pupil.specialNeeds != null &&
          toList == true) {
        toList = true;
      } else if (activeFilters[PupilFilter.migrationSupport] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      // Filter pupils with learning goals

      // Filter pupils without learning goals

      // Filter boys
      if (activeFilters[PupilFilter.justBoys]! &&
          pupil.gender == 'm' &&
          toList == true) {
        setFilter(PupilFilter.justGirls, false);
        toList = true;
      } else if (activeFilters[PupilFilter.justBoys] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }

      // Filter girls
      if (activeFilters[PupilFilter.justGirls]! &&
          pupil.gender == 'm' &&
          toList == true) {
        setFilter(PupilFilter.justBoys, false);
        toList = true;
      } else if (activeFilters[PupilFilter.justGirls] == false &&
          toList == true) {
        toList = true;
      } else {
        _filtersOn.value = true;
        toList = false;
      }
      // We're done with filtering - let's add the filtered pupils to the list
      if (toList == true) {
        filteredPupils.add(pupil);
      }
    }
    // Now write it in the manager
    _filteredPupils.value = filteredPupils;
  }

  sortPupils() {
    List<Pupil> filteredPupils = List.from(_filteredPupils.value);
    final sortMode = _sortMode.value;

    // Sort by first Name
    if (sortMode[PupilSortMode.sortByName] == true) {
      filteredPupils.sort((a, b) => a.firstName!.compareTo(b.firstName!));
    }
    // Sort by credit
    if (sortMode[PupilSortMode.sortByCredit] == true) {
      filteredPupils.sort((b, a) => a.credit.compareTo(b.credit));
    }
    // Sort by credit earned
    if (sortMode[PupilSortMode.sortByCreditEarned] == true) {
      filteredPupils.sort((b, a) => a.creditEarned.compareTo(b.creditEarned));
    }
    // Sort by missed excused
    if (sortMode[PupilSortMode.sortByMissedExcused] == true) {
      filteredPupils.sort((a, b) => locator<AttendanceManager>()
          .missedclassSum(b)
          .compareTo(locator<AttendanceManager>().missedclassSum(a)));
    }
    // Sort by missed unexcused
    if (sortMode[PupilSortMode.sortByMissedUnexcused] == true) {
      filteredPupils.sort((a, b) => locator<AttendanceManager>()
          .missedclassUnexcusedSum(b)
          .compareTo(locator<AttendanceManager>().missedclassUnexcusedSum(a)));
    }
    // Sort by late
    if (sortMode[PupilSortMode.sortByLate] == true) {
      filteredPupils.sort((a, b) => locator<AttendanceManager>()
          .lateUnexcusedSum(b)
          .compareTo(locator<AttendanceManager>().lateUnexcusedSum(a)));
    }
    // Sort by contacted
    if (sortMode[PupilSortMode.sortByContacted] == true) {
      filteredPupils.sort((a, b) => locator<AttendanceManager>()
          .contactedSum(b)
          .compareTo(locator<AttendanceManager>().contactedSum(a)));
    }
    _filteredPupils.value = filteredPupils;
  }

  // sortByMissedExcused() {
  //   List<Pupil> filteredPupils = List.from(_filteredPupils.value);
  //   filteredPupils.sort((a, b) => locator<AttendanceManager>()
  //       .missedclassSum(b)
  //       .compareTo(locator<AttendanceManager>().missedclassSum(a)));
  //   _filteredPupils.value = filteredPupils;
  // }

  // sortByName() {
  //   List<Pupil> filteredPupils = List.from(_filteredPupils.value);
  //   filteredPupils.sort((a, b) => a.firstName!.compareTo(b.firstName!));
  //   _filteredPupils.value = filteredPupils;
  // }

  // sortByMissedUnexcused() {
  //   List<Pupil> filteredPupils = List.from(_filteredPupils.value);
  //   filteredPupils.sort((a, b) => locator<AttendanceManager>()
  //       .missedclassUnexcusedSum(b)
  //       .compareTo(locator<AttendanceManager>().missedclassUnexcusedSum(a)));
  //   _filteredPupils.value = filteredPupils;
  // }

  // sortByContacted() {
  //   List<Pupil> filteredPupils = List.from(_filteredPupils.value);
  //   filteredPupils.sort((a, b) => locator<AttendanceManager>()
  //       .contactedSum(b)
  //       .compareTo(locator<AttendanceManager>().contactedSum(a)));
  //   _filteredPupils.value = filteredPupils;
  // }

  // sortByLate() {
  //   List<Pupil> filteredPupils = List.from(_filteredPupils.value);
  //   filteredPupils.sort((a, b) => locator<AttendanceManager>()
  //       .lateUnexcusedSum(b)
  //       .compareTo(locator<AttendanceManager>().lateUnexcusedSum(a)));
  //   _filteredPupils.value = filteredPupils;
  // }
}
