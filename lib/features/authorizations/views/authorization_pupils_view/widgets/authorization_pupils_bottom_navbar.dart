import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/features/authorizations/models/authorization.dart';
import 'package:schuldaten_hub/features/authorizations/services/authorization_manager.dart';
import 'package:schuldaten_hub/features/authorizations/views/authorization_pupils_view/widgets/authorization_pupils_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_helper_functions.dart';
import 'package:schuldaten_hub/features/pupil/views/select_pupils_list_view/controller/select_pupils_list_controller.dart';

BottomAppBar authorizationPupilsBottomNavBar(
    BuildContext context,
    Authorization authorization,
    bool filtersOn,
    List<int> pupilsInAuthorization) {
  return BottomAppBar(
    padding: const EdgeInsets.all(9),
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        children: <Widget>[
          const Spacer(),
          IconButton(
            tooltip: 'zurück',
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Gap(30),
          locator<SessionManager>().credentials.value.username ==
                  authorization.createdBy
              ? IconButton(
                  tooltip: 'Kinder hinzufügen',
                  icon: const Icon(Icons.add, color: Colors.white, size: 30),
                  onPressed: () async {
                    final List<int> selectedPupilIds =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) =>
                          SelectPupilList(restOfPupils(pupilsInAuthorization)),
                    ));
                    if (selectedPupilIds.isNotEmpty) {
                      locator<AuthorizationManager>().postPupilAuthorizations(
                          selectedPupilIds, authorization.authorizationId);
                    }
                  })
              : const SizedBox.shrink(),
          const Gap(10),
          InkWell(
            onTap: () => showAuthorizationPupilsFilterBottomSheet(context),
            onLongPress: () => locator<PupilFilterManager>().resetFilters(),
            child: Icon(
              Icons.filter_list,
              color: filtersOn ? Colors.deepOrange : Colors.white,
              size: 30,
            ),
          ),
          const Gap(10)
        ],
      ),
    ),
  );
}
