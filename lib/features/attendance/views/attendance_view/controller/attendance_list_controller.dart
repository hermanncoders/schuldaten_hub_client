import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/attendance/views/attendance_view/attendance_list_view.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';

import 'package:watch_it/watch_it.dart';

class AttendanceList extends WatchingStatefulWidget {
  const AttendanceList({Key? key}) : super(key: key);

  @override
  AttendanceListController createState() => AttendanceListController();
}

class AttendanceListController extends State<AttendanceList> {
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    locator<PupilFilterManager>().refreshFilteredPupils();

    super.initState();
  }

  int missedPupils(List<Pupil> filteredPupils, DateTime thisDate) {
    List<Pupil> missedPupils = [];
    if (filteredPupils.isNotEmpty) {
      for (Pupil pupil in filteredPupils) {
        if (pupil.pupilMissedClasses!.any((missedClass) =>
            missedClass.missedDay == thisDate &&
            (missedClass.missedType == 'missed' ||
                missedClass.missedType == 'home'))) {
          missedPupils.add(pupil);
        }
      }
      return missedPupils.length;
    }
    return 0;
  }

  int unexcusedPupils(List<Pupil> filteredPupils, DateTime thisDate) {
    List<Pupil> unexcusedPupils = [];

    for (Pupil pupil in filteredPupils) {
      if (pupil.pupilMissedClasses!.any((missedClass) =>
          missedClass.missedDay == thisDate && missedClass.excused == true)) {
        unexcusedPupils.add(pupil);
      }
    }

    return unexcusedPupils.length;
  }

  void cancelSearch({bool unfocus = true}) {
    if (locator<PupilFilterManager>().filterState.value ==
        initialFilterValues) {
      locator<PupilFilterManager>().filtersOnSwitch(false);
      locator<PupilFilterManager>().refreshFilteredPupils();
    }
    setState(() {
      searchController.clear();
      isSearchMode = false;
      isSearching = false;
    });
    locator<PupilFilterManager>().setSearchText('');
    if (unfocus) FocusManager.instance.primaryFocus?.unfocus();
  }

  void onSearchEnter(String text) {
    locator<PupilFilterManager>().filtersOnSwitch(true);
    if (text.isEmpty) {
      cancelSearch(unfocus: false);
      return;
    }
    isSearchMode = true;

    locator<PupilFilterManager>().setSearchText(text);
  }

  @override
  Widget build(BuildContext context) {
    return AttendanceListView(this);
  }
}
