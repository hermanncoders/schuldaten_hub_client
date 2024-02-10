import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';

import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/authorizations/models/pupil_authorization.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/authorization_pupils_view.dart';

class AuthorizationPupils extends StatefulWidget {
  final Authorization authorization;

  const AuthorizationPupils(
    this.authorization, {
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
  final filterLocator = locator<PupilFilterManager>();

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

  List<Pupil> addAuthorizationFiltersToFilteredPupils(List<Pupil> pupils) {
    List<Pupil> filteredPupils = [];
    for (Pupil pupil in pupils) {
      bool toList = true;
      final PupilAuthorization pupilAuthorization = pupil.authorizations!
          .where((pupilAuthorization) =>
              pupilAuthorization.originAuthorization ==
              widget.authorization.authorizationId)
          .first;

      if (filterLocator
              .filterState.value[PupilFilter.authorizationYesResponse]! &&
          pupilAuthorization.status == true) {
        toList = true;
      } else if (!filterLocator
          .filterState.value[PupilFilter.authorizationYesResponse]!) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.authorizationNoResponse]! &&
          pupilAuthorization.status == false) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.authorizationNoResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.authorizationNullResponse]! &&
          pupilAuthorization.status == null) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.authorizationNullResponse]! &&
          toList == true) {
        toList = true;
      } else {
        toList = false;
      }
      if (filterLocator
              .filterState.value[PupilFilter.authorizationCommentResponse]! &&
          pupilAuthorization.status != null) {
        toList = true;
      } else if (!filterLocator
              .filterState.value[PupilFilter.authorizationCommentResponse]! &&
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
    return AuthorizationPupilsView(this, widget.authorization);
  }
}
