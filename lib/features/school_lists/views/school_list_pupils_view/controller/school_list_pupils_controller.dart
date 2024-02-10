import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/school_lists/models/pupil_list.dart';
import 'package:schuldaten_hub/features/school_lists/models/school_list.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/school_lists/views/school_list_pupils_view/school_list_pupils_view.dart';

class SchoolListPupils extends StatefulWidget {
  final SchoolList schoolList;

  const SchoolListPupils(
    this.schoolList, {
    Key? key,
  }) : super(key: key);

  @override
  SchoolListPupilsController createState() => SchoolListPupilsController();
}

class SchoolListPupilsController extends State<SchoolListPupils> {
  FocusNode focusNode = FocusNode();

  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  final filterLocator = locator<PupilFilterManager>();
  @override
  void initState() {
    //locator<PupilFilterManager>().refreshFilteredPupils();
    super.initState();
  }

  String listOwners() {
    String owners = '';
    if (widget.schoolList.visibility == 'public') {
      return 'Hermannschule';
    }
    if (widget.schoolList.visibility == 'private') {
      return '';
    }
    widget.schoolList.visibility.split('*').forEach((element) {
      if (element.isNotEmpty) {
        owners += ' - $element';
      }
    });
    return owners;
  }

  String shareList(String teacher) {
    String visibility = widget.schoolList.visibility;
    visibility += '*$teacher';
    return visibility;
  }

  int totalShownPupilsMarkedWithYesNoOrNull(
      List<Pupil> pupilsInList, bool? yesNoOrNull) {
    int count = 0;
    for (Pupil pupil in pupilsInList) {
      if (pupil.pupilLists != null) {
        if (pupil.pupilLists!.any((element) =>
            element.originList == widget.schoolList.listId &&
            element.pupilListStatus == yesNoOrNull)) {
          count++;
        }
      }
    }
    debug.info('totalShownPupilsMarkedWithYes: $count');
    return count;
  }

  int totalShownPupilsWithComment(List<Pupil> pupilsInList) {
    int count = 0;
    for (Pupil pupil in pupilsInList) {
      if (pupil.pupilLists != null) {
        if (pupil.pupilLists!.any((element) =>
            element.originList == widget.schoolList.listId &&
            element.pupilListComment != null &&
            element.pupilListComment!.isNotEmpty)) {
          count++;
        }
      }
    }
    return count;
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

  List<Pupil> addPupilListFiltersToFilteredPupils(List<Pupil> pupils) {
    List<Pupil> filteredPupils = [];
    for (Pupil pupil in pupils) {
      bool toList = true;
      final PupilList pupilList = pupil.pupilLists!
          .where(
              (pupilList) => pupilList.originList == widget.schoolList.listId)
          .first;

      if (filterLocator.filterState.value[PupilFilter.schoolListYesResponse]! &&
          pupilList.pupilListStatus == true) {
        toList = true;
      } else if (!filterLocator
          .filterState.value[PupilFilter.schoolListYesResponse]!) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator.filterState.value[PupilFilter.schoolListNoResponse]! &&
          pupilList.pupilListStatus == false) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.schoolListNoResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.schoolListNullResponse]! &&
          pupilList.pupilListStatus == null) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.schoolListNullResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.schoolListCommentResponse]! &&
          pupilList.pupilListComment != null) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.schoolListCommentResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (toList) {
        filteredPupils.add(pupil);
      }
    }
    return filteredPupils;
  }

  @override
  Widget build(BuildContext context) {
    return SchoolListPupilsView(this, widget.schoolList);
  }
}
