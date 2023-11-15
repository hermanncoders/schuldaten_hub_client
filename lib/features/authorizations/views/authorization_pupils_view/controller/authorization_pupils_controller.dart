import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';

import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/authorization_pupils_view.dart';

class AuthorizationPupils extends StatefulWidget {
  final Authorization schoolList;

  const AuthorizationPupils(
    this.schoolList, {
    Key? key,
  }) : super(key: key);

  @override
  AuthorizationPupilsController createState() =>
      AuthorizationPupilsController();
}

class AuthorizationPupilsController extends State<AuthorizationPupils> {
  FocusNode focusNode = FocusNode();

  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  bool isSearching = false;

  @override
  void initState() {
    locator<PupilFilterManager>().refreshFilteredPupils();
    super.initState();
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
    return AuthorizationPupilsView(this, widget.schoolList);
  }
}
