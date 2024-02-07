import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

import '../../../../../common/services/session_manager.dart';

BottomAppBar schoolListPupilsBottomNavBar(BuildContext context, PupilLi) {
  return BottomAppBar(
    padding: const EdgeInsets.all(9),
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: 'Open navigation menu',
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),

          // locator<SessionManager>().credentials.value.username ==
          //         authorization.createdBy
          //     ? InkWell(
          //         onTap: () =>
          //             showAuthorizationPupilsFilterBottomSheet(context),
          //         child: const Icon(Icons.add, color: Colors.white, size: 30),
          //       )
          //     : const SizedBox.shrink(),
          // InkWell(
          //   onTap: () => showAuthorizationPupilsFilterBottomSheet(context),
          //   onLongPress: () => locator<PupilFilterManager>().resetFilters(),
          //   child: Icon(
          //     Icons.filter_list,
          //     color: filtersOn ? Colors.deepOrange : Colors.white,
          //     size: 30,
          //   ),
          // ),
          // const Gap(10)
        ],
      ),
    ),
  );
}
