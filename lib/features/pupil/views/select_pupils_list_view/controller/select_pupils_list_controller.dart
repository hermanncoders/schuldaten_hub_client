import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_view/select_pupils_list_view.dart';

import 'package:watch_it/watch_it.dart';
import '../../../models/pupil.dart';

class SelectPupilList extends WatchingStatefulWidget {
  const SelectPupilList({Key? key}) : super(key: key);

  @override
  SelectPupilListController createState() => SelectPupilListController();
}

class SelectPupilListController extends State<SelectPupilList> {
  List<Pupil>? pupils;
  List<Pupil>? filteredPupils;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  List<int> selectedPupilIds = [];
  bool isSelectAllMode = false;
  bool isSelectMode = false;

  @override
  void initState() {
    locator<PupilFilterManager>().refreshFilteredPupils();
    setState(() {
      pupils = locator<PupilManager>().pupils.value;
      filteredPupils = List.from(pupils!);
    });
    super.initState();
  }

  // void getPupilsFromServer() async {
  //   if (filteredPupils == []) {
  //     return;
  //   }
  //   final List<int> pupilsToFetch = [];
  //   for (Pupil pupil in filteredPupils!) {
  //     pupilsToFetch.add(pupil.internalId);
  //   }
  //   await locator.get<PupilManager>().fetchPupilsById(pupilsToFetch);
  // }

  void search() async {
    if (!isSearching) {
      setState(() {
        isSearching = true;
      });
    }

    if (!isSearchMode) return;
    setState(() {
      isSearching = false;
    });
  }

  void cancelSelect() {
    setState(() {
      selectedPupilIds.clear();
      isSelectMode = false;
    });
  }

  void cancelSearch({bool unfocus = true}) {
    setState(() {
      searchController.clear();
      isSearchMode = false;
      locator<PupilFilterManager>().setSearchText('');
      filteredPupils = List.from(pupils!);
      isSearching = false;
    });

    if (unfocus) FocusManager.instance.primaryFocus?.unfocus();
  }

  void onCardPress(int pupilId) {
    if (selectedPupilIds.contains(pupilId)) {
      setState(() {
        selectedPupilIds.remove(pupilId);
        if (selectedPupilIds.isEmpty) {
          isSelectMode = false;
        }
      });
    } else {
      setState(() {
        selectedPupilIds.add(pupilId);
        isSelectMode = true;
      });
    }
  }

  void clearAll() {
    setState(() {
      isSelectMode = false;
      selectedPupilIds.clear();
    });
  }

  void toggleSelectAll() {
    setState(() {
      isSelectAllMode = !isSelectAllMode;
      if (isSelectAllMode) {
        final List<Pupil> shownPupils =
            locator<PupilFilterManager>().filteredPupils.value;
        isSelectMode = true;
        selectedPupilIds =
            shownPupils.map((pupil) => pupil.internalId).toList();
      } else {
        isSelectMode = false;
        selectedPupilIds.clear();
      }
    });
  }

  List<int> getSelectedPupilIds() {
    return selectedPupilIds.toList();
  }

  void onSearchEnter(String text) {
    if (text.isEmpty) {
      cancelSearch(unfocus: false);
      return;
    }
    isSearchMode = true;
    locator<PupilFilterManager>().setSearchText(text);
    setState(() {
      // final pupils = locator<PupilFilterManager>().filteredPupils.value;
      // isSearchMode = true;
      // filteredPupils = pupils
      //     .where(
      //       (user) =>
      //           user.firstName!.toLowerCase().contains(text.toLowerCase()),
      //     )
      //     .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectPupilListView(this);
  }
}
