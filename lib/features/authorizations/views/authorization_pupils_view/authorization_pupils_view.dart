import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/widgets/authorization_pupils_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/models/pupil.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/controller/authorization_pupils_controller.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/widgets/authorization_pupil_card.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/widgets/authorization_pupils_bottom_navbar.dart';
import 'package:schuldaten_hub/common/widgets/group_schoolyear_filter_bottom_sheet.dart';

import 'package:schuldaten_hub/common/widgets/search_text_field.dart';

import 'package:watch_it/watch_it.dart';

class AuthorizationPupilsView extends WatchingWidget {
  final AuthorizationPupilsController controller;
  final Authorization authorization;

  const AuthorizationPupilsView(this.controller, this.authorization, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool filtersOn = watchValue((PupilFilterManager x) => x.filtersOn);
    List<Pupil> filteredPupils =
        watchValue((PupilFilterManager x) => x.filteredPupils);
    List<Pupil> pupilsFromList = locator<AuthorizationManager>()
        .getPupilsinAuthorization(
            authorization.authorizationId, filteredPupils);
    List<Pupil> pupilsInList =
        controller.getListResponseFilteredPupils(pupilsFromList);

    Map<PupilFilter, bool> activeFilters =
        watchValue((PupilFilterManager x) => x.filterState);
    return Scaffold(
      backgroundColor: canvasColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.list),
            const Gap(5),
            Text(authorization.authorizationName),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            locator<AuthorizationManager>().fetchAuthorizations(),
        child: pupilsInList.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    'Es sind keine Kinder in dieser Liste!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      children: [
                        const Gap(15),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 10.0, right: 10.00),
                          child: Text(
                            authorization.authorizationDescription.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10.0, right: 10.00),
                          child: Row(
                            children: [
                              const Text(
                                'Kinder in der Liste:',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              const Gap(10),
                              Text(
                                pupilsInList.length.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: searchTextField(
                                'Schüler/in suchen',
                                controller,
                                locator<PupilFilterManager>()
                                    .refreshFilteredPupils,
                              )),
                              //---------------------------------
                              InkWell(
                                onTap: () =>
                                    showAuthorizationPupilsFilterBottomSheet(
                                        context),
                                onLongPress: () => locator<PupilFilterManager>()
                                    .resetFilters(),
                                // onPressed: () => showBottomSheetFilters(context),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.filter_list,
                                    color: filtersOn
                                        ? Colors.deepOrange
                                        : Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        pupilsInList.isEmpty
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Keine Ergebnisse',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    itemCount: pupilsInList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AuthorizationPupilCard(
                                          pupilsInList[index].internalId,
                                          authorization.authorizationId);
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      bottomNavigationBar:
          authorizationPupilsBottomNavBar(context, authorization, filtersOn),
    );
  }
}
