import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/admonitions/models/admonition.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/admonition_list_view.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_manager.dart';
import 'package:watch_it/watch_it.dart';

import '../../../../pupil/models/pupil.dart';

class AdmonitionList extends WatchingStatefulWidget {
  const AdmonitionList({Key? key}) : super(key: key);

  @override
  AdmonitionListController createState() => AdmonitionListController();
}

class AdmonitionListController extends State<AdmonitionList> {
  List<Pupil>? pupils;
  List<Pupil>? filteredPupils;
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    locator<PupilFilterManager>().refreshFilteredPupils();
    pupils = locator<PupilManager>().pupils.value;
    super.initState();
  }

  void getPupilsFromServer() async {
    if (filteredPupils == []) {
      return;
    }
    final List<int> pupilsToFetch = [];
    for (Pupil pupil in filteredPupils!) {
      pupilsToFetch.add(pupil.internalId);
    }
    await locator.get<PupilManager>().fetchPupilsById(pupilsToFetch);
  }

  // void _search() async {
  //   if (!isSearching) {
  //     setState(() {
  //       isSearching = true;
  //     });
  //   }

  //   if (!isSearchMode) return;
  //   setState(() {
  //     isSearching = false;
  //   });
  // }

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
    return AdmonitionListView(this);
  }
}
