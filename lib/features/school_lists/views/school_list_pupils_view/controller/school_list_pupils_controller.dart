import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
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
        owners += '$element, ';
      }
    });
    return widget.schoolList.visibility;
  }

  String shareList(String teacher) {
    String visibility = widget.schoolList.visibility;
    visibility += '*$teacher';
    return visibility;
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
    return SchoolListPupilsView(this, widget.schoolList);
  }
}
