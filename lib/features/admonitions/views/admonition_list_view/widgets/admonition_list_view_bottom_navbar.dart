import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/features/admonitions/services/admonition_filter_manager.dart';
import 'package:schuldaten_hub/features/admonitions/views/admonition_list_view/widgets/admonition_filter_bottom_sheet.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/pupil/services/pupilbase_manager.dart';

BottomAppBar admonitionListViewBottomNavBar(
    BuildContext context, bool filtersOn) {
  return BottomAppBar(
    padding: const EdgeInsets.all(10),
    shape: null,
    color: backgroundColor,
    child: IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Row(
          children: [
            const Spacer(),
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
            const Gap(30),
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
              onTap: () => showAdmonitionFilterBottomSheet(context),
              onLongPress: () {
                locator<AdmonitionFilterManager>().resetFilters();
                locator<PupilFilterManager>().resetFilters();
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
    ),
  );
}
