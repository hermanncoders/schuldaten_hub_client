import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/constants/enums.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';
import 'package:schuldaten_hub/features/special_info_view/widgets/special_info_filter_bottom_sheet.dart';

BottomAppBar specialInfoViewBottomNavBar(BuildContext context, bool filtersOn) {
  return BottomAppBar(
    padding: const EdgeInsets.all(10),
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: Row(
        children: <Widget>[
          IconButton(
            tooltip: 'zurück',
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          IconButton(
            tooltip: 'Scan Kinder-IDs',
            icon: const Icon(
              Icons.qr_code_scanner_rounded,
              size: 30,
            ),
            onPressed: () {
              locator<PupilBaseManager>().scanNewPupilBase(context);
            },
          ),
          const Gap(30),
          InkWell(
            onTap: () => showSpecialInfoFilterBottomSheet(context),
            onLongPress: () {
              locator<PupilFilterManager>().resetFilters();

              locator<PupilFilterManager>().setFilter(PupilFilter.ogs, true);
              locator<PupilFilterManager>().filtersOnSwitch(false);
            },
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
